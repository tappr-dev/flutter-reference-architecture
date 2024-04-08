import '../domain/user.dart';

class CurrentUser {
  Future<User> get() async => User(
      accessToken:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNtZmVqc3dma3Fua3F0ZWFvZmVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIyNjc5MDMsImV4cCI6MjAyNzg0MzkwM30.XxgeHkRH7i5Z0yVvYzPM4vNB4Mj4grBlD3DFrOTInTA');
}
