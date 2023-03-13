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
                    sh 'user=nityapisharodi'
                    sh 'repo=caesar-cipher.git'
                    sh 'token=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'
                    sh 'Release_details=$(curl --data \'{"tag_name":"v1.0.0","target_commitish":"main","name":"Release v1.0.0","body":"First release of caesar-cipher","draft":false,"prerelease":false}\' https://api.github.com/repos/\"$user\"/\"$repo\"/releases?access_token=\"$token\")'
                    sh 'git tag -a v1.0.0 -m \"Release:v1.0.0\"'
                    sh 'git config --global user.name "$user"'
                    sh 'git config --global user.email "$user"@gmail.com'
                    sh 'git add caesar-cipher.jar'
                    sh 'git commit -m \"First release of caesar-cipher\"'
                    sh 'git push https://api.github.com/repos/\"$user\"/\"$repo\"/releases?access_token=\"$token\" main'
                                        
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