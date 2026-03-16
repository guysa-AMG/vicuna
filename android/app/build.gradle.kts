import java.util.Properties
import java.io.FileInputStream
plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "za.medi.vicuna"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "za.medi.vicuna"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        externalNativeBuild {
            cmake {
                abiFilters("arm64-v8a")
                // Kotlin requires string arguments for cppFlags
                cppFlags("-std=c++11", "-frtti", "-fexceptions")
            }
        }
	
    }
    externalNativeBuild{
        cmake{
           
 path = file("../../native/CMakeLists.txt")

        }
    }
    signingConfigs {
        create("release") {
          val keystorePath = System.getenv("UPLOAD_KEYSTORE_FILE_PATH") ?: keystoreProperties.getProperty("storeFile")
            
            if (keystorePath != null) {
                storeFile = file(keystorePath)
                storePassword = System.getenv("UPLOAD_STORE_PASSWORD") ?: keystoreProperties.getProperty("storePassword")
                keyAlias = System.getenv("UPLOAD_KEY_ALIAS") ?: keystoreProperties.getProperty("keyAlias")
                keyPassword = System.getenv("UPLOAD_KEY_PASSWORD") ?: keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        getByName("release") {
            // This line applies the release signing config
            signingConfig = signingConfigs.getByName("release")
            
            isMinifyEnabled = false
            isShrinkResources = false
        }      
    }
}

flutter {
    source = "../.."
}
