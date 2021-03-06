#!/bin/bash
#
# This script copies a bunch of files from ORA_SOURCE_DIR (defined in Dockerfile) into various 
# places required to run the sqlplus command line tool for Oracle DB access.
#
if [ ! -d $ORA_BASE_DIR ] 
then
    mkdir $ORA_BASE_DIR
fi

unzip $ORA_SOURCE_DIR/instantclient-basic-linux.x64*.zip -d $ORA_BASE_DIR
unzip $ORA_SOURCE_DIR/instantclient-sqlplus-linux.x64*.zip -d $ORA_BASE_DIR
unzip $ORA_SOURCE_DIR/instantclient-sdk-linux.x64*.zip -d $ORA_BASE_DIR

echo "$ORA_LIB_DIR/" > /etc/ld.so.conf.d/oracle.conf
ldconfig

ln -s "$ORA_LIB_DIR/libclntsh.so.12.1" "$ORA_LIB_DIR/libclntsh.so"
ln -s "$ORA_LIB_DIR/sqlplus" /usr/bin/sqlplus

