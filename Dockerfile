#Start from the official Jenkins project
FROM jenkins

# We probably want to install some additional tools and such for our Jenkins server
USER root
RUN apt-get update && \
    apt-get install -y ruby make 
 
