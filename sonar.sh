Step by Step process working with Sonar Qube.
--------------------------------------------

Minimum t3.medium (4GB RAM) required
Ensure port 9000 is open in EC2 security group

1) Lunch EC Instance with instance type as t2.medium

2) sudo yum update -y  - Latest Pathc update

3) sudo yum install java-17-amazon-corretto -y  --- Insatlling Java17

openjdk 17.0.18 2026-01-20 LTS
OpenJDK Runtime Environment Corretto-17.0.18.9.1 (build 17.0.18+9-LTS)
OpenJDK 64-Bit Server VM Corretto-17.0.18.9.1 (build 17.0.18+9-LTS, mixed mode, sharing)

4) Download & Install SonarQube

cd /opt
sudo yum install wget unzip -y --- Install wget and unzip utilities

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.5.0.89998.zip   -- download the zip files
sudo unzip sonarqube-*.zip -- unzip 
sudo mv sonarqube-* sonarqube


5) Create use sonarqube

sudo useradd -r -m -U -d /opt/sonarqube -s /bin/bash sonarqube

sudo chown -R sonarqube:sonarqube /opt/sonarqube-10.5.0.89998/

chmod 777 /opt/sonarqube-10.5.0.89998/

6) Go to Sonarqube path and start the services.

cd /opt/sonarqube-10.5.0.89998/bin/linux-x86-64

sh sonar.sh

7) Check the status of the services

sh sonar.sh status

8) allow port 9000 in SG for inbound

9) access sonarqube with public ip of the EC2 and port 9000


[sonarqube@ip-172-31-20-45 linux-x86-64]$ ss -tulnp
Netid        State         Recv-Q         Send-Q                                   Local Address:Port                  Peer Address:Port        Process                            
udp          UNCONN        0              0                                    172.31.20.45%enX0:68                         0.0.0.0:*                                              
udp          UNCONN        0              0                                            127.0.0.1:323                        0.0.0.0:*                                              
udp          UNCONN        0              0                                                [::1]:323                           [::]:*                                              
udp          UNCONN        0              0                      [fe80::8ff:f0ff:fe83:f5d9]%enX0:546                           [::]:*                                              
tcp          LISTEN        0              128                                            0.0.0.0:22                         0.0.0.0:*                                              
tcp          LISTEN        0              50                                  [::ffff:127.0.0.1]:9092                             *:*            users:(("java",pid=31526,fd=14))  
tcp          LISTEN        0              4096                                [::ffff:127.0.0.1]:33549                            *:*            users:(("java",pid=31473,fd=144)) 
tcp          LISTEN        0              4096                                [::ffff:127.0.0.1]:9001                             *:*            users:(("java",pid=31473,fd=149)) 
tcp          LISTEN        0              128                                               [::]:22                            [::]:*                                              
tcp          LISTEN        0              25                                                   *:9000                             *:*            users:(("java",pid=31526,fd=13))  



10) create project in sonarqube and generate token.

11) Click on maven take the generated code to scan the java code

mvn clean verify sonar:sonar \
  -Dsonar.projectKey=test123 \
  -Dsonar.projectName='test123' \
  -Dsonar.host.url=http://54.82.37.0:9000 \
  -Dsonar.token=sqp_1509c1d07a7a6e2330145225387d70f22b1b0afc
  
 12) Install maven in EC2 - sudo  yum install maven -y
 
 13) install git - sudo yum install git -y
 
 14) clone the git code - https://github.com/sagsrinu/maven_project.git
 
 15) execut the code which is mentioned in point No -11 in maven-proect path
 
 mvn clean verify sonar:sonar \
  -Dsonar.projectKey=test123 \
  -Dsonar.projectName='test123' \
  -Dsonar.host.url=http://54.82.37.0:9000 \
  -Dsonar.token=sqp_1509c1d07a7a6e2330145225387d70f22b1b0afc
  
 16) Check how many code violated the default rules in sonaqube - issues tab
 
 17) You can create own quaklity profile with selected rules
 
 18) attach this profile to the project
 
 
Quality profiles are a key part of your SonarQube configuration. They define the set of rules to be applied during code analysis.Quality profiles are a key part of your SonarQube configuration. 
They define the set of Overview to be applied during code analysis.Every project has a quality profile set for each supported language. When a project is analyzed, SonarQube determines
which languages are used and uses the active quality profile for each of those languages in that specific project.Go to Quality Profiles to see all the currently defined profiles grouped by language.

19) as on when you are chaning the rules you have to rerun the below code for scanner

 mvn clean verify sonar:sonar \
  -Dsonar.projectKey=test123 \
  -Dsonar.projectName='test123' \
  -Dsonar.host.url=http://54.82.37.0:9000 \
  -Dsonar.token=sqp_1509c1d07a7a6e2330145225387d70f22b1b0afc

  20) you can create new quality gates that would have custom conditions to scan the code give the result.


 
 

