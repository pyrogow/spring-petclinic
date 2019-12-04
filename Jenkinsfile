// pipeline {
//     agent any
    
//     stages {
//         stage ('Clone') {
//             steps {
//                 git branch: 'master', url: "https://github.com/pyrogow/spring-petclinic.git"
//                 echo "Succesfully cloned"
//             }
//         }
//         stage ('unit test and build') {
//             steps {
//                 sh 'mvn clean package'
//             }
//         }
//         stage('Deploy') {
//            steps {
//                 rtUpload (
//                     serverId: 'EpamArtifactory',
//                     spec: '''{
//                         "files": [
//                                     {
//                                         "pattern": "*SNAPSHOT.jar",
//                                         "target": "test/com/epamlabs/pyrohov/Job_F/"
//                                     }
//                         ]
//                     }'''
//                 )
//            }
//        }
//     }
// }
// environment {
//   ECRUrl = "591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main"
// }


pipeline {
  agent any
  environment {
    GIT_USERNAME = credentials('GIT_USERNAME')
    GIT_PASSWORD = credentials('GIT_PASSWORD')
    GIT_CREDENTIALS_ID = credentials('50f2207a-24b1-46d7-a0b1-f6ffc2b02a7f')
    GIT_REPO = credentials('GIT_REPO')
  }
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.5.2'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    }
    // stage('Docker Build') {
    //   agent any
    //   steps {
    //     sh 'docker build -t spring-petclinic:latest .'
    //   }
    // }
    stage('Docker build') {
      steps {
        script {
          imageTag = docker.build("591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:v1.0.${env.BUILD_NUMBER}")
          // docker.build("591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:${env.BUILD_NUMBER}")
          // docker.build("591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:latest")
        }
      }
    }
    stage('Push image to ECR') {
      steps {
        script {
          docker.withRegistry("https://591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main","ECR-Artifactory-Docker") {
            imageTag.push()
            imageTag.push('latest')
            // sh "docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:${env.BUILD_NUMBER}"
            // sh "docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:latest"
          }


          // docker.withRegistry("${env.ECRUrl}","ecr:eu-central-1:${env.AWSCredentials}") {
          //   docker.image("591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main-${env.BUILD_NUMBER}").push()
          // }
        }
      }
    }
    // stage('Tags') {
    //   docker.withCredentials([[$class: 'UsernamePasswordMultiBinding', 
    //     credentialsId: 'CREDS', 
    //     usernameVariable: 'GIT_USERNAME', 
    //     passwordVariable: 'GIT_PASSWORD']]) {    
    //     sh("git push https://${GIT_USERNAME}:${GIT_PASSWORD}@https://github.com/pyrogow/spring-petclinic.git --tags ${env.BUILD_NUMBER} latest")
    //     }
    // }
    // stage('Tags1') {
    //   steps {
    //     script {
    //       docker.withRegistry("https://github.com/pyrogow/spring-petclinic.git","50f2207a-24b1-46d7-a0b1-f6ffc2b02a7f") {
    //       // docker.withCredentials([usernamePassword(credentialsId: '50f2207a-24b1-46d7-a0b1-f6ffc2b02a7f', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
    //         sh("git tag -a v1.0.${env.BUILD_NUMBER} -m 'Tag of Job BUILD_NUMBER from Jenkins'")
    //         sh("git tag -fa v1.0.latest -m 'Tag of Job BUILD_NUMBER from Jenkins'")
    //         sh('git push https://github.com/pyrogow/spring-petclinic.git --tags')
    //         // sh "docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:${env.BUILD_NUMBER}"
    //         // sh "docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main:latest"
    //       }


    //       // docker.withRegistry("${env.ECRUrl}","ecr:eu-central-1:${env.AWSCredentials}") {
    //       //   docker.image("591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main-${env.BUILD_NUMBER}").push()
    //       // }
    //     }
    //   }
    // }

    stage('Tags') {
      steps {
        script{
          // sshagent(['50f2207a-24b1-46d7-a0b1-f6ffc2b02a7f']) {
          // sh("git tag ${env.BUILD_NUMBER}")
          // sh("git tag latest")
          // sh("git push --all")
          // sh("git push --tag")
          // }
          sshagent (credentials: ["${env.GIT_CREDENTIALS_ID}"]) {
            sh("git tag -a v1.0.${env.BUILD_NUMBER} -m 'Tag of Job BUILD_NUMBER from Jenkins'")
            sh("git tag -fa v1.0.latest -m 'Tag of Job BUILD_NUMBER from Jenkins'")
            sh("git push https://${env.GIT_USERNAME}:${env.GIT_PASSWORD}@${env.GIT_REPO} --tags")
          }
        }
      }
      
      // docker.withCredentials([[$class: 'UsernamePasswordMultiBinding', 
      //   credentialsId: '50f2207a-24b1-46d7-a0b1-f6ffc2b02a7f', 
      //   usernameVariable: 'GIT_USERNAME', 
      //   passwordVariable: 'GIT_PASSWORD']]) {    
      //   sh("git push https://${GIT_USERNAME}:${GIT_PASSWORD}@https://github.com/pyrogow/spring-petclinic.git --tags ${env.BUILD_NUMBER} latest")
      //   }
    }
  }
}

    // stage('Docker Build and push image to ECS') {
    //   agent {
    //     docker {
    //       // docker.withRegistry([credentialsId: "${env.ASW-Credentials}", uri: "${env.ECRUrl}"]){
    //       docker.build("${env.ECRUrl}:${env.BUILD_NUMBER}", ".")
    //       // }
    //     }
    //   }
      // agent any
      // steps {
      //   sh 'docker build -t pyrogow/app1:latest .'
      //   sh "${(aws ecr get-login --no-include-email --region=eu-central-1)}"
      //   // sh 'aws ecr get-login --no-include-email --region=eu-central-1 > login.sh'
      //   // sh 'sudo chmod +x login.sh'
      //   // sh './login.sh'
      //   sh 'docker tag pyrogow/app1:latest https://591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main'
      //   sh 'docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main'
      // }
    // }