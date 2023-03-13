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
                    sh 'token=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'
                    sh 'git tag -a v1.0.0 -m \"Release:v1.0.0\"'
                    sh 'Release_Details=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name":"v1.0.0","target_commitish":"main","name":"Release v1.0.0","body":"First release of caesar-cipher","draft":false,"prerelease":false}\' https://api.github.com/repos/$user/$repo/releases)'
                    sh 'git add caesar-cipher.jar'
                    sh 'git commit -m \"First release of caesar-cipher\"'
                    sh 'git push https://api.github.com/repos/$user/$release_repo?access_token=\"$token\" main'
                                        
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