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

                withCredentials([string(credentialsId: 'jenkins-pipeline', variable: 'GITHUB_TOKEN')])
                {
                    sh 'git config credentials.helper "credential-helper.sh"'  
                    sh 'tag=$(git describe --tag)'
                    sh 'Release=$(curl -XPOST -H "Authorization: token $GITHUB_TOKEN" --data \'{"tag_name":"$tag","target_commitish":"main","name":"Release v1.0.0","body":"First release of caesar-cipher","draft":false,"prerelease":false}\' https://api.github.com/repos/nityapisharodi/caesar-cipher/releases)'
                    sh 'git add -f build/libs/caesar-cipher.jar'
                    sh 'git commit -m "First release of caesar-cipher"'
                    sh 'git push https://api.github.com/repos/nityapisharodi/Project_release_repo?access_token=$GITHUB_TOKEN main'

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
   
