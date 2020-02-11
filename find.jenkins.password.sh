#! /bin/bash

printf $(kubectl get secret --namespace jenkins-project jenkins-demo -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

exit $@;
