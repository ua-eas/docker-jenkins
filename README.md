# Description

This is the Jenkins Docker repository for the kuali tech team at UofA. This is where we install any additional plugins or tools used by Jenkins for the build process.

## Docker Name

Note that this is intended to work as a small service being proxied through apache on our tools box. We are using linking to allow apache to see this docker instance. So, in order for this to work properly, this should be deployed with --name "ksd-tools-jenkins"

## Volumes

Jenkins will put all configuration and workspaces in /var/jenkins_home. This should be a shared volume on our isilon. Currently, we have this is setup to put the Jenkins home in:

/uaccess/KATTS/Internal/UAF/tools/jenkins/jenkins_home

## Docker Run Example

Below is an example docker run command to get Jenkins running. 

    sudo docker run -d --name="ksd-tools-jenkins" \
    -e "JENKINS_OPTS=--prefix=/jenkins" \
    -e "JAVA_OPTS=-Duser.timezone=America/Phoenix -Dorg.jenkinsci.plugins.gitclient.Git.timeOut=30" \
    -v /uaccess/KATTS/Internal/UAF/tools/jenkins/jenkins_home:/var/jenkins_home \
    -v /kuali-configs/security/tools/jenkins:/security \
    -v /transaction/data/fs:/transactional \
    -v /kuali-configs/configuration/toolsbox/jenkins/resources:/configuration:ro \
    easksd/jenkins

