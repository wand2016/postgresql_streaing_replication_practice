#!/bin/bash

pg_basebackup -h master -U replication_user -D $PGDATA -Fp -Xs -R

cd /var/lib/postgresql/data

chmod 700 .
ls -ld
ls -lA

cat >> postgresql.conf <<EOF
primary_conninfo = 'host=master user=replication_user database=postgres port=5432 application_name=sby'
EOF

pg_ctl start
bash
