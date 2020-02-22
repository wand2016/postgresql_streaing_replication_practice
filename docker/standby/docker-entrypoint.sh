#!/bin/bash

pg_basebackup -h master -U replication_user -D $PGDATA -Fp -Xs -R

cd /var/lib/postgresql/data

chmod 700 .
ls -ld
ls -lA

cat >> postgresql.auto.conf <<EOF
primary_conninfo = 'user=replication_user host=master port=5432 application_name=sby'
EOF

cat postgresql.auto.conf

pg_ctl start
bash
