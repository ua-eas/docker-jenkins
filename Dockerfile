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

# Set Up Oracle Environment Variables
ENV ORA_SOURCE_DIR=/security/oracle
ENV ORA_BASE_DIR=/usr/lib/oracle
ENV ORA_LIB_DIR=$ORA_BASE_DIR/instantclient_12_1
ENV LD_LIBRARY_PATH=$ORA_LIB_DIR
ENV ORACLE_HOME=$ORA_LIB_DIR

ENTRYPOINT ["/bin/tini", "--", "/root/bin/run.sh"]
