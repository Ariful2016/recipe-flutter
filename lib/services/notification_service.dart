import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  Future<void> initialize(BuildContext context) async{
    try{
      //Request permission
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized){
        await FirebaseAnalytics.instance.logEvent(
            name: 'notification_permission_granted'
        );
      }
      
      //Initialize local notification channel
      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@drawable/notification');
      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings
      );
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) =>
            _handleNotificationTap(context, response.payload),
      );

      //Create android notification channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'recipe_notification',
          'Recipe Notification',
        description: 'Notification for Recipe app update',
        importance: Importance.high
      );
      await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

      //Set foreground notification presentation options
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
      );
      
      //Handle foreground message 
      FirebaseMessaging.onMessage.listen((RemoteMessage message){
        _handleForegroundMessage(context, message);
      });
      
      //Handle background message 
      FirebaseMessaging.onBackgroundMessage(_firebaseMessa)
    }
  }

  void _handleForegroundMessage(BuildContext context, RemoteMessage message) {
    
  }
  
  void _handleNotificationTap(BuildContext context, String? payload) {

  }

 
}