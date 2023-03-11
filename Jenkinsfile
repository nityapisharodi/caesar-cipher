pipeline {
    agent any
    stages {
        stage ('Test') {
            steps {
                sh './gradlew test'
            }
        }
        stage ('Build') {
            steps {
                sh './gradlew build'
            }
        }
        stage ('Deploy/Show Output'){
            steps {
                echo 'Deploying/Outputing .....'
                sh 'java -jar build/libs/caesar-cipher.jar'
            }  
        }
   }
   post {
        always {
            archiveArtifacts artifacts: 'build/libs/caesar-cipher.jar', onlyIfSuccessful: true
        }
    }
}