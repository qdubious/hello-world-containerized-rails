podTemplate(label: 'ror', containers: [
    containerTemplate(name: 'dockerstuff', image: 'docker:latest', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'rvm', image: 'nwtgck/rvm-ruby', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
      hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
  ]) {
    node('ror') {
        container('rvm') {
            stage('SCM') {
                checkout scm
            }
            stage('Install NPM') {
                sh 'curl -sL https://deb.nodesource.com/setup_10.x | bash -'
                sh 'apt-get update -y'
                sh 'apt-get remove libpq5'
                sh 'apt-get install -y nodejs libpq-dev tzdata'
                sh 'npm install -g yarn'
                sh 'yarn install --check-files'
            }
            stage('Install Ruby') {
                sh 'rvm install 2.5.7'
                sh 'unlink /usr/local/rvm/rubies/default && ln -s /usr/local/rvm/rubies/ruby-2.5.7 /usr/local/rvm/rubies/default'
                sh 'ruby -v'
            }
            stage('Build RoR') {
                 sh 'gem update --system && bundle update --bundler'
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
