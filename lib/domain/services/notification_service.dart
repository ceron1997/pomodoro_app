// This file defines the NotificationService interface,
// which abstracts the functionality for playing sound notifications in the app.
// By defining this as an interface, we can easily
// swap out implementations for different platforms or testing scenarios.

abstract class NotificationService {
  Future<void> playDing();
}
