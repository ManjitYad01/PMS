# practical_management_system

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

🔐 Admin Credentials Setup

This project uses local hardcoded credentials for the admin login. To keep these credentials secure and out of version control, the actual file is excluded using .gitignore.

✅ Steps to Configure Admin Credentials Locally:

Copy the example file to create your local credential file:

cp lib/constants/admin_credentials.example.dart lib/constants/admin_credentials.dart


Open the copied file lib/constants/admin_credentials.dart and update the placeholders:

const String adminUsername = 'your_admin_username';
const String adminPassword = 'your_secure_password';


✅ This file is already ignored by Git, so it will not be committed or pushed to remote repositories.

⚠️ Never put your real admin credentials in admin_credentials.example.dart — this is just a public template.

💡 Why This Is Done

Prevents accidental credential leaks into version control.

Avoids build errors due to missing files.

Lets each developer or deployer manage their own secure credentials.

Keeps codebase flexible for future migration to more secure auth methods (e.g., Firebase Admin Auth).

```
practical_management_system
├─ .metadata
├─ analysis_options.yaml
├─ android
│  ├─ app
│  │  ├─ build.gradle.kts
│  │  ├─ google-services.json
│  │  └─ src
│  │     ├─ debug
│  │     │  └─ AndroidManifest.xml
│  │     ├─ main
│  │     │  ├─ AndroidManifest.xml
│  │     │  ├─ java
│  │     │  │  └─ io
│  │     │  │     └─ flutter
│  │     │  │        └─ plugins
│  │     │  │           └─ GeneratedPluginRegistrant.java
│  │     │  ├─ kotlin
│  │     │  │  └─ com
│  │     │  │     └─ example
│  │     │  │        └─ practical_management_system
│  │     │  │           └─ MainActivity.kt
│  │     │  └─ res
│  │     │     ├─ drawable
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable-v21
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ mipmap-hdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-mdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ values
│  │     │     │  └─ styles.xml
│  │     │     └─ values-night
│  │     │        └─ styles.xml
│  │     └─ profile
│  │        └─ AndroidManifest.xml
│  ├─ build.gradle.kts
│  ├─ gradle
│  │  └─ wrapper
│  │     ├─ gradle-wrapper.jar
│  │     └─ gradle-wrapper.properties
│  ├─ gradle.properties
│  ├─ gradlew
│  ├─ gradlew.bat
│  ├─ local.properties
│  └─ settings.gradle.kts
├─ assets
│  ├─ icons
│  ├─ images
│  │  └─ sies_logo.png
│  └─ json
├─ firebase.json
├─ ios
│  ├─ Flutter
│  │  ├─ AppFrameworkInfo.plist
│  │  ├─ Debug.xcconfig
│  │  ├─ ephemeral
│  │  │  ├─ flutter_lldbinit
│  │  │  └─ flutter_lldb_helper.py
│  │  ├─ flutter_export_environment.sh
│  │  ├─ Generated.xcconfig
│  │  └─ Release.xcconfig
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  ├─ AppIcon.appiconset
│  │  │  │  ├─ Contents.json
│  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │  └─ LaunchImage.imageset
│  │  │     ├─ Contents.json
│  │  │     ├─ LaunchImage.png
│  │  │     ├─ LaunchImage@2x.png
│  │  │     ├─ LaunchImage@3x.png
│  │  │     └─ README.md
│  │  ├─ Base.lproj
│  │  │  ├─ LaunchScreen.storyboard
│  │  │  └─ Main.storyboard
│  │  ├─ GeneratedPluginRegistrant.h
│  │  ├─ GeneratedPluginRegistrant.m
│  │  ├─ Info.plist
│  │  └─ Runner-Bridging-Header.h
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  ├─ contents.xcworkspacedata
│  │  │  └─ xcshareddata
│  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     └─ WorkspaceSettings.xcsettings
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  ├─ Runner.xcworkspace
│  │  ├─ contents.xcworkspacedata
│  │  └─ xcshareddata
│  │     ├─ IDEWorkspaceChecks.plist
│  │     └─ WorkspaceSettings.xcsettings
│  └─ RunnerTests
│     └─ RunnerTests.swift
├─ lib
│  ├─ constants
│  │  └─ colors.dart
│  ├─ firebase_options.dart
│  ├─ main.dart
│  ├─ models
│  ├─ screens
│  │  ├─ admin
│  │  │  ├─ admin_dashboard.dart
│  │  │  ├─ pending_approvals_screen.dart
│  │  │  ├─ teachers_approved_screen.dart
│  │  │  └─ teachers_rejected_screen.dart
│  │  ├─ login
│  │  │  ├─ admin_login_page.dart
│  │  │  ├─ login_main_page.dart
│  │  │  ├─ student_login_page.dart
│  │  │  └─ teacher_login_page.dart
│  │  ├─ shared
│  │  │  └─ admin_or_teacher_choice_page.dart
│  │  ├─ student
│  │  │  ├─ student_dashboard_page.dart
│  │  │  ├─ student_forgot_password_page.dart
│  │  │  └─ student_registration_page.dart
│  │  └─ teacher
│  │     ├─ AddPracticalScreen.dart
│  │     ├─ AssignmentSubmissionScreen.dart
│  │     ├─ batches_screen.dart
│  │     ├─ create_classroom_page.dart
│  │     ├─ PracticalAttendanceScreen.dart
│  │     ├─ PracticalsScreen.dart
│  │     ├─ StudentsListScreen.dart
│  │     ├─ subjects_screen.dart
│  │     ├─ teacher_dashboard_page.dart
│  │     ├─ teacher_forgot_password_page.dart
│  │     └─ teacher_registration_page.dart
│  ├─ services
│  │  ├─ auth_services.dart
│  │  └─ database_services.dart
│  ├─ utils
│  │  ├─ loading.dart
│  │  └─ validators.dart
│  └─ widgets
│     └─ custom_widgets.dart
├─ linux
│  ├─ CMakeLists.txt
│  ├─ flutter
│  │  ├─ CMakeLists.txt
│  │  ├─ ephemeral
│  │  │  └─ .plugin_symlinks
│  │  │     └─ file_picker
│  │  │        ├─ analysis_options.yaml
│  │  │        ├─ android
│  │  │        │  ├─ build.gradle
│  │  │        │  ├─ gradle
│  │  │        │  │  └─ wrapper
│  │  │        │  │     └─ gradle-wrapper.properties
│  │  │        │  ├─ proguard-rules.pro
│  │  │        │  ├─ settings.gradle
│  │  │        │  └─ src
│  │  │        │     └─ main
│  │  │        │        ├─ AndroidManifest.xml
│  │  │        │        └─ kotlin
│  │  │        │           └─ com
│  │  │        │              └─ mr
│  │  │        │                 └─ flutter
│  │  │        │                    └─ plugin
│  │  │        │                       └─ filepicker
│  │  │        │                          ├─ FileInfo.kt
│  │  │        │                          ├─ FilePickerDelegate.kt
│  │  │        │                          ├─ FilePickerPlugin.kt
│  │  │        │                          ├─ FileUtils.kt
│  │  │        │                          └─ MethodResultWrapper.kt
│  │  │        ├─ CHANGELOG.md
│  │  │        ├─ CONTRIBUTING.md
│  │  │        ├─ example
│  │  │        │  ├─ analysis_options.yaml
│  │  │        │  ├─ android
│  │  │        │  │  ├─ app
│  │  │        │  │  │  ├─ build.gradle.kts
│  │  │        │  │  │  └─ src
│  │  │        │  │  │     ├─ debug
│  │  │        │  │  │     │  └─ AndroidManifest.xml
│  │  │        │  │  │     ├─ main
│  │  │        │  │  │     │  ├─ AndroidManifest.xml
│  │  │        │  │  │     │  ├─ kotlin
│  │  │        │  │  │     │  │  └─ com
│  │  │        │  │  │     │  │     └─ mr
│  │  │        │  │  │     │  │        └─ flutter
│  │  │        │  │  │     │  │           └─ plugin
│  │  │        │  │  │     │  │              └─ filepicker
│  │  │        │  │  │     │  │                 └─ file_picker_example
│  │  │        │  │  │     │  │                    └─ MainActivity.kt
│  │  │        │  │  │     │  └─ res
│  │  │        │  │  │     │     ├─ drawable
│  │  │        │  │  │     │     │  └─ launch_background.xml
│  │  │        │  │  │     │     ├─ drawable-v21
│  │  │        │  │  │     │     │  └─ launch_background.xml
│  │  │        │  │  │     │     ├─ mipmap-hdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-mdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xxhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xxxhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ values
│  │  │        │  │  │     │     │  └─ styles.xml
│  │  │        │  │  │     │     └─ values-night
│  │  │        │  │  │     │        └─ styles.xml
│  │  │        │  │  │     └─ profile
│  │  │        │  │  │        └─ AndroidManifest.xml
│  │  │        │  │  ├─ build.gradle.kts
│  │  │        │  │  ├─ gradle
│  │  │        │  │  │  └─ wrapper
│  │  │        │  │  │     └─ gradle-wrapper.properties
│  │  │        │  │  ├─ gradle.properties
│  │  │        │  │  └─ settings.gradle.kts
│  │  │        │  ├─ ios
│  │  │        │  │  ├─ Flutter
│  │  │        │  │  │  ├─ AppFrameworkInfo.plist
│  │  │        │  │  │  ├─ Debug.xcconfig
│  │  │        │  │  │  └─ Release.xcconfig
│  │  │        │  │  ├─ gpxgenerator_path.gpx
│  │  │        │  │  ├─ Runner
│  │  │        │  │  │  ├─ AppDelegate.h
│  │  │        │  │  │  ├─ AppDelegate.m
│  │  │        │  │  │  ├─ AppDelegate.swift
│  │  │        │  │  │  ├─ Assets.xcassets
│  │  │        │  │  │  │  ├─ AppIcon.appiconset
│  │  │        │  │  │  │  │  ├─ Contents.json
│  │  │        │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │        │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │        │  │  │  │  └─ LaunchImage.imageset
│  │  │        │  │  │  │     ├─ Contents.json
│  │  │        │  │  │  │     ├─ LaunchImage.png
│  │  │        │  │  │  │     ├─ LaunchImage@2x.png
│  │  │        │  │  │  │     ├─ LaunchImage@3x.png
│  │  │        │  │  │  │     └─ README.md
│  │  │        │  │  │  ├─ Base.lproj
│  │  │        │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │        │  │  │  │  └─ Main.storyboard
│  │  │        │  │  │  ├─ File.swift
│  │  │        │  │  │  ├─ Info.plist
│  │  │        │  │  │  ├─ main.m
│  │  │        │  │  │  └─ Runner-Bridging-Header.h
│  │  │        │  │  ├─ Runner.xcodeproj
│  │  │        │  │  │  ├─ project.pbxproj
│  │  │        │  │  │  ├─ project.xcworkspace
│  │  │        │  │  │  │  ├─ contents.xcworkspacedata
│  │  │        │  │  │  │  └─ xcshareddata
│  │  │        │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │        │  │  │  │     ├─ swiftpm
│  │  │        │  │  │  │     │  └─ Package.resolved
│  │  │        │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     └─ xcschemes
│  │  │        │  │  │        └─ Runner.xcscheme
│  │  │        │  │  └─ Runner.xcworkspace
│  │  │        │  │     ├─ contents.xcworkspacedata
│  │  │        │  │     └─ xcshareddata
│  │  │        │  │        ├─ IDEWorkspaceChecks.plist
│  │  │        │  │        └─ WorkspaceSettings.xcsettings
│  │  │        │  ├─ lib
│  │  │        │  │  ├─ main.dart
│  │  │        │  │  ├─ main_desktop.dart
│  │  │        │  │  └─ src
│  │  │        │  │     └─ file_picker_demo.dart
│  │  │        │  ├─ linux
│  │  │        │  │  ├─ CMakeLists.txt
│  │  │        │  │  ├─ flutter
│  │  │        │  │  │  ├─ CMakeLists.txt
│  │  │        │  │  │  ├─ generated_plugins.cmake
│  │  │        │  │  │  ├─ generated_plugin_registrant.cc
│  │  │        │  │  │  └─ generated_plugin_registrant.h
│  │  │        │  │  ├─ main.cc
│  │  │        │  │  ├─ my_application.cc
│  │  │        │  │  └─ my_application.h
│  │  │        │  ├─ macos
│  │  │        │  │  ├─ Flutter
│  │  │        │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │        │  │  │  └─ Flutter-Release.xcconfig
│  │  │        │  │  ├─ Runner
│  │  │        │  │  │  ├─ AppDelegate.swift
│  │  │        │  │  │  ├─ Assets.xcassets
│  │  │        │  │  │  │  └─ AppIcon.appiconset
│  │  │        │  │  │  │     ├─ app_icon_1024.png
│  │  │        │  │  │  │     ├─ app_icon_128.png
│  │  │        │  │  │  │     ├─ app_icon_16.png
│  │  │        │  │  │  │     ├─ app_icon_256.png
│  │  │        │  │  │  │     ├─ app_icon_32.png
│  │  │        │  │  │  │     ├─ app_icon_512.png
│  │  │        │  │  │  │     ├─ app_icon_64.png
│  │  │        │  │  │  │     └─ Contents.json
│  │  │        │  │  │  ├─ Base.lproj
│  │  │        │  │  │  │  └─ MainMenu.xib
│  │  │        │  │  │  ├─ Configs
│  │  │        │  │  │  │  ├─ AppInfo.xcconfig
│  │  │        │  │  │  │  ├─ Debug.xcconfig
│  │  │        │  │  │  │  ├─ Release.xcconfig
│  │  │        │  │  │  │  └─ Warnings.xcconfig
│  │  │        │  │  │  ├─ DebugProfile.entitlements
│  │  │        │  │  │  ├─ Info.plist
│  │  │        │  │  │  ├─ MainFlutterWindow.swift
│  │  │        │  │  │  └─ Release.entitlements
│  │  │        │  │  ├─ Runner.xcodeproj
│  │  │        │  │  │  ├─ project.pbxproj
│  │  │        │  │  │  ├─ project.xcworkspace
│  │  │        │  │  │  │  └─ xcshareddata
│  │  │        │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     └─ xcschemes
│  │  │        │  │  │        └─ Runner.xcscheme
│  │  │        │  │  ├─ Runner.xcworkspace
│  │  │        │  │  │  ├─ contents.xcworkspacedata
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │        │  │  └─ RunnerTests
│  │  │        │  │     └─ RunnerTests.swift
│  │  │        │  ├─ pubspec.yaml
│  │  │        │  ├─ README.md
│  │  │        │  ├─ screenshots
│  │  │        │  │  ├─ example_android.gif
│  │  │        │  │  ├─ example_ios.gif
│  │  │        │  │  ├─ example_linux.gif
│  │  │        │  │  ├─ example_macos.gif
│  │  │        │  │  └─ example_windows.gif
│  │  │        │  ├─ web
│  │  │        │  │  ├─ favicon.png
│  │  │        │  │  ├─ icons
│  │  │        │  │  │  ├─ Icon-192.png
│  │  │        │  │  │  └─ Icon-512.png
│  │  │        │  │  ├─ index.html
│  │  │        │  │  └─ manifest.json
│  │  │        │  └─ windows
│  │  │        │     ├─ CMakeLists.txt
│  │  │        │     ├─ flutter
│  │  │        │     │  ├─ CMakeLists.txt
│  │  │        │     │  ├─ generated_plugins.cmake
│  │  │        │     │  ├─ generated_plugin_registrant.cc
│  │  │        │     │  └─ generated_plugin_registrant.h
│  │  │        │     └─ runner
│  │  │        │        ├─ CMakeLists.txt
│  │  │        │        ├─ flutter_window.cpp
│  │  │        │        ├─ flutter_window.h
│  │  │        │        ├─ main.cpp
│  │  │        │        ├─ resource.h
│  │  │        │        ├─ resources
│  │  │        │        │  └─ app_icon.ico
│  │  │        │        ├─ runner.exe.manifest
│  │  │        │        ├─ Runner.rc
│  │  │        │        ├─ utils.cpp
│  │  │        │        ├─ utils.h
│  │  │        │        ├─ win32_window.cpp
│  │  │        │        └─ win32_window.h
│  │  │        ├─ ios
│  │  │        │  ├─ file_picker
│  │  │        │  │  ├─ Package.resolved
│  │  │        │  │  ├─ Package.swift
│  │  │        │  │  └─ Sources
│  │  │        │  │     └─ file_picker
│  │  │        │  │        ├─ FileInfo.m
│  │  │        │  │        ├─ FilePickerPlugin.m
│  │  │        │  │        ├─ FileUtils.m
│  │  │        │  │        ├─ ImageUtils.m
│  │  │        │  │        ├─ include
│  │  │        │  │        │  ├─ file_picker
│  │  │        │  │        │  │  ├─ FileInfo.h
│  │  │        │  │        │  │  ├─ FilePickerPlugin.h
│  │  │        │  │        │  │  ├─ FileUtils.h
│  │  │        │  │        │  │  └─ ImageUtils.h
│  │  │        │  │        │  ├─ file_picker-umbrella.h
│  │  │        │  │        │  └─ file_picker.modulemap
│  │  │        │  │        └─ PrivacyInfo.xcprivacy
│  │  │        │  └─ file_picker.podspec
│  │  │        ├─ lib
│  │  │        │  ├─ file_picker.dart
│  │  │        │  ├─ src
│  │  │        │  │  ├─ exceptions.dart
│  │  │        │  │  ├─ file_picker.dart
│  │  │        │  │  ├─ file_picker_io.dart
│  │  │        │  │  ├─ file_picker_macos.dart
│  │  │        │  │  ├─ file_picker_result.dart
│  │  │        │  │  ├─ linux
│  │  │        │  │  │  ├─ file_picker_linux.dart
│  │  │        │  │  │  ├─ filters.dart
│  │  │        │  │  │  ├─ xdp_filechooser.dart
│  │  │        │  │  │  └─ xdp_request.dart
│  │  │        │  │  ├─ platform_file.dart
│  │  │        │  │  ├─ utils.dart
│  │  │        │  │  └─ windows
│  │  │        │  │     ├─ file_picker_windows.dart
│  │  │        │  │     ├─ file_picker_windows_ffi_types.dart
│  │  │        │  │     └─ file_picker_windows_stub.dart
│  │  │        │  └─ _internal
│  │  │        │     └─ file_picker_web.dart
│  │  │        ├─ LICENSE
│  │  │        ├─ macos
│  │  │        │  ├─ file_picker
│  │  │        │  │  ├─ Package.swift
│  │  │        │  │  └─ Sources
│  │  │        │  │     └─ file_picker
│  │  │        │  │        ├─ FilePickerPlugin.swift
│  │  │        │  │        └─ PrivacyInfo.xcprivacy
│  │  │        │  └─ file_picker.podspec
│  │  │        ├─ pubspec.yaml
│  │  │        ├─ README.md
│  │  │        └─ test
│  │  │           ├─ common.dart
│  │  │           ├─ file_picker_macos_test.dart
│  │  │           ├─ file_picker_utils_test.dart
│  │  │           ├─ file_picker_windows_test.dart
│  │  │           ├─ linux
│  │  │           │  └─ xdp_filter_test.dart
│  │  │           └─ test_files
│  │  │              ├─ franz-michael-schneeberger-unsplash.jpg
│  │  │              ├─ test.pdf
│  │  │              └─ test.yml
│  │  ├─ generated_plugins.cmake
│  │  ├─ generated_plugin_registrant.cc
│  │  └─ generated_plugin_registrant.h
│  └─ runner
│     ├─ CMakeLists.txt
│     ├─ main.cc
│     ├─ my_application.cc
│     └─ my_application.h
├─ macos
│  ├─ Flutter
│  │  ├─ ephemeral
│  │  │  ├─ Flutter-Generated.xcconfig
│  │  │  └─ flutter_export_environment.sh
│  │  ├─ Flutter-Debug.xcconfig
│  │  ├─ Flutter-Release.xcconfig
│  │  └─ GeneratedPluginRegistrant.swift
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  └─ AppIcon.appiconset
│  │  │     ├─ app_icon_1024.png
│  │  │     ├─ app_icon_128.png
│  │  │     ├─ app_icon_16.png
│  │  │     ├─ app_icon_256.png
│  │  │     ├─ app_icon_32.png
│  │  │     ├─ app_icon_512.png
│  │  │     ├─ app_icon_64.png
│  │  │     └─ Contents.json
│  │  ├─ Base.lproj
│  │  │  └─ MainMenu.xib
│  │  ├─ Configs
│  │  │  ├─ AppInfo.xcconfig
│  │  │  ├─ Debug.xcconfig
│  │  │  ├─ Release.xcconfig
│  │  │  └─ Warnings.xcconfig
│  │  ├─ DebugProfile.entitlements
│  │  ├─ Info.plist
│  │  ├─ MainFlutterWindow.swift
│  │  └─ Release.entitlements
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  └─ xcshareddata
│  │  │     └─ IDEWorkspaceChecks.plist
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  ├─ Runner.xcworkspace
│  │  ├─ contents.xcworkspacedata
│  │  └─ xcshareddata
│  │     └─ IDEWorkspaceChecks.plist
│  └─ RunnerTests
│     └─ RunnerTests.swift
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ structure.txt
├─ test
│  └─ widget_test.dart
├─ web
│  ├─ favicon.png
│  ├─ icons
│  │  ├─ Icon-192.png
│  │  ├─ Icon-512.png
│  │  ├─ Icon-maskable-192.png
│  │  └─ Icon-maskable-512.png
│  ├─ index.html
│  └─ manifest.json
└─ windows
   ├─ CMakeLists.txt
   ├─ flutter
   │  ├─ CMakeLists.txt
   │  ├─ ephemeral
   │  │  └─ .plugin_symlinks
   │  │     ├─ cloud_firestore
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ local-config.gradle
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ firestore
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreException.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreExtension.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreMessageCodec.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestorePlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreTransactionResult.java
   │  │     │  │  │                       ├─ GeneratedAndroidFirebaseFirestore.java
   │  │     │  │  │                       ├─ streamhandler
   │  │     │  │  │                       │  ├─ DocumentSnapshotsStreamHandler.java
   │  │     │  │  │                       │  ├─ LoadBundleStreamHandler.java
   │  │     │  │  │                       │  ├─ OnTransactionResultListener.java
   │  │     │  │  │                       │  ├─ QuerySnapshotsStreamHandler.java
   │  │     │  │  │                       │  ├─ SnapshotsInSyncStreamHandler.java
   │  │     │  │  │                       │  └─ TransactionStreamHandler.java
   │  │     │  │  │                       └─ utils
   │  │     │  │  │                          ├─ ExceptionConverter.java
   │  │     │  │  │                          ├─ PigeonParser.java
   │  │     │  │  │                          └─ ServerTimestampBehaviorConverter.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ dartpad
   │  │     │  │  ├─ dartpad_metadata.yaml
   │  │     │  │  └─ lib
   │  │     │  │     └─ main.dart
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebase
   │  │     │  │  │  │     │  │              └─ firestore
   │  │     │  │  │  │     │  │                 └─ example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ firebase.json
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  ├─ collection_reference_e2e.dart
   │  │     │  │  │  ├─ document_change_e2e.dart
   │  │     │  │  │  ├─ document_reference_e2e.dart
   │  │     │  │  │  ├─ e2e_test.dart
   │  │     │  │  │  ├─ field_value_e2e.dart
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  ├─ firebase_options_secondary.dart
   │  │     │  │  │  ├─ geo_point_e2e.dart
   │  │     │  │  │  ├─ instance_e2e.dart
   │  │     │  │  │  ├─ load_bundle_e2e.dart
   │  │     │  │  │  ├─ query_e2e.dart
   │  │     │  │  │  ├─ second_database.dart
   │  │     │  │  │  ├─ settings_e2e.dart
   │  │     │  │  │  ├─ snapshot_metadata_e2e.dart
   │  │     │  │  │  ├─ timestamp_e2e.dart
   │  │     │  │  │  ├─ transaction_e2e.dart
   │  │     │  │  │  ├─ vector_value_e2e.dart
   │  │     │  │  │  ├─ web_snapshot_listeners.dart
   │  │     │  │  │  └─ write_batch_e2e.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        ├─ swiftpm
   │  │     │  │  │        │  └─ configuration
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ swiftpm
   │  │     │  │  │  │        └─ configuration
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  ├─ manifest.json
   │  │     │  │  │  └─ wasm_index.html
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ cloud_firestore
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ cloud_firestore
   │  │     │  │  │        ├─ FirestoreMessages.g.m
   │  │     │  │  │        ├─ FirestorePigeonParser.m
   │  │     │  │  │        ├─ FLTDocumentSnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreExtension.m
   │  │     │  │  │        ├─ FLTFirebaseFirestorePlugin.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreReader.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreUtils.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreWriter.m
   │  │     │  │  │        ├─ FLTLoadBundleStreamHandler.m
   │  │     │  │  │        ├─ FLTQuerySnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTSnapshotsInSyncStreamHandler.m
   │  │     │  │  │        ├─ FLTTransactionStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ cloud_firestore
   │  │     │  │  │        │     ├─ Private
   │  │     │  │  │        │     │  ├─ FirestorePigeonParser.h
   │  │     │  │  │        │     │  ├─ FLTDocumentSnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreExtension.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreReader.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreUtils.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreWriter.h
   │  │     │  │  │        │     │  ├─ FLTLoadBundleStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTQuerySnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTSnapshotsInSyncStreamHandler.h
   │  │     │  │  │        │     │  └─ FLTTransactionStreamHandler.h
   │  │     │  │  │        │     └─ Public
   │  │     │  │  │        │        ├─ CustomPigeonHeaderFirestore.h
   │  │     │  │  │        │        ├─ FirestoreMessages.g.h
   │  │     │  │  │        │        └─ FLTFirebaseFirestorePlugin.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ cloud_firestore.podspec
   │  │     │  │  └─ generated_firebase_sdk_version.txt
   │  │     │  ├─ lib
   │  │     │  │  ├─ cloud_firestore.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ aggregate_query.dart
   │  │     │  │     ├─ aggregate_query_snapshot.dart
   │  │     │  │     ├─ collection_reference.dart
   │  │     │  │     ├─ document_change.dart
   │  │     │  │     ├─ document_reference.dart
   │  │     │  │     ├─ document_snapshot.dart
   │  │     │  │     ├─ field_value.dart
   │  │     │  │     ├─ filters.dart
   │  │     │  │     ├─ firestore.dart
   │  │     │  │     ├─ load_bundle_task.dart
   │  │     │  │     ├─ load_bundle_task_snapshot.dart
   │  │     │  │     ├─ persistent_cache_index_manager.dart
   │  │     │  │     ├─ query.dart
   │  │     │  │     ├─ query_document_snapshot.dart
   │  │     │  │     ├─ query_snapshot.dart
   │  │     │  │     ├─ snapshot_metadata.dart
   │  │     │  │     ├─ transaction.dart
   │  │     │  │     ├─ utils
   │  │     │  │     │  └─ codec_utility.dart
   │  │     │  │     └─ write_batch.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ cloud_firestore
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ cloud_firestore
   │  │     │  │  │        ├─ FirestoreMessages.g.m
   │  │     │  │  │        ├─ FirestorePigeonParser.m
   │  │     │  │  │        ├─ FLTDocumentSnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreExtension.m
   │  │     │  │  │        ├─ FLTFirebaseFirestorePlugin.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreReader.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreUtils.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreWriter.m
   │  │     │  │  │        ├─ FLTLoadBundleStreamHandler.m
   │  │     │  │  │        ├─ FLTQuerySnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTSnapshotsInSyncStreamHandler.m
   │  │     │  │  │        ├─ FLTTransactionStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ cloud_firestore
   │  │     │  │  │        │     ├─ Private
   │  │     │  │  │        │     │  ├─ FirestorePigeonParser.h
   │  │     │  │  │        │     │  ├─ FLTDocumentSnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreExtension.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreReader.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreUtils.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreWriter.h
   │  │     │  │  │        │     │  ├─ FLTLoadBundleStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTQuerySnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTSnapshotsInSyncStreamHandler.h
   │  │     │  │  │        │     │  └─ FLTTransactionStreamHandler.h
   │  │     │  │  │        │     └─ Public
   │  │     │  │  │        │        ├─ CustomPigeonHeaderFirestore.h
   │  │     │  │  │        │        ├─ FirestoreMessages.g.h
   │  │     │  │  │        │        └─ FLTFirebaseFirestorePlugin.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  └─ cloud_firestore.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ cloud_firestore_test.dart
   │  │     │  │  ├─ collection_reference_test.dart
   │  │     │  │  ├─ field_value_test.dart
   │  │     │  │  ├─ mock.dart
   │  │     │  │  ├─ query_test.dart
   │  │     │  │  └─ test_firestore_message_codec.dart
   │  │     │  └─ windows
   │  │     │     ├─ cloud_firestore_plugin.cpp
   │  │     │     ├─ cloud_firestore_plugin.h
   │  │     │     ├─ cloud_firestore_plugin_c_api.cpp
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firestore_codec.cpp
   │  │     │     ├─ firestore_codec.h
   │  │     │     ├─ include
   │  │     │     │  └─ cloud_firestore
   │  │     │     │     └─ cloud_firestore_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ plugin_version.h.in
   │  │     │     └─ test
   │  │     │        └─ cloud_firestore_plugin_test.cpp
   │  │     ├─ file_picker
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ proguard-rules.pro
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ kotlin
   │  │     │  │           └─ com
   │  │     │  │              └─ mr
   │  │     │  │                 └─ flutter
   │  │     │  │                    └─ plugin
   │  │     │  │                       └─ filepicker
   │  │     │  │                          ├─ FileInfo.kt
   │  │     │  │                          ├─ FilePickerDelegate.kt
   │  │     │  │                          ├─ FilePickerPlugin.kt
   │  │     │  │                          ├─ FileUtils.kt
   │  │     │  │                          └─ MethodResultWrapper.kt
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ CONTRIBUTING.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle.kts
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ com
   │  │     │  │  │  │     │  │     └─ mr
   │  │     │  │  │  │     │  │        └─ flutter
   │  │     │  │  │  │     │  │           └─ plugin
   │  │     │  │  │  │     │  │              └─ filepicker
   │  │     │  │  │  │     │  │                 └─ file_picker_example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle.kts
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle.kts
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ gpxgenerator_path.gpx
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ File.swift
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ main.m
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ Package.resolved
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  ├─ main_desktop.dart
   │  │     │  │  │  └─ src
   │  │     │  │  │     └─ file_picker_demo.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  │  ├─ generated_plugins.cmake
   │  │     │  │  │  │  ├─ generated_plugin_registrant.cc
   │  │     │  │  │  │  └─ generated_plugin_registrant.h
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ screenshots
   │  │     │  │  │  ├─ example_android.gif
   │  │     │  │  │  ├─ example_ios.gif
   │  │     │  │  │  ├─ example_linux.gif
   │  │     │  │  │  ├─ example_macos.gif
   │  │     │  │  │  └─ example_windows.gif
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  └─ Icon-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  ├─ generated_plugins.cmake
   │  │     │  │     │  ├─ generated_plugin_registrant.cc
   │  │     │  │     │  └─ generated_plugin_registrant.h
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ file_picker
   │  │     │  │  │  ├─ Package.resolved
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ file_picker
   │  │     │  │  │        ├─ FileInfo.m
   │  │     │  │  │        ├─ FilePickerPlugin.m
   │  │     │  │  │        ├─ FileUtils.m
   │  │     │  │  │        ├─ ImageUtils.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ file_picker
   │  │     │  │  │        │  │  ├─ FileInfo.h
   │  │     │  │  │        │  │  ├─ FilePickerPlugin.h
   │  │     │  │  │        │  │  ├─ FileUtils.h
   │  │     │  │  │        │  │  └─ ImageUtils.h
   │  │     │  │  │        │  ├─ file_picker-umbrella.h
   │  │     │  │  │        │  └─ file_picker.modulemap
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ file_picker.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ file_picker.dart
   │  │     │  │  ├─ src
   │  │     │  │  │  ├─ exceptions.dart
   │  │     │  │  │  ├─ file_picker.dart
   │  │     │  │  │  ├─ file_picker_io.dart
   │  │     │  │  │  ├─ file_picker_macos.dart
   │  │     │  │  │  ├─ file_picker_result.dart
   │  │     │  │  │  ├─ linux
   │  │     │  │  │  │  ├─ file_picker_linux.dart
   │  │     │  │  │  │  ├─ filters.dart
   │  │     │  │  │  │  ├─ xdp_filechooser.dart
   │  │     │  │  │  │  └─ xdp_request.dart
   │  │     │  │  │  ├─ platform_file.dart
   │  │     │  │  │  ├─ utils.dart
   │  │     │  │  │  └─ windows
   │  │     │  │  │     ├─ file_picker_windows.dart
   │  │     │  │  │     ├─ file_picker_windows_ffi_types.dart
   │  │     │  │  │     └─ file_picker_windows_stub.dart
   │  │     │  │  └─ _internal
   │  │     │  │     └─ file_picker_web.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ file_picker
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ file_picker
   │  │     │  │  │        ├─ FilePickerPlugin.swift
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ file_picker.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ common.dart
   │  │     │     ├─ file_picker_macos_test.dart
   │  │     │     ├─ file_picker_utils_test.dart
   │  │     │     ├─ file_picker_windows_test.dart
   │  │     │     ├─ linux
   │  │     │     │  └─ xdp_filter_test.dart
   │  │     │     └─ test_files
   │  │     │        ├─ franz-michael-schneeberger-unsplash.jpg
   │  │     │        ├─ test.pdf
   │  │     │        └─ test.yml
   │  │     ├─ firebase_auth
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ auth
   │  │     │  │  │                       ├─ AuthStateChannelStreamHandler.java
   │  │     │  │  │                       ├─ Constants.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthPlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthPluginException.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthUser.java
   │  │     │  │  │                       ├─ FlutterFirebaseMultiFactor.java
   │  │     │  │  │                       ├─ FlutterFirebaseTotpMultiFactor.java
   │  │     │  │  │                       ├─ FlutterFirebaseTotpSecret.java
   │  │     │  │  │                       ├─ GeneratedAndroidFirebaseAuth.java
   │  │     │  │  │                       ├─ IdTokenChannelStreamHandler.java
   │  │     │  │  │                       ├─ PhoneNumberVerificationStreamHandler.java
   │  │     │  │  │                       └─ PigeonParser.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebase
   │  │     │  │  │  │     │  │              └─ auth
   │  │     │  │  │  │     │  │                 └─ example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ main.m
   │  │     │  │  │  │  ├─ Runner-Bridging-Header.h
   │  │     │  │  │  │  └─ Runner.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        ├─ swiftpm
   │  │     │  │  │        │  └─ configuration
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ auth.dart
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  └─ profile.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ firebase_auth
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_auth
   │  │     │  │  │        ├─ firebase_auth_messages.g.m
   │  │     │  │  │        ├─ FLTAuthStateChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseAuthPlugin.m
   │  │     │  │  │        ├─ FLTIdTokenChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTPhoneNumberVerificationStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ Private
   │  │     │  │  │        │  │  ├─ FLTAuthStateChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTIdTokenChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTPhoneNumberVerificationStreamHandler.h
   │  │     │  │  │        │  │  └─ PigeonParser.h
   │  │     │  │  │        │  └─ Public
   │  │     │  │  │        │     ├─ CustomPigeonHeader.h
   │  │     │  │  │        │     ├─ firebase_auth_messages.g.h
   │  │     │  │  │        │     └─ FLTFirebaseAuthPlugin.h
   │  │     │  │  │        ├─ PigeonParser.m
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ firebase_auth.podspec
   │  │     │  │  └─ generated_firebase_sdk_version.txt
   │  │     │  ├─ lib
   │  │     │  │  ├─ firebase_auth.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ confirmation_result.dart
   │  │     │  │     ├─ firebase_auth.dart
   │  │     │  │     ├─ multi_factor.dart
   │  │     │  │     ├─ recaptcha_verifier.dart
   │  │     │  │     ├─ user.dart
   │  │     │  │     └─ user_credential.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ firebase_auth
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_auth
   │  │     │  │  │        ├─ firebase_auth_messages.g.m
   │  │     │  │  │        ├─ FLTAuthStateChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseAuthPlugin.m
   │  │     │  │  │        ├─ FLTIdTokenChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTPhoneNumberVerificationStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ Private
   │  │     │  │  │        │  │  ├─ FLTAuthStateChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTIdTokenChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTPhoneNumberVerificationStreamHandler.h
   │  │     │  │  │        │  │  └─ PigeonParser.h
   │  │     │  │  │        │  └─ Public
   │  │     │  │  │        │     ├─ CustomPigeonHeader.h
   │  │     │  │  │        │     ├─ firebase_auth_messages.g.h
   │  │     │  │  │        │     └─ FLTFirebaseAuthPlugin.h
   │  │     │  │  │        ├─ PigeonParser.m
   │  │     │  │  │        └─ Resource
   │  │     │  │  └─ firebase_auth.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ firebase_auth_test.dart
   │  │     │  │  ├─ mock.dart
   │  │     │  │  └─ user_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firebase_auth_plugin.cpp
   │  │     │     ├─ firebase_auth_plugin.h
   │  │     │     ├─ firebase_auth_plugin_c_api.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ firebase_auth
   │  │     │     │     └─ firebase_auth_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ plugin_version.h.in
   │  │     │     └─ test
   │  │     │        └─ firebase_auth_plugin_test.cpp
   │  │     └─ firebase_core
   │  │        ├─ android
   │  │        │  ├─ build.gradle
   │  │        │  ├─ gradle
   │  │        │  │  └─ wrapper
   │  │        │  │     └─ gradle-wrapper.properties
   │  │        │  ├─ gradle.properties
   │  │        │  ├─ local-config.gradle
   │  │        │  ├─ settings.gradle
   │  │        │  ├─ src
   │  │        │  │  └─ main
   │  │        │  │     ├─ AndroidManifest.xml
   │  │        │  │     └─ java
   │  │        │  │        └─ io
   │  │        │  │           └─ flutter
   │  │        │  │              └─ plugins
   │  │        │  │                 └─ firebase
   │  │        │  │                    └─ core
   │  │        │  │                       ├─ FlutterFirebaseCorePlugin.java
   │  │        │  │                       ├─ FlutterFirebaseCoreRegistrar.java
   │  │        │  │                       ├─ FlutterFirebasePlugin.java
   │  │        │  │                       ├─ FlutterFirebasePluginRegistry.java
   │  │        │  │                       └─ GeneratedAndroidFirebaseCore.java
   │  │        │  └─ user-agent.gradle
   │  │        ├─ CHANGELOG.md
   │  │        ├─ example
   │  │        │  ├─ analysis_options.yaml
   │  │        │  ├─ android
   │  │        │  │  ├─ app
   │  │        │  │  │  ├─ build.gradle
   │  │        │  │  │  ├─ google-services.json
   │  │        │  │  │  └─ src
   │  │        │  │  │     ├─ debug
   │  │        │  │  │     │  └─ AndroidManifest.xml
   │  │        │  │  │     ├─ main
   │  │        │  │  │     │  ├─ AndroidManifest.xml
   │  │        │  │  │     │  ├─ java
   │  │        │  │  │     │  │  └─ io
   │  │        │  │  │     │  │     └─ flutter
   │  │        │  │  │     │  │        └─ plugins
   │  │        │  │  │     │  ├─ kotlin
   │  │        │  │  │     │  │  └─ io
   │  │        │  │  │     │  │     └─ flutter
   │  │        │  │  │     │  │        └─ plugins
   │  │        │  │  │     │  │           └─ firebasecoreexample
   │  │        │  │  │     │  │              └─ MainActivity.kt
   │  │        │  │  │     │  └─ res
   │  │        │  │  │     │     ├─ drawable
   │  │        │  │  │     │     │  └─ launch_background.xml
   │  │        │  │  │     │     ├─ drawable-v21
   │  │        │  │  │     │     │  └─ launch_background.xml
   │  │        │  │  │     │     ├─ mipmap-hdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-mdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xxhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xxxhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ values
   │  │        │  │  │     │     │  └─ styles.xml
   │  │        │  │  │     │     └─ values-night
   │  │        │  │  │     │        └─ styles.xml
   │  │        │  │  │     └─ profile
   │  │        │  │  │        └─ AndroidManifest.xml
   │  │        │  │  ├─ build.gradle
   │  │        │  │  ├─ gradle
   │  │        │  │  │  └─ wrapper
   │  │        │  │  │     └─ gradle-wrapper.properties
   │  │        │  │  ├─ gradle.properties
   │  │        │  │  └─ settings.gradle
   │  │        │  ├─ ios
   │  │        │  │  ├─ Flutter
   │  │        │  │  │  ├─ AppFrameworkInfo.plist
   │  │        │  │  │  ├─ Debug.xcconfig
   │  │        │  │  │  └─ Release.xcconfig
   │  │        │  │  ├─ Podfile
   │  │        │  │  ├─ Runner
   │  │        │  │  │  ├─ AppDelegate.h
   │  │        │  │  │  ├─ AppDelegate.m
   │  │        │  │  │  ├─ Assets.xcassets
   │  │        │  │  │  │  ├─ AppIcon.appiconset
   │  │        │  │  │  │  │  ├─ Contents.json
   │  │        │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │        │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │        │  │  │  │  └─ LaunchImage.imageset
   │  │        │  │  │  │     ├─ Contents.json
   │  │        │  │  │  │     ├─ LaunchImage.png
   │  │        │  │  │  │     ├─ LaunchImage@2x.png
   │  │        │  │  │  │     ├─ LaunchImage@3x.png
   │  │        │  │  │  │     └─ README.md
   │  │        │  │  │  ├─ Base.lproj
   │  │        │  │  │  │  ├─ LaunchScreen.storyboard
   │  │        │  │  │  │  └─ Main.storyboard
   │  │        │  │  │  ├─ Info.plist
   │  │        │  │  │  └─ main.m
   │  │        │  │  ├─ Runner.xcodeproj
   │  │        │  │  │  ├─ project.pbxproj
   │  │        │  │  │  ├─ project.xcworkspace
   │  │        │  │  │  │  ├─ contents.xcworkspacedata
   │  │        │  │  │  │  └─ xcshareddata
   │  │        │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     └─ xcschemes
   │  │        │  │  │        └─ Runner.xcscheme
   │  │        │  │  └─ Runner.xcworkspace
   │  │        │  │     ├─ contents.xcworkspacedata
   │  │        │  │     └─ xcshareddata
   │  │        │  │        └─ IDEWorkspaceChecks.plist
   │  │        │  ├─ lib
   │  │        │  │  ├─ firebase_options.dart
   │  │        │  │  └─ main.dart
   │  │        │  ├─ macos
   │  │        │  │  ├─ Flutter
   │  │        │  │  │  ├─ Flutter-Debug.xcconfig
   │  │        │  │  │  └─ Flutter-Release.xcconfig
   │  │        │  │  ├─ Podfile
   │  │        │  │  ├─ Runner
   │  │        │  │  │  ├─ AppDelegate.swift
   │  │        │  │  │  ├─ Assets.xcassets
   │  │        │  │  │  │  └─ AppIcon.appiconset
   │  │        │  │  │  │     ├─ app_icon_1024.png
   │  │        │  │  │  │     ├─ app_icon_128.png
   │  │        │  │  │  │     ├─ app_icon_16.png
   │  │        │  │  │  │     ├─ app_icon_256.png
   │  │        │  │  │  │     ├─ app_icon_32.png
   │  │        │  │  │  │     ├─ app_icon_512.png
   │  │        │  │  │  │     ├─ app_icon_64.png
   │  │        │  │  │  │     └─ Contents.json
   │  │        │  │  │  ├─ Base.lproj
   │  │        │  │  │  │  └─ MainMenu.xib
   │  │        │  │  │  ├─ Configs
   │  │        │  │  │  │  ├─ AppInfo.xcconfig
   │  │        │  │  │  │  ├─ Debug.xcconfig
   │  │        │  │  │  │  ├─ Release.xcconfig
   │  │        │  │  │  │  └─ Warnings.xcconfig
   │  │        │  │  │  ├─ DebugProfile.entitlements
   │  │        │  │  │  ├─ Info.plist
   │  │        │  │  │  ├─ MainFlutterWindow.swift
   │  │        │  │  │  └─ Release.entitlements
   │  │        │  │  ├─ Runner.xcodeproj
   │  │        │  │  │  ├─ project.pbxproj
   │  │        │  │  │  ├─ project.xcworkspace
   │  │        │  │  │  │  ├─ contents.xcworkspacedata
   │  │        │  │  │  │  └─ xcshareddata
   │  │        │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     └─ xcschemes
   │  │        │  │  │        └─ Runner.xcscheme
   │  │        │  │  └─ Runner.xcworkspace
   │  │        │  │     ├─ contents.xcworkspacedata
   │  │        │  │     └─ xcshareddata
   │  │        │  │        ├─ IDEWorkspaceChecks.plist
   │  │        │  │        └─ WorkspaceSettings.xcsettings
   │  │        │  ├─ pubspec.yaml
   │  │        │  ├─ README.md
   │  │        │  ├─ web
   │  │        │  │  ├─ favicon.png
   │  │        │  │  ├─ icons
   │  │        │  │  │  ├─ Icon-192.png
   │  │        │  │  │  ├─ Icon-512.png
   │  │        │  │  │  ├─ Icon-maskable-192.png
   │  │        │  │  │  └─ Icon-maskable-512.png
   │  │        │  │  ├─ index.html
   │  │        │  │  └─ manifest.json
   │  │        │  └─ windows
   │  │        │     ├─ CMakeLists.txt
   │  │        │     ├─ flutter
   │  │        │     │  └─ CMakeLists.txt
   │  │        │     └─ runner
   │  │        │        ├─ CMakeLists.txt
   │  │        │        ├─ flutter_window.cpp
   │  │        │        ├─ flutter_window.h
   │  │        │        ├─ main.cpp
   │  │        │        ├─ resource.h
   │  │        │        ├─ resources
   │  │        │        │  └─ app_icon.ico
   │  │        │        ├─ runner.exe.manifest
   │  │        │        ├─ Runner.rc
   │  │        │        ├─ utils.cpp
   │  │        │        ├─ utils.h
   │  │        │        ├─ win32_window.cpp
   │  │        │        └─ win32_window.h
   │  │        ├─ ios
   │  │        │  ├─ firebase_core
   │  │        │  │  ├─ Package.swift
   │  │        │  │  └─ Sources
   │  │        │  │     └─ firebase_core
   │  │        │  │        ├─ dummy.m
   │  │        │  │        ├─ FLTFirebaseCorePlugin.m
   │  │        │  │        ├─ FLTFirebasePlugin.m
   │  │        │  │        ├─ FLTFirebasePluginRegistry.m
   │  │        │  │        ├─ include
   │  │        │  │        │  └─ firebase_core
   │  │        │  │        │     ├─ dummy.h
   │  │        │  │        │     ├─ FLTFirebaseCorePlugin.h
   │  │        │  │        │     ├─ FLTFirebasePlugin.h
   │  │        │  │        │     ├─ FLTFirebasePluginRegistry.h
   │  │        │  │        │     └─ messages.g.h
   │  │        │  │        ├─ messages.g.m
   │  │        │  │        └─ Resources
   │  │        │  ├─ firebase_core.podspec
   │  │        │  └─ firebase_sdk_version.rb
   │  │        ├─ lib
   │  │        │  ├─ firebase_core.dart
   │  │        │  └─ src
   │  │        │     ├─ firebase.dart
   │  │        │     ├─ firebase_app.dart
   │  │        │     └─ port_mapping.dart
   │  │        ├─ LICENSE
   │  │        ├─ macos
   │  │        │  ├─ firebase_core
   │  │        │  │  ├─ Package.swift
   │  │        │  │  └─ Sources
   │  │        │  │     └─ firebase_core
   │  │        │  │        ├─ dummy.m
   │  │        │  │        ├─ FLTFirebaseCorePlugin.m
   │  │        │  │        ├─ FLTFirebasePlugin.m
   │  │        │  │        ├─ FLTFirebasePluginRegistry.m
   │  │        │  │        ├─ include
   │  │        │  │        │  ├─ dummy.h
   │  │        │  │        │  └─ firebase_core
   │  │        │  │        │     ├─ FLTFirebaseCorePlugin.h
   │  │        │  │        │     ├─ FLTFirebasePlugin.h
   │  │        │  │        │     ├─ FLTFirebasePluginRegistry.h
   │  │        │  │        │     └─ messages.g.h
   │  │        │  │        ├─ messages.g.m
   │  │        │  │        └─ Resources
   │  │        │  └─ firebase_core.podspec
   │  │        ├─ pubspec.yaml
   │  │        ├─ README.md
   │  │        ├─ test
   │  │        │  └─ firebase_core_test.dart
   │  │        └─ windows
   │  │           ├─ CMakeLists.txt
   │  │           ├─ firebase_core_plugin.cpp
   │  │           ├─ firebase_core_plugin.h
   │  │           ├─ firebase_core_plugin_c_api.cpp
   │  │           ├─ include
   │  │           │  └─ firebase_core
   │  │           │     └─ firebase_core_plugin_c_api.h
   │  │           ├─ messages.g.cpp
   │  │           ├─ messages.g.h
   │  │           └─ plugin_version.h.in
   │  ├─ generated_plugins.cmake
   │  ├─ generated_plugin_registrant.cc
   │  └─ generated_plugin_registrant.h
   └─ runner
      ├─ CMakeLists.txt
      ├─ flutter_window.cpp
      ├─ flutter_window.h
      ├─ main.cpp
      ├─ resource.h
      ├─ resources
      │  └─ app_icon.ico
      ├─ runner.exe.manifest
      ├─ Runner.rc
      ├─ utils.cpp
      ├─ utils.h
      ├─ win32_window.cpp
      └─ win32_window.h

```