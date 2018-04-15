#!/bin/bash

# Start Cassandra
CurDIR=$(pwd)
cd cassandra/bin
CASSANDRA=$(pwd)

gnome-terminal --working-directory=$CASSANDRA -x bash -c "echo 'Starting Cassandra...'; sleep 1; ./cassandra -f; exec bash"

echo "wait 10s to ensure that Cassandra is running..."
sleep 10

cd $CurDIR
cd kairosdb/bin
KAIROSDB=$(pwd)

gnome-terminal --working-directory=$KAIROSDB -x bash -c "echo 'Starting KairosDB...'; sleep 1; ./kairosdb.sh run; exec bash"

exit 0