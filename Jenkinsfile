pipeline {
    agent any
    environment {
        // Mapping Secret Text IDs from your screenshot
        UPLOAD_KEY_ALIAS      = credentials('keyAlias')
        UPLOAD_KEY_PASSWORD   = credentials('UPLOAD_KEY_PASSWORD')
        UPLOAD_STORE_PASSWORD  = credentials('UPLOAD_STORE_PASSWORD')
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
						sh "chown -R jenkins:jenkins /var/jenkins_home"
			            sh "chmod 777 ${env.WORKSPACE}/android/app"
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
				 withCredentials([
                    file(credentialsId: 'UPLOAD_KEYSTORE_FILE2', variable: 'JKS_PATH'),
                    file(credentialsId: 'GPLAY_JSON_KEY', variable: 'GPLAY_JSON_PATH')
                ]){
					 
					 script{

						 env.GPLAY_JSON_PATH="${GPLAY_JSON_PATH}"
						 sh "git config --global --add safe.directory /opt/flutter"
		sh "flutter pub get"
                dir('android') {
		    sh " printf \\e[31m upload_store_password: ${env.UPLOAD_STORE_PASSWORD}\\n upload_key_password: ${env.UPLOAD_KEY_PASSWORD}  \\e[0m\\n"
                    sh "bundle exec fastlane deploy build_number:4"
                }
				 }
					 
				 }
            }
        }
    }
    post {
		success{
			echo "Successfully built and deployed to playstore"
		}
		failure{
			echo "Pipline Failed Please Review and Fix the Issue to continue"
		}
			
        always {
           script {
		 node {
			sh "rm -rf ${env.WORKSPACE}/android/app/upload-keystore.jks"
		   }
		  }
        }
    }
}

