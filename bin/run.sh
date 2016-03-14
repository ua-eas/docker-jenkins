#!/bin/bash

# Install the Oracle Client Tools
/root/bin/install_oracle.sh

# copy the ojdbc file needed for liquibase from the volume into the liquibase directory
cp $JENKINS_CONFIG_DIRECTORY/ojdbc6.jar $LIQUIBASE_HOME/lib/

# Run Jenkins
/usr/local/bin/jenkins.sh
