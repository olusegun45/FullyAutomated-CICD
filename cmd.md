Create an Amazon Linux 2 VM instance and call it "Jenkins"
Instance type: t2.large
Security Group (Open): 8080, 9100 and 22 to 0.0.0.0/0
Key pair: Select or create a new keypair
Attach Jenkins server with IAM role having "AdministratorAccess"
User data (Copy the following user data): https://github.com/cvamsikrishna11/devops-fully-automated/blob/installations/jenkins-maven-ansible-setup.sh
Launch Instance
After launching this Jenkins server, attach a tag as Key=Application, value=jenkins

to check if the user data is running of part of it failed.
log in to the ec2 while it still initialising
change to root user  "sudo su"
cd to var directory, cd to log, do ls and cat cloud-init-output.log ===> cat /var/log/cloud-init-output.log

Set up Jenkins
Click on New, Name = app-infra-pipeline and select the pipeline

Create IAM Role
goto IAM, select Role, create role, select aws Sevice, for use cace select EC2 next add permission select Adminstrator Access
Name = Jenkins-cicd-Admin-Role, then create.
Now attache this role to Jenkins server
Select the running Jenkins server, click on action, click on security and modify IAM role, select the the role created from the dropdown and update.


Payload Url:
    http://18.191.29.20:8080/github-webhook/
Refresh to see a check mark: meaning ur jenkins is reachable

click on the code and copy the url on ur github repository and go to the jenkins console click on the pipeline and configure, select the github project under General and paste the url there, then scroll down to Build Triger section select Github hook trigger for GITScm polling
