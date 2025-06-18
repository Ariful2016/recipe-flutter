import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/router/app_router.dart';
import '../core/constants/constants.dart';
import '../widgets/dialog/custom_alert_dialog.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState>? navigatorKey;
  String? _fcmToken;
  RemoteMessage? _pendingMessage;
  bool _isInitializing = false;

  NotificationService({this.navigatorKey});

  String? get fcmToken => _fcmToken;

  Future<void> initialize(BuildContext context) async {
    if (_isInitializing) return;
    _isInitializing = true;

    try {
      await Firebase.initializeApp();

      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'notification_permission_granted',
        );
      }

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@drawable/notification');
      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings();
      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) =>
            _handleNotificationTap(response.payload),
      );

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'recipe_notifications',
        'Recipe Notifications',
        description: 'Notifications for Recipe app updates',
        importance: Importance.high,
      );
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleForegroundMessage(context, message);
      });

      try {
        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);
      } catch (e, stack) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          reason: 'Failed to register background message handler',
        );
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _pendingMessage = message;
        _handleNotificationTap(message.data['route']);
      });

      RemoteMessage? initialMessage = await _fcm.getInitialMessage();
      if (initialMessage != null) {
        _pendingMessage = initialMessage;
        _handleNotificationTap(initialMessage.data['route']);
      }

      _fcm.onTokenRefresh.listen((token) async {
        _fcmToken = token;
        await FirebaseAnalytics.instance.logEvent(
          name: 'fcm_token_refreshed',
          parameters: {'token': token},
        );
// TODO: Send token to your server
      });

      _fcmToken = await _fcm.getToken();
      if (_fcmToken != null) {
        debugPrint('FCM Token: $_fcmToken');
        await FirebaseAnalytics.instance.logEvent(
          name: 'fcm_token',
          parameters: {'token': _fcmToken!},
        );
// TODO: Send token to your server
      }
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Notification initialization failed',
      );
    } finally {
      _isInitializing = false;
    }
  }

  Future<String?> fetchToken() async {
    try {
      _fcmToken = await _fcm.getToken();
      if (_fcmToken != null) {
        debugPrint('Fetched FCM Token: $_fcmToken');
        await FirebaseAnalytics.instance.logEvent(
          name: 'fcm_token_fetched',
          parameters: {'token': _fcmToken!},
        );
      }
      return _fcmToken;
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to fetch FCM token',
      );
      return null;
    }
  }

  void _handleForegroundMessage(BuildContext context, RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'recipe_notifications',
            'Recipe Notifications',
            channelDescription: 'Notifications for Recipe app updates',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/notification',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data['route'],
      );

      showCustomAlertDialog(
        context,
        type: AlertType.custom,
        title: notification.title ?? 'New Notification',
        message: notification.body ?? '',
        icon: Icons.notifications,
        primaryButtonText: 'View',
        secondaryButtonText: 'Dismiss',
        primaryButtonAction: () {
          Navigator.of(context).pop();
          if (message.data['route'] != null) {
            context.goNamed(message.data['route']);
          }
        },
        secondaryButtonAction: () => Navigator.of(context).pop(),
      );
    }
  }

  void _handleNotificationTap(String? route) {
    final context = navigatorKey?.currentContext;
    if (context == null) {
      debugPrint('Navigator context is null, queuing action for later');
      FirebaseCrashlytics.instance.recordError(
        Exception('Navigator context is null'),
        StackTrace.current,
        reason: 'Failed to handle notification tap - context unavailable',
      );
// Queue the action to retry when context is available
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final fallbackContext = navigatorKey?.currentContext;
        if (fallbackContext != null) {
          _handleNotificationTapWithContext(fallbackContext, route);
        }
      });
      return;
    }

    _handleNotificationTapWithContext(context, route);
  }

  void _handleNotificationTapWithContext(BuildContext context, String? route) {
// Validate route against AppRouter.validRouteNames
    route = route != null && AppRouter.validRouteNames.contains(route)
        ? route
        : null;

    if (_pendingMessage != null) {
      final notification = _pendingMessage!.notification;
      showCustomAlertDialog(
        context,
        type: AlertType.custom,
        title: notification?.title ?? 'Notification',
        message: notification?.body ?? 'No message provided',
        icon: Icons.notifications,
        primaryButtonText: 'View',
        secondaryButtonText: 'Dismiss',
        primaryButtonAction: () {
          Navigator.of(context).pop();
          if (route != null) {
            context.goNamed(route);
          }
          _pendingMessage = null;
        },
        secondaryButtonAction: () {
          Navigator.of(context).pop();
          _pendingMessage = null;
        },
      );
    } else if (route != null) {
      showCustomAlertDialog(
        context,
        type: AlertType.custom,
        title: 'Notification',
        message: 'Tapped to view details',
        icon: Icons.notifications,
        primaryButtonText: 'View',
        secondaryButtonText: 'Dismiss',
        primaryButtonAction: () {
          Navigator.of(context).pop();
          context.goNamed(route!);
        },
        secondaryButtonAction: () => Navigator.of(context).pop(),
      );
    }

    if (route != null) {
      FirebaseAnalytics.instance.logEvent(
        name: 'notification_tapped',
        parameters: {'route': route},
      );
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    await FirebaseAnalytics.instance.logEvent(
      name: 'background_notification_received',
      parameters: {'message_id': message.messageId ?? 'unknown'},
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'recipe_notifications',
      'Recipe Notifications',
      description: 'Notifications for Recipe app updates',
      importance: Importance.high,
    );
    final FlutterLocalNotificationsPlugin localNotifications =
        FlutterLocalNotificationsPlugin();
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final notification = message.notification;
    if (notification != null) {
      await localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'recipe_notifications',
            'Recipe Notifications',
            channelDescription: 'Notifications for Recipe app updates',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/notification',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: message.data['route'],
      );
    }
  } catch (e, stack) {
    await FirebaseCrashlytics.instance.recordError(
      e,
      stack,
      reason: 'Background notification handling failed',
    );
  }
}
