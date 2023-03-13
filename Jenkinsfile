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
                    sh 'repo=caesar-cipher'
                    sh 'release_repo=Project_release_repo'
                    sh 'token="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"'
                   
                    sh 'Release_Details=$(curl -XPOST -H "Authorization: token $token" --data \'{"tag_name":"v2.0.1","target_commitish":"main","name":"Release v1.0.0","body":"First release of caesar-cipher","draft":false,"prerelease":false}\' https://api.github.com/repos/nityapisharodi/caesar-cipher/releases)'
                    sh 'git add -f build/libs/caesar-cipher.jar'
                    sh 'git commit -m \"First release of caesar-cipher\"'
                    sh 'git push https://api.github.com/repos/nityapisharodi/Project_release_repo?access_token=$token main'
                                        
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