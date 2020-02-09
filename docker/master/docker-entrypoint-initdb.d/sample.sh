#!/bin/bash

cd /var/lib/postgresql/data

# create replication user
psql -c "CREATE USER replication_user REPLICATION PASSWORD 'password';"
psql -c '\du'

# host-based authentication of replication standby servers
cat >> pg_hba.conf << EOF
host    replication     replication_user standby1     md5
host    replication     replication_user standby2     md5
EOF

pg_ctl reload

# ensure that hba settings are applied
psql -P pager -c 'SELECT * FROM pg_hba_file_rules'
