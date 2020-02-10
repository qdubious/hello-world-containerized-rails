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
                sh 'rvm install 2.5.7'
                sh 'unlink /usr/local/rvm/rubies/default && ln -s /usr/local/rvm/rubies/ruby-2.5.7 /usr/local/rvm/rubies/default'
                sh 'ruby -v'
            }
            stage('SCM') {
                checkout scm
            }
            stage('Build RoR') {
                 sh 'bundle update --bundler'
                 sh 'bundle install'
                 sh 'rake assets:precompile'
            }
        }
        container('dockerstuff'){
            stage('Build Container'){
                sh 'docker build -t hello-world-containerized-rails .'
            }
        }
    }
}
