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
        stage ('Release') {
            steps {
                script{
                    sh 'token="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"'
                    sh 'cp build/libs/caesar-cipher.jar caesar-cipher-r1.jar'
                    sh 'git add caesar-cipher-r1.jar'
                    sh 'git commit caesar-cipher-r1.jar -m "New release"'
                    sh 'git push https://github.com/nityapisharodi/caesar-cipher.git main'
                }

            }
        }
   }
   post {
        always {
            archiveArtifacts artifacts: 'build/libs/caesar-cipher.jar', onlyIfSuccessful: true
        }
    }
}