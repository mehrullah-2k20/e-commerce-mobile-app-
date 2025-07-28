# Flutter eCommerce App

A complete, functional Flutter eCommerce application built with Flutter 3.19.6, featuring Firebase Firestore integration, cart management, and modern Material 3 UI.

## Features

- **Product Listing**: Browse products fetched from Firebase Firestore
- **Product Details**: View detailed product information
- **Shopping Cart**: Add/remove items with quantity management using Provider state management
- **Checkout**: Complete order process with form validation
- **Responsive UI**: Modern Material 3 design with responsive layout
- **Real-time Updates**: Products are updated in real-time from Firestore

## Tech Stack

- **Flutter**: 3.19.6
- **Firebase Firestore**: Real-time database for product data
- **Provider**: State management for shopping cart
- **Material 3**: Modern UI design system

## Project Structure

```
lib/
├── main.dart                     # App entry point with Firebase initialization
├── firebase_options.dart         # Firebase configuration
├── models/
│   ├── product.dart             # Product data model
│   └── cart_item.dart           # Cart item model
├── providers/
│   └── cart_provider.dart       # Cart state management
├── services/
│   └── firestore_service.dart   # Firebase Firestore operations
├── screens/
│   ├── home_screen.dart         # Product listing page
│   ├── product_detail_screen.dart # Product details page
│   ├── cart_screen.dart         # Shopping cart page
│   ├── checkout_screen.dart     # Order checkout page
│   └── admin_screen.dart        # Admin panel for adding sample data
└── widgets/
    └── product_card.dart        # Reusable product card component
```

## Setup Instructions

### 1. Firebase Setup

1. **Create Firebase Project**:

   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Firestore Database

2. **Add Flutter App to Firebase**:

   - In your Firebase project, click "Add app" and select Flutter
   - Follow the setup wizard

3. **Configure Firebase for Flutter**:

   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli

   # Configure your app (run from project root)
   flutterfire configure
   ```

   This will:

   - Generate `lib/firebase_options.dart`
   - Download configuration files for Android/iOS

4. **Update Android Configuration**:
   - The `google-services.json` file should be placed in `android/app/`
   - You mentioned you've already added this file ✅

### 2. Dependencies

All required dependencies are already added to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.32.0
  cloud_firestore: ^4.17.5
  provider: ^6.1.2
  cupertino_icons: ^1.0.6
```

### 3. Firestore Database Setup

1. **Create Products Collection**:

   - In Firebase Console, go to Firestore Database
   - Create a collection named `products`

2. **Add Sample Products** (Option 1 - Using the App):

   - Run the app
   - Tap the admin icon (⚙️) in the home screen app bar
   - Tap "Add Sample Products" to populate your database

3. **Add Sample Products** (Option 2 - Manual):
   Add documents with these fields to the `products` collection:
   ```json
   {
     "name": "iPhone 15 Pro",
     "description": "Latest iPhone with A17 Pro chip and titanium design",
     "price": 999.99,
     "imageUrl": "https://via.placeholder.com/300x300/007BFF/FFFFFF?text=iPhone+15+Pro"
   }
   ```

### 4. Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Firestore Security Rules

For development, you can use these Firestore rules (make them more restrictive for production):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read access to products
    match /products/{document} {
      allow read: if true;
      allow write: if true; // Restrict this in production
    }
  }
}
```

## App Screenshots & Features

### Home Screen

- Grid layout of products
- Cart icon with item count badge
- Pull-to-refresh functionality
- Loading states and error handling

### Cart Screen

- List of added items with quantities
- Increase/decrease quantity controls
- Remove items functionality
- Total calculation
- Empty cart state

### Checkout Screen

- Order summary
- Shipping information form
- Form validation
- Order processing simulation

### Admin Panel (Debug)

- Add sample products to Firestore
- Accessible via admin icon in home screen

## State Management

The app uses **Provider** for state management:

- `CartProvider`: Manages shopping cart state
  - Add/remove items
  - Update quantities
  - Calculate totals
  - Persist cart state during app session

## Firebase Integration

The app integrates with Firebase Firestore for:

- **Real-time product fetching**: Products are streamed from Firestore
- **Automatic updates**: UI updates when products change in database
- **Error handling**: Graceful handling of network and database errors

## Key Flutter Concepts Demonstrated

- **State Management**: Provider pattern
- **Navigation**: Named routes and programmatic navigation
- **Form Handling**: Validation and user input
- **Async Operations**: Future/Stream handling with Firebase
- **Error Handling**: Network and database error states
- **Responsive Design**: Adaptable layouts for different screen sizes
- **Material 3**: Modern UI components and theming

## Testing the App

1. **Add Products**: Use the admin panel to add sample products
2. **Browse Products**: View products on the home screen
3. **Add to Cart**: Tap the cart icon on product cards
4. **View Cart**: Check cart contents and modify quantities
5. **Checkout**: Complete the order process

## Production Considerations

Before deploying to production:

1. **Update Firebase Security Rules**: Restrict write access
2. **Replace Placeholder Images**: Use real product images
3. **Add Authentication**: Implement user login/signup
4. **Payment Integration**: Add real payment processing
5. **Error Tracking**: Implement error tracking (Crashlytics)
6. **Performance**: Optimize images and add caching

## Troubleshooting

### Common Issues

1. **Firebase not initialized**: Ensure `Firebase.initializeApp()` is called in `main()`
2. **Missing google-services.json**: Ensure the file is in `android/app/`
3. **Firestore permission denied**: Check Firestore security rules
4. **Build errors**: Run `flutter clean` and `flutter pub get`

### Debug Tips

- Use the admin panel to quickly add test data
- Check Firebase Console for data and errors
- Use Flutter Inspector for UI debugging
- Check device logs for Firebase connection issues

---

## License

This project is created for educational purposes and demonstrates Flutter development best practices.
