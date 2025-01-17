#!/bin/bash
if [ $1 == "start" ]
   then 
     docker build -t jingom368/apache2_mboard:1.0 ./apache2/
     docker build -t jingom368/tomcat9_mboard:1.0 ./tomcat9/
     docker build -t jingom368/mariadb_mboard:1.0 ./mariadb/
     docker push jingom368/apache2_mboard:1.0
     docker push jingom368/tomcat9_mboard:1.0
     docker push jingom368/mariadb_mboard:1.0
     docker rmi jingom368/apache2_mboard:1.0
     docker rmi jingom368/tomcat9_mboard:1.0
     docker rmi jingom368/mariadb_mboard:1.0
     kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
     kubectl apply -f ./yml/mariadb.yml
     kubectl apply -f ./yml/tomcat9.yml
     kubectl apply -f ./yml/apache2.yml
     kubectl apply -f ./yml/ingress.yml
fi

if [ $1 == "stop" ]
   then
     kubectl delete -f ./yml/ingress.yml
     kubectl delete -f ./yml/apache2.yml
     kubectl delete -f ./yml/tomcat9.yml
     kubectl delete -f ./yml/mariadb.yml
fi

