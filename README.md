# VeilNet Rift

A modern Flutter application for managing VeilNet connections, portals, and rifts with a beautiful, responsive UI.

## 🚀 Features

- **Cross-Platform Support**: Works on Windows, macOS, Linux, Android, and iOS
- **Real-time Connection Management**: Monitor and manage VeilNet connections in real-time
- **Portal & Rift Management**: View and manage both public and private portals and rifts
- **Authentication System**: Secure user authentication with Supabase
- **Modern UI**: Beautiful glass-morphism design with dark/light theme support
- **System Tray Integration**: Desktop apps run in system tray for easy access
- **VPN Integration**: Native VPN support for Android devices
- **Real-time Updates**: Live updates from Supabase for connection status

## 📋 Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.7.2 or higher)
- [Dart](https://dart.dev/get-dart) (3.0.0 or higher)
- [Android Studio](https://developer.android.com/studio) (for Android development)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, macOS only)
- [Visual Studio](https://visualstudio.microsoft.com/) (for Windows development)

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/veilnet-rift.git
   cd veilnet-rift
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure platform-specific settings**

   ### Android
   - Ensure Android SDK is properly configured
   - For VPN functionality, the app requires VPN permissions

   ### iOS
   - Open `ios/Runner.xcworkspace` in Xcode
   - Configure signing and capabilities as needed

   ### Windows
   - Ensure Visual Studio with C++ development tools is installed
   - The app requires administrator privileges for VPN functionality

   ### macOS
   - Open `macos/Runner.xcworkspace` in Xcode
   - Configure signing and capabilities

4. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── components/          # Reusable UI components
│   ├── auth_guard.dart
│   ├── custom_appbar.dart
│   ├── custom_drawer.dart
│   ├── domain_card.dart
│   ├── glass_card.dart
│   ├── login_form.dart
│   ├── sign_up_form.dart
│   └── veilnet_status_card.dart
├── providers/           # State management with Riverpod
│   ├── api_provider.dart
│   ├── domain_provider.dart
│   ├── portal_provider.dart
│   ├── rift_provider.dart
│   ├── user_provider.dart
│   └── veilnet_provider.dart
├── screens/             # Main application screens
│   ├── auth_screen.dart
│   ├── home_screen.dart
│   ├── portal_screen.dart
│   └── daemon_screen.dart
├── main.dart            # Application entry point
└── tray_wrapper.dart    # System tray integration
```

## 🔧 Configuration

### Supabase Setup
The app uses Supabase for authentication and real-time data. The configuration is already set up in `main.dart`:

```dart
await Supabase.initialize(
  url: 'https://supabase.veilnet.org',
  anonKey: 'your-anon-key',
);
```

### Environment Variables
For production, consider moving sensitive configuration to environment variables.

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Windows
```bash
flutter build windows --release
```

### macOS
```bash
flutter build macos --release
```

### Linux
```bash
flutter build linux --release
```

## 📱 Usage

1. **Authentication**: Sign up or log in with your VeilNet account
2. **Dashboard**: View your MP (Minutes of Participation) and portal status
3. **Domains**: Browse available public and private domains
4. **Connections**: Connect to domains using VeilNet Rifts
5. **Portals**: Manage your hosted portals
6. **System Tray**: On desktop, the app runs in the system tray for easy access

## 🔒 Security

- All communications are encrypted
- VPN connections use secure protocols
- User data is protected and not logged
- Authentication is handled securely through Supabase

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the terms specified in the [VeilNet Terms of Service](https://www.veilnet.org/term-of-services/).

## 🆘 Support

- **Documentation**: [VeilNet Docs](https://docs.veilnet.org)
- **Issues**: [GitHub Issues](https://github.com/your-username/veilnet-rift/issues)
- **Community**: [VeilNet Community](https://community.veilnet.org)

## 🏢 About VeilNet

VeilNet is a decentralized VPN network that provides secure, private internet access through a community-driven infrastructure. Users can earn MP (Minutes of Participation) by hosting portals and consume them by using rifts.

For more information, visit [veilnet.org](https://www.veilnet.org).

---

**Note**: This application requires a VeilNet account and may require VPN permissions on your device.
