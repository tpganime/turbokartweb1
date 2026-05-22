# TurboKart — Complete Web App + Firebase + Vercel Guide

Your zip contains **4 Flutter apps** that already support Flutter Web. This guide renames all of them to **TurboKart**, wires up Firebase for web, and deploys each one to Vercel.

---

## 📦 Apps in Your Package

| Folder | Role | What It Does |
|---|---|---|
| `AdminWebsiteGroceryApp` | **Admin Panel** | Manage vendors, orders, categories, banners, delivery boys |
| `MultiVendingGroceryApp` | **Customer App** | Shopping, cart, payments, order tracking |
| `VendorGroceryApp` | **Vendor App** | Product management, banners, coupons, orders |
| `DeliveryPersonGroceryApp` | **Delivery App** | Accept/manage deliveries |

---

## PART 1 — Rename Everything to TurboKart

Do this for **each of the 4 apps**.

---

### 1A. Admin Panel (`AdminWebsiteGroceryApp/`)

**`pubspec.yaml`** — Change line 1:
```yaml
# BEFORE
name: admin_website_grocery_app

# AFTER
name: turbokart_admin
```
Also update the title field inside the file (description line):
```yaml
description: "TurboKart Admin Dashboard"
```

**`lib/main.dart`** — Change the app title:
```dart
// BEFORE
title: "Grocery App Admin Dashboard",

// AFTER
title: "TurboKart Admin",
```
Also update all package imports from `admin_website_grocery_app` → `turbokart_admin`:
```dart
// Example — change ALL import lines like this:
// BEFORE
import 'package:admin_website_grocery_app/screens/home_screen.dart';
// AFTER
import 'package:turbokart_admin/screens/home_screen.dart';
```
> **Tip:** In VS Code do Ctrl+Shift+H (Find & Replace in files):
> Find: `admin_website_grocery_app`
> Replace: `turbokart_admin`

**`web/index.html`** — Update title and meta:
```html
<meta name="apple-mobile-web-app-title" content="TurboKart Admin">
<title>TurboKart Admin</title>
```

**`web/manifest.json`** — Update:
```json
{
  "name": "TurboKart Admin",
  "short_name": "TurboKart",
  ...
}
```

---

### 1B. Customer App (`MultiVendingGroceryApp/`)

**`pubspec.yaml`**:
```yaml
name: turbokart
description: "TurboKart — Multi-Vendor Grocery Delivery"
```

**`lib/main.dart`** — Replace all imports and app title:
```dart
// Find & Replace all: multi_vending_grocery_app → turbokart
title: "TurboKart",
```

**`web/index.html`**:
```html
<meta name="apple-mobile-web-app-title" content="TurboKart">
<title>TurboKart</title>
```

---

### 1C. Vendor App (`VendorGroceryApp/`)

**`pubspec.yaml`**:
```yaml
name: turbokart_vendor
description: "TurboKart Vendor Portal"
```

**`lib/main.dart`** — Replace all imports:
```dart
// Find & Replace: grocery_vendor_app → turbokart_vendor
title: "TurboKart Vendor",
```

**`web/index.html`**:
```html
<meta name="apple-mobile-web-app-title" content="TurboKart Vendor">
<title>TurboKart Vendor Portal</title>
```

---

### 1D. Delivery App (`DeliveryPersonGroceryApp/`)

**`pubspec.yaml`**:
```yaml
name: turbokart_delivery
description: "TurboKart Delivery"
```

**`lib/main.dart`** — Replace all imports:
```dart
// Find & Replace: grocery_delivery_person_app → turbokart_delivery
title: "TurboKart Delivery",
```

**`web/index.html`**:
```html
<meta name="apple-mobile-web-app-title" content="TurboKart Delivery">
<title>TurboKart Delivery</title>
```

---

## PART 2 — Firebase Setup for Web

Your apps already use Firebase — you just need to add your **web** Firebase config to each app.

### Step 1: Create a Firebase Project

1. Go to [console.firebase.google.com](https://console.firebase.google.com)
2. Create a new project named **TurboKart** (or reuse the existing `grocery-application-3329d`)
3. Enable: **Authentication** → Phone, Email/Password | **Firestore** | **Storage**

### Step 2: Register a Web App

1. In Firebase Console → Project Settings → "Your apps"
2. Click **Add app** → Web (</> icon)
3. Give it a nickname: `turbokart-admin` (repeat for each sub-app)
4. Firebase gives you a config object like:
```javascript
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

### Step 3: Update `main.dart` in Each App

Replace the existing `FirebaseOptions` block in every app's `main.dart`:

**Admin App** (`AdminWebsiteGroceryApp/lib/main.dart`):
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_WEB_API_KEY",
    authDomain: "YOUR_PROJECT.firebaseapp.com",
    appId: "YOUR_WEB_APP_ID",
    messagingSenderId: "YOUR_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT.appspot.com",
  ),
);
```

**Customer App** (`MultiVendingGroceryApp/lib/main.dart`):
> Same pattern — replace the existing `FirebaseOptions(...)` block with your new web config.

**Vendor App** (`VendorGroceryApp/lib/main.dart`):
> Same pattern.

**Delivery App** (`DeliveryPersonGroceryApp/lib/main.dart`):
> Same pattern.

> ⚠️ **Important**: The current `main.dart` files use Android app IDs (`appId: "1:...:android:..."`). For web you must use the **web app ID** from Firebase Console → Project Settings → Your Apps → Web app → App ID. It looks like `1:XXXXXX:web:XXXXXXXX`.

### Step 4: Add Firebase Auth Domain to Authorized Domains

1. Firebase Console → Authentication → Settings → Authorized Domains
2. Add your Vercel domains (e.g., `turbokart-admin.vercel.app`)

---

## PART 3 — Build Flutter Web

Run this in each app folder:

```bash
# Install dependencies
flutter pub get

# Build for web (output goes to build/web/)
flutter build web --release
```

The output is in `build/web/` — this is what you deploy to Vercel.

---

## PART 4 — Deploy to Vercel

You have two options:

---

### Option A: Manual Deploy (Simplest)

1. Run `flutter build web` in the app folder
2. Install Vercel CLI: `npm i -g vercel`
3. From inside the app folder:
```bash
vercel deploy build/web --prod
```
4. Follow the prompts. Set the project name to `turbokart-admin` (or respective app name).

---

### Option B: GitHub Auto-Deploy (Recommended for ongoing use)

#### Step 1: Create GitHub repos

Create 4 repos (or one monorepo):
- `turbokart-admin`
- `turbokart-customer`
- `turbokart-vendor`
- `turbokart-delivery`

Push each app folder to its respective repo.

#### Step 2: Add `vercel.json` to each app root

Create `vercel.json` in the root of each app folder:

```json
{
  "buildCommand": "flutter/bin/flutter build web --release",
  "outputDirectory": "build/web",
  "installCommand": "git clone https://github.com/flutter/flutter.git flutter && flutter/bin/flutter config --enable-web && flutter/bin/flutter pub get",
  "framework": null
}
```

> This tells Vercel to install Flutter, enable web, and build the app.

#### Step 3: Connect to Vercel

1. Go to [vercel.com](https://vercel.com) → New Project
2. Import the GitHub repository
3. Vercel will auto-detect the `vercel.json` and use those build settings
4. Deploy!

#### Step 4: Set Environment Variables (Optional but recommended)

Instead of hardcoding Firebase keys, use Vercel environment variables:

In `main.dart`, you can use `const String.fromEnvironment`:
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
    appId: String.fromEnvironment('FIREBASE_APP_ID'),
    messagingSenderId: String.fromEnvironment('FIREBASE_SENDER_ID'),
    projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
    storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
    authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
  ),
);
```

Then in Vercel Dashboard → Project → Settings → Environment Variables, add:
- `FIREBASE_API_KEY` = your value
- `FIREBASE_APP_ID` = your value
- etc.

And update the build command to pass them in:
```json
{
  "buildCommand": "flutter/bin/flutter build web --release --dart-define=FIREBASE_API_KEY=$FIREBASE_API_KEY --dart-define=FIREBASE_APP_ID=$FIREBASE_APP_ID --dart-define=FIREBASE_SENDER_ID=$FIREBASE_SENDER_ID --dart-define=FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID --dart-define=FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET --dart-define=FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN"
}
```

---

## PART 5 — Final File Structure

After all changes, your project should look like:

```
turbokart/
├── turbokart-admin/          (renamed AdminWebsiteGroceryApp)
│   ├── lib/main.dart         ✅ updated Firebase config + title
│   ├── pubspec.yaml          ✅ name: turbokart_admin
│   ├── web/index.html        ✅ title: TurboKart Admin
│   └── vercel.json           ✅ new file
│
├── turbokart-customer/       (renamed MultiVendingGroceryApp)
│   ├── lib/main.dart         ✅ updated
│   ├── pubspec.yaml          ✅ name: turbokart
│   ├── web/index.html        ✅ title: TurboKart
│   └── vercel.json           ✅ new file
│
├── turbokart-vendor/         (renamed VendorGroceryApp)
│   ├── lib/main.dart         ✅ updated
│   ├── pubspec.yaml          ✅ name: turbokart_vendor
│   ├── web/index.html        ✅ title: TurboKart Vendor Portal
│   └── vercel.json           ✅ new file
│
└── turbokart-delivery/       (renamed DeliveryPersonGroceryApp)
    ├── lib/main.dart         ✅ updated
    ├── pubspec.yaml          ✅ name: turbokart_delivery
    ├── web/index.html        ✅ title: TurboKart Delivery
    └── vercel.json           ✅ new file
```

---

## PART 6 — Quick Checklist

### Renaming ✅
- [ ] `pubspec.yaml` name updated in all 4 apps
- [ ] All `import 'package:old_name/...'` → `'package:new_name/...'` in all dart files
- [ ] `web/index.html` titles updated
- [ ] `web/manifest.json` names updated

### Firebase ✅
- [ ] Created Firebase web apps (or reused existing project)
- [ ] Copied **web** `appId` (not Android) into each `main.dart`
- [ ] `authDomain` added to `FirebaseOptions`
- [ ] Vercel domains added to Firebase Authorized Domains

### Vercel ✅
- [ ] `vercel.json` added to each app root
- [ ] GitHub repos created and code pushed
- [ ] Projects connected in Vercel dashboard
- [ ] Environment variables set (if using `--dart-define` approach)

---

## Common Issues & Fixes

**Build fails on Vercel — "flutter not found"**
> Make sure `vercel.json` has the `installCommand` that clones Flutter. Some users prefer using a Docker-based build; in that case use GitHub Actions to build and then deploy the `build/web` output.

**Firebase auth not working on web**
> Make sure you're using the **web** app ID from Firebase Console, not the Android one. Also enable the auth methods (Email/Password, Phone) in Firebase Console.

**App loads but shows blank screen**
> Check browser console for errors. Usually means Firebase init failed — double-check your `FirebaseOptions` values match exactly what Firebase Console shows.

**`flutter_stripe` doesn't work on web**
> Stripe web requires adding the Stripe.js script to `web/index.html`:
```html
<script src="https://js.stripe.com/v3/" async></script>
```

---

## Your Vercel URLs (after deploy)

| App | URL |
|---|---|
| Admin | `https://turbokart-admin.vercel.app` |
| Customer | `https://turbokart.vercel.app` |
| Vendor | `https://turbokart-vendor.vercel.app` |
| Delivery | `https://turbokart-delivery.vercel.app` |

You can also add a custom domain in Vercel → Project → Settings → Domains.
