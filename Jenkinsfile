podTemplate(label: 'ror', containers: [
    containerTemplate(name: 'dockerstuff', image: 'docker:latest', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'rvm', image: 'nwtgck/rvm-ruby', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
      hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
  ]) {
    node('ror') {
        container('rvm') {
            stage('Install System Dependencies'){
                sh 'apt-get update -y'
                sh 'apt-get remove libpq5'
                sh 'apt-get install -y libpq-dev nodejs tzdata'
            }
            stage('Install Ruby'){
                sh 'rvm use default'
                sh 'rvm install 2.5'
            }
            stage('SCM') {
                checkout scm
            }
            stage('Build RoR') {
                sh 'bundle install'
                sh 'rake assets:precompile'
            }
        }

        container('dockerstuff'){
            stage('Build Container'){
                sh 'docker build -t idw-pipeline-demo .'
            }
        }
    }
}