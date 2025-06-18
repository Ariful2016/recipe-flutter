import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../widgets/dialog/custom_alert_dialog.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize(BuildContext context) async {
    try {
      //Request permission
      NotificationSettings settings =
          await _fcm.requestPermission(alert: true, badge: true, sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await FirebaseAnalytics.instance
            .logEvent(name: 'notification_permission_granted');
      }

      //Initialize local notification channel
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@drawable/notification');

      const InitializationSettings initSettings =
          InitializationSettings(android: androidSettings);

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) =>
            _handleNotificationTap(context, response.payload),
      );

      //Create android notification channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'recipe_notification', 'Recipe Notification',
          description: 'Notification for Recipe app update',
          importance: Importance.high);
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      //Set foreground notification presentation options
      await _fcm.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true
      );

      //Handle foreground message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleForegroundMessage(context, message);
      });

      //Handle background message
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Handle notification tap when app is in background or terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationTap(context, message.data['route']);
      });

      // Handle initial message (app opened from terminated state)
      RemoteMessage? initMessage = await _fcm.getInitialMessage();
      if (initMessage != null) {
        _handleNotificationTap(context, initMessage.data['route']);
      }

      // Log token refresh
      _fcm.onTokenRefresh.listen((token) {
        FirebaseAnalytics.instance
            .logEvent(name: 'fcm_token_refresh', parameters: {'token': token});
        // TODO: Send token to your server
      });

      // Get and log FCM token
      String? token = await _fcm.getToken();
      if (token != null) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'fcm_token',
          parameters: {'token': token},
        );
      }
    } catch (e, stack) {
      await FirebaseCrashlytics.instance
          .recordError(e, stack, reason: 'Notification initialization failed');
    }
  }

  void _handleForegroundMessage(BuildContext context, RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      // Show local notification for foreground
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              'recipe_notification', 'Recipe Notification',
              channelDescription: 'Notification for Recipe app update',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@drawable/notification_icon'),
        ),
        payload: message.data['route'],
      );

      // Show CustomAlertDialog for foreground notifications
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

  void _handleNotificationTap(BuildContext context, String? route) {
    if (route != null) {
      FirebaseAnalytics.instance
          .logEvent(name: 'notification_tap', parameters: {'route': route});
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    // Log background message
    await FirebaseAnalytics.instance.logEvent(
        name: 'background_notification_received',
        parameters: {'message_id': message.messageId ?? 'unknown'});
  }
}
