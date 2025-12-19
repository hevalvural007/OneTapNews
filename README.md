# One Tap News 📰

A modern Flutter news application that aggregates news from various categories including Sports, Finance, Technology, Politics, Turkish News, and Music. Built with Firebase authentication and NewsAPI integration.

## 📱 About the App / Uygulama Hakkında

### English
One Tap News is a comprehensive news aggregation mobile application built with Flutter. The app provides users with real-time news articles from multiple categories, allowing them to stay informed about topics that matter to them. Users can create accounts, customize their favorite news categories, search for specific articles, and interact with news content through comments.

**Key Features:**
- 🔐 User authentication (Email/Password & Google Sign-In)
- 📰 News articles from 7 different categories
- 🔍 Real-time search functionality
- 👤 User profile management
- ⭐ Favorite categories selection
- 💬 Comment system on articles
- 🌐 External link support for full articles

### Türkçe
One Tap News, Flutter ile geliştirilmiş kapsamlı bir haber toplama mobil uygulamasıdır. Uygulama, kullanıcılara birden fazla kategoriden gerçek zamanlı haber makaleleri sunarak, ilgilendikleri konulardan haberdar olmalarını sağlar. Kullanıcılar hesap oluşturabilir, favori haber kategorilerini özelleştirebilir, belirli makaleler için arama yapabilir ve yorumlar aracılığıyla haber içeriğiyle etkileşime geçebilir.

**Temel Özellikler:**
- 🔐 Kullanıcı kimlik doğrulama (E-posta/Şifre & Google Girişi)
- 📰 7 farklı kategoriden haber makaleleri
- 🔍 Gerçek zamanlı arama işlevselliği
- 👤 Kullanıcı profil yönetimi
- ⭐ Favori kategoriler seçimi
- 💬 Makalelerde yorum sistemi
- 🌐 Tam makaleler için harici bağlantı desteği

---

## 🛠️ Technologies Used / Kullanılan Teknolojiler

### Frontend / Arayüz
- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language
- **Material Design** - UI/UX design system

### Backend & Services / Backend ve Servisler
- **Firebase Authentication** - User authentication and management
- **Cloud Firestore** - NoSQL database for user data and comments
- **Google Sign-In** - Social authentication
- **NewsAPI** - News articles API service
- **Dio** - HTTP client for API requests

### UI Components / UI Bileşenleri
- **Font Awesome Flutter** - Icon library
- **Google Nav Bar** - Customizable bottom navigation bar
- **URL Launcher** - Opening external links

---

## 📋 Prerequisites / Ön Gereksinimler

- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Firebase project setup
- NewsAPI account (free tier available)

---

## 🚀 Getting Started / Başlangıç

### 1. Clone the Repository / Depoyu Klonlayın

```bash
git clone https://github.com/hevalvural007/ot_news.git
cd ot_news
```

### 2. Install Dependencies / Bağımlılıkları Yükleyin

```bash
flutter pub get
```

### 3. Firebase Setup / Firebase Kurulumu

#### English
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication with Email/Password and Google Sign-In
3. Create a Firestore database
4. Download `google-services.json` for Android and place it in `android/app/`
5. Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`
6. Update `lib/firebase_options.dart` with your Firebase configuration

#### Türkçe
1. [Firebase Console](https://console.firebase.google.com/) adresinde bir Firebase projesi oluşturun
2. E-posta/Şifre ve Google Girişi ile Kimlik Doğrulamayı etkinleştirin
3. Bir Firestore veritabanı oluşturun
4. Android için `google-services.json` dosyasını indirin ve `android/app/` klasörüne yerleştirin
5. iOS için `GoogleService-Info.plist` dosyasını indirin ve `ios/Runner/` klasörüne yerleştirin
6. Firebase yapılandırmanızla `lib/firebase_options.dart` dosyasını güncelleyin

### 4. NewsAPI Key Setup / NewsAPI Anahtarı Kurulumu

#### English
The app requires a NewsAPI key to fetch news articles. You can get a free API key from [NewsAPI.org](https://newsapi.org/).

**Flutter:**
The app uses compile-time environment variables. Set your API key when running the app:

**Windows:**
```bash
flutter run --dart-define=API_KEY=your_api_key_here
```

**Linux/Mac:**
```bash
flutter run --dart-define=API_KEY=your_api_key_here
```

**For Production Build:**
```bash
flutter build apk --dart-define=API_KEY=your_api_key_here
flutter build ios --dart-define=API_KEY=your_api_key_here
```

**Alternative: Using Environment Variables**

You can also set it as an environment variable:

**Windows (PowerShell):**
```powershell
$env:API_KEY="your_api_key_here"
flutter run
```

**Linux/Mac:**
```bash
export API_KEY=your_api_key_here
flutter run
```

#### Türkçe
Uygulama haber makalelerini çekmek için bir NewsAPI anahtarı gerektirir. [NewsAPI.org](https://newsapi.org/) adresinden ücretsiz bir API anahtarı alabilirsiniz.


**Flutter:**
Uygulama derleme zamanı ortam değişkenlerini kullanır. Uygulamayı çalıştırırken API anahtarınızı ayarlayın:

**Windows:**
```bash
flutter run --dart-define=API_KEY=api_anahtariniz_buraya
```

**Linux/Mac:**
```bash
flutter run --dart-define=API_KEY=api_anahtariniz_buraya
```

**Production Build için:**
```bash
flutter build apk --dart-define=API_KEY=api_anahtariniz_buraya
flutter build ios --dart-define=API_KEY=api_anahtariniz_buraya
```

**Alternatif: Ortam Değişkenleri Kullanarak**

Bunu bir ortam değişkeni olarak da ayarlayabilirsiniz:

**Windows (PowerShell):**
```powershell
$env:API_KEY="api_anahtariniz_buraya"
flutter run
```

**Linux/Mac:**
```bash
export API_KEY=api_anahtariniz_buraya
flutter run
```

### 5. Run the App / Uygulamayı Çalıştırın

```bash
flutter run
```

---

## 📁 Project Structure / Proje Yapısı

```
lib/
├── data/
│   └── entity/             # Data models
│       ├── article.dart
│       ├── response.dart
│       └── source.dart
├── services/
│   └── auth_service.dart   # Authentication service
├── ui/
│   └── screens/            # UI screens
│       ├── account_screen.dart
│       ├── details_screen.dart
│       ├── home_screen.dart
│       ├── login_screen.dart
│       ├── main_screen.dart
│       ├── search_screen.dart
│       ├── sign_in_screen.dart
│       ├── sign_up_screen.dart
│       └── tab_screen.dart
├── firebase_options.dart   # Firebase configuration
└── main.dart               # App entry point
```

---

## 🎯 Features / Özellikler

### Authentication / Kimlik Doğrulama
- Email/Password registration and login
- Google Sign-In integration
- Secure session management

### News Categories / Haber Kategorileri
- 🌐 General News
- ⚽ Sports
- 💰 Finance/Business
- 💻 Technology
- 🏛️ Politics
- 🇹🇷 Turkish News
- 🎵 Music

### User Features / Kullanıcı Özellikleri
- Customizable favorite categories
- Search functionality with debouncing
- Article comments system
- User profile management
- External article links

---

## 🔧 Configuration / Yapılandırma

### Firestore Database Structure / Firestore Veritabanı Yapısı

**Users Collection:**
```json
{
  "email": "user@example.com",
  "username": "username",
  "uid": "user_id",
  "createdAt": "timestamp",
  "favoriteList": ["Sports", "Technology"]
}
```

**Comments Collection:**
```json
{
  "articleUrl": "article_url",
  "comment": "comment_text",
  "username": "username",
  "createdAt": "timestamp"
}
```

---

## 📝 Notes / Notlar

- The app uses NewsAPI's free tier which has rate limits
- Make sure to configure Firebase properly before running
- API key must be set before building the app
- The app supports both Android and iOS platforms

---

## 🤝 Contributing / Katkıda Bulunma

Contributions are welcome! Please feel free to submit a Pull Request.

Katkılarınızı bekliyoruz! Lütfen bir Pull Request göndermekten çekinmeyin.

---

## 📄 License / Lisans

This project is open source and available under the [MIT License](LICENSE).

Bu proje açık kaynaklıdır ve [MIT Lisansı](LICENSE) altında mevcuttur.

---

## 👨‍💻 Author / Yazar

Developed with ❤️ using Flutter by Heval Vural

Flutter ile ❤️ ile geliştirilmiştir by Heval Vural

---

## 🔗 Links / Bağlantılar

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [NewsAPI Documentation](https://newsapi.org/docs)

---

## ⚠️ Important / Önemli

**Remember to:**
- Never commit your API keys to version control
- Keep your Firebase configuration files secure
- Use environment variables for sensitive data

**Unutmayın:**
- API anahtarlarınızı versiyon kontrolüne asla commit etmeyin
- Firebase yapılandırma dosyalarınızı güvende tutun
- Hassas veriler için ortam değişkenlerini kullanın
