pipeline {
    agent any
    environment {
        // Mapping Secret Text IDs from your screenshot
        UPLOAD_KEY_ALIAS      = credentials('keyAlias')
        UPLOAD_KEY_PASSWORD   = credentials('keyPass')
        UPLOAD_STORE_PASSWORD  = credentials('storePass')
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Prepare Secrets') {
            steps {
                // Handling Secret Files from your screenshot
                withCredentials([
                    file(credentialsId: 'UPLOAD_KEYSTORE_FILE2', variable: 'JKS_PATH'),
                    file(credentialsId: 'GPLAY_JSON_KEY', variable: 'GPLAY_JSON_PATH')
                ]) {
                    script {
                        // 1. Copy Keystore to the app folder for Gradle
                        sh "cp \$JKS_PATH ${env.WORKSPACE}/android/app/upload-keystore.jks"
                        env.UPLOAD_KEYSTORE_FILE_PATH = "${env.WORKSPACE}/android/app/upload-keystore.jks"
                        
                        // 2. Set the path for Fastlane to find the Play Store JSON
                        env.GPLAY_JSON_FILE_PATH = "\$GPLAY_JSON_PATH"
                    }
                }
            }
        }
        stage('Build & Deploy') {
            steps {
                sh "git config --global --add safe.directory /opt/flutter"
		sh "flutter pub get"
                dir('android') {
                    sh "bundle exec fastlane deploy build_number:${env.BUILD_NUMBER}"
                }
            }
        }
    }
    post {
        always {
           script {
		 node {
			sh "rm -f ${env.WORKSPACE}/android/app/upload-keystore.jks"
		   }
		  }
        }
    }
}

