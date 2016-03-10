#Start from the official Jenkins project
FROM jenkins

# We probably want to install some additional tools and such for our Jenkins server
USER root
RUN apt-get update && \
    apt-get install -y ruby ruby-dev gcc libaio1 make 

# Set the timezone
RUN ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime

# Copy in our setup scripts
COPY bin /root/bin
RUN chmod +x /root/bin/*

# create general shortcut environment variables
ENV SECURITY_DIRECTORY=/security
ENV JENKINS_CONFIG_DIRECTORY=/configuration

# Set Up Oracle Environment Variables
ENV ORA_SOURCE_DIR=/security/oracle
ENV ORA_BASE_DIR=/usr/lib/oracle
ENV ORA_LIB_DIR=$ORA_BASE_DIR/instantclient_12_1
ENV LD_LIBRARY_PATH=$ORA_LIB_DIR
ENV ORACLE_HOME=$ORA_LIB_DIR

#liquibase env variables
ENV LIQUIBASE_HOME=/usr/share/liquibase

# create liquibase home directory and subdirectories
RUN mkdir $LIQUIBASE_HOME
RUN mkdir $LIQUIBASE_HOME/lib

# put liquibase and ojdbc jar files in lib dir
COPY classes/liquibase-3.3.5.jar $LIQUIBASE_HOME/lib/
COPY $JENKINS_CONFIG_DIRECTORY/ojdbc6.jar $LIQUIBASE_HOME/lib/

ENTRYPOINT ["/bin/tini", "--", "/root/bin/run.sh"]
