# Ụzọ — Google Play Store Deployment & iOS Migration Guide

This guide provides the complete release engineering steps to build, sign, and publish **Ụzọ (com.uzo.igbolanguage)** to the Google Play Store, along with instructions for compiling the iOS build for the Apple App Store.

---

## 1. Prerequisites Checklist
- [x] **Application ID:** `com.uzo.igbolanguage`
- [x] **Target SDK:** 34 (Android 14) / **Min SDK:** 24 (Android 7.0 - covers 98%+ active Android devices)
- [x] **Microphone & Speech permissions:** Explicit user prompts implemented
- [x] **Offline Data:** High-fidelity curriculum and travel phrasebook bundled in `assets/data/curriculum.json`

---

## 2. Release Keystore & Signing Key (COMPLETED ✅)

Your release keystore has already been generated directly on this machine:

* **File Location:** `android/app/keystore/upload-keystore.jks`
* **Key Alias:** `uzo_upload_key`
* **Key Password:** `UzoIgboPlayStore2026!`
* **Store Password:** `UzoIgboPlayStore2026!`
* **Algorithm & Validity:** 2048-bit RSA, valid for 25 years (until **November 2051**)
* **Certificate SHA-256 Fingerprint:** `23:0F:DF:81:7F:33:34:12:4C:CB:C4:09:70:7B:D4:9B:46:83:79:B5:9E:DF:EC:D6:65:73:DD:CE:70:B9:19:4F`
* **Base64 Backup:** Saved in `android/keystore_base64.txt` (ready for CI/CD secrets)
* **Properties File:** Pre-configured in `android/key.properties` (ignored by git for security)

*(You do not need to run `keytool` manually — your keystore is already created and verified.)*

---

## 3. Build Production Artifacts

### A. Android App Bundle (`.aab`) — Recommended for Google Play
Google Play requires `.aab` for all new apps. To generate an optimized App Bundle with dynamic resource splitting:
```bash
flutter build appbundle --release
```
* **Output:** `build/app/outputs/bundle/release/app-release.aab`
* Upload this `.aab` directly to Google Play Console under **Internal Testing**, **Closed Testing**, or **Production**.

### B. Standalone APK (`.apk`) — For Direct Device Testing
To generate a release APK to test directly on your Android phone or share with testers:
```bash
flutter build apk --release
```
* **Output:** `build/app/outputs/flutter-apk/app-release.apk`

---

## 4. Google Play Console Listing Configuration

| Field | Value |
| :--- | :--- |
| **App Name** | Ụzọ: Speak Igbo & Conversation |
| **Short Description** | Hold real conversations in Igbo. Practice two-way speaking, market bargaining, dialects & authentic tones. |
| **Full Description** | **Ụzọ ("The Path") is your interactive companion for speaking and holding fluent, everyday conversations in Igbo.**<br><br>Whether you are connecting with family, visiting Eastern Nigeria, or reconnecting with your heritage, Ụzọ gives you the confidence to speak and converse naturally in real-life situations with native speakers.<br><br>🌟 **KEY CONVERSATION FEATURES:**<br>• 🗣️ **Face-to-Face Two-Way Conversation Mode:** Place your phone between you and a native speaker. The innovative dual-lane display rotates 180° for the person opposite you across a counter or table, translating speech in real time so you can hold a natural conversation.<br>• 🎙️ **Interactive Speaking Drills:** Practice speaking out loud with instant acoustic feedback. Learn how to respond smoothly to everyday questions like *"Kedu ka ị mere?"* (How are you?) with *"Adị m mma, daalụ"* (I'm fine, thank you).<br>• 🏪 **Market Bargaining Simulator (Ahịa Ogbete):** Step into realistic conversational dialogues to ask prices (*"Ego ole ka nke a bụ?"*), negotiate politely with market vendors (*"Biko, belata ọnụ ahịa ya"*), and close deals in Igbo.<br>• 🐢 **Multi-Dialect Conversational Fluency:** Converse with native speakers anywhere! Choose and switch between Central Igbo (Izugbe), Anambra/Onitsha, Enuani (Delta), and Imo/Owerri to understand regional phrases and accents.<br>• 🎵 **Tone Workout Engine:** Igbo is a tonal language where pitch changes meaning. Master tone minimal pairs (*Ákwá* = crying, *Àkwà* = bed, *Àkwá* = egg, *Ákwà* = cloth) so your conversational speech is always clear and understood.<br>• 📴 **100% Offline Travel Phrasebook:** Instant access to transit phrases, hailing a Keke, ordering traditional foods (*Ofe Oha, Akpụ*), and polite courtesies without requiring mobile data.<br>• 🏆 **Cultural Passport & Ilu Igbo:** Earn traditional chieftain titles (*Onye Njem, Onye Ọzụzụ, Ichie*) and discover daily wisdom with authentic Igbo proverbs. |
| **Category** | Education / Travel & Local |
| **Content Rating** | Everyone (Ages 4+) |
| **Target Audience** | Young adults, travelers, diaspora, heritage learners |
| **Permissions Declared** | `RECORD_AUDIO` (for speaking exercises and live microphone conversation mode) |

### Required Store Assets
- **App Icon:** 512 × 512 px PNG (32-bit with alpha) — Use `assets/images/logo.png`
- **Feature Graphic:** 1024 × 500 px PNG / JPG
- **Phone Screenshots:** At least 4 screenshots (aspect ratio 16:9 or 9:16). The Stitch project export contains high-resolution mobile screenshots for:
  - *Onboarding 1 & 3* (Welcome & Dialect Selection)
  - *Learn - Path to Fluency* (Unit progression)
  - *Lesson - Listening Drill (Daalụ)*
  - *Live Travel Translator*
  - *Practice - Tone Workout*

---

## 5. Direct iOS Migration & App Store Build (Zero Rewrite)

Because Ụzọ is built on Flutter with Clean Architecture, **100% of the codebase, business logic, state management, and UI widgets are completely shared with iOS**.

To deploy to iOS:
1. Open terminal on macOS:
```bash
cd ios
pod install
```
2. Open `ios/Runner.xcworkspace` in Xcode.
3. In **Signing & Capabilities**, select your Apple Developer Team.
4. Verify bundle identifier matches `com.uzo.igbolanguage`.
5. Build and archive for TestFlight or App Store:
```bash
flutter build ipa --release
```
* The resulting `.ipa` file will be generated in `build/ios/archive/Runner.xcarchive`, ready for App Store Connect distribution via Xcode Organizer or Transporter.
