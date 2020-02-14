# Hello World Rails app - containerized with Docker
To get this app running in the command line run these two commands 
```
$ docker build -t hello-world .
$ docker container run -p 3000:3000 hello-world
```


```kubectl create -f kubernetes/minikube/jenkins-namespace.yaml```<br />
```kubectl create -f kubernetes/minikube/jenkins-volume.yaml```<br />
```helm repo add stable https://kubernetes-charts.storage.googleapis.com/```<br />
```helm install jenkins-demo -f kubernetes/helm/jenkins-values.yaml stable/jenkins --namespace jenkins-project```
