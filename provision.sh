#!/bin/bash

echo "Beginning Provisioning Run"
date

apt-get update
apt-get -y upgrade

which java -version

if [ ! $? -eq 0 ]
then
	
	# - anyone see a problem here?
	sudo apt-get -y install default-jdk

	if ! grep --quiet "java-7-openjdk-amd64" ~/.bashrc
	then		
		echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> ~/.bashrc
	fi

	export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
fi

which mvn --version

if [ ! $? -eq 0 ]
then

	if [ ! -d /usr/share/apache-maven-3.2.3 ]
	then

		if [ ! -f apache-maven-3.2.3-bin.tar.gz ]
		then
			wget http://www.trieuvan.com/apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
		fi

		tar -xf apache-maven-3.2.3-bin.tar.gz
		rm apache-maven-3.2.3-bin.tar.gz
		mv apache-maven-3.2.3 /usr/share
	fi

	if ! grep --quiet "apache-maven" ~/.bashrc
	then		
		echo "export PATH=$PATH:/usr/share/apache-maven-3.2.3/bin" >> ~/.bashrc
	fi

	export PATH=$PATH:/usr/share/apache-maven-3.2.3/bin
fi

cd /vagrant

validate, initialize, generate-sources, process-sources, generate-resources, process-resources, compile, process-classes, generate-test-sources, process-test-sources, generate-test-resources, 
process-test-resources, test-compile, process-test-classes, test, prepare-package, package, pre-integration-test, integration-test, post-integration-test, verify, install, deploy, pre-clean, clean, 
post-clean, pre-site, site, post-site, site-deploy

mvn -f pom_provision_demo.xml clean
mvn -f pom_provision_demo.xml compile
mvn -f pom_provision_demo.xml test
mvn -f pom_provision_demo.xml package

echo "Provisioning Run Complete"
date
