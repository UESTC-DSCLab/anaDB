#!/bin/bash

# Download Cassandra from http://mirror.bit.edu.cn/apache/cassandra/3.11.2/apache-cassandra-3.11.2-bin.tar.gz
# and KairosDB from https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz

echo "Downloading and Extracting Cassandra..."
wget -O- http://mirror.bit.edu.cn/apache/cassandra/3.11.2/apache-cassandra-3.11.2-bin.tar.gz | tar -xz
mv apache-cassandra-3.11.2 cassandra

echo "Downloading and Extracting KairosDB..."
echo "Download from GitHub, so it may take some minutes..."
wget -O- https://github.com/kairosdb/kairosdb/releases/download/v1.2.1/kairosdb-1.2.1-1.tar.gz | tar -xz

# modify kairosDB's configuration to use cassandra
CurDIR=$(pwd)
cd kairosdb/conf/

sed 's/^kairosdb.service.datastore=org.kairosdb.datastore.h2.H2Module/#&/' kairosdb.properties -i
sed 's/^#\(kairosdb.service.datastore=org.kairosdb.datastore.cassandra.CassandraModule\)/\1/' kairosdb.properties -i

cd $CurDIR

# start cassandra and kairosdb or not
echo "if you want to run kairosDB now? y/n"

read choice

if [ $choice == "y" ] || [ $choice == "Y" ]; then 
    echo "starting now..."
    exec ./start.sh
else
    echo "BYE-BYE"
fi

exit 0
