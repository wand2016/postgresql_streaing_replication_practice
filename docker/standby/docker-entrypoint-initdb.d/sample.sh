#!/bin/bash

cd /var/lib/postgresql/data

cat >> postgresql.conf <<EOF
primary_conninfo = 'user=replication_user database=postgres port=5432 application_name=sby'
EOF
