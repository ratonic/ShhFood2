// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.panic_button"
    compileSdk = flutter.compileSdkVersion

    // Fija la NDK que necesitan los plugins
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        // Activa desugar para coreLibraryDesugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.panic_button"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Necesario para flutter_local_notifications y otros que requieran desugar
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
}

flutter {
    source = "../.."
}
