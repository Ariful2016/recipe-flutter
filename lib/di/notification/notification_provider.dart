// Provider for NotificationService
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError('NotificationService must be initialized with a navigatorKey');
});