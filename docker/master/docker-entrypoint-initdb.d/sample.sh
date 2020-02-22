#!/bin/bash

cd /var/lib/postgresql/data

# create replication user
psql -c "CREATE USER replication_user REPLICATION;"
psql -c '\du'

# host-based authentication of replication standby servers
cat >> pg_hba.conf << EOF
host    replication     replication_user 0.0.0.0/0     trust
host    replication     replication_user 0.0.0.0/0     trust
EOF

cat >> postgresql.conf <<EOF
synchronous_standby_names = ''
log_connections = on
log_disconnections = on
log_replication_commands = on
EOF


pg_ctl reload

# ensure that hba settings are applied
psql -P pager -c 'SELECT * FROM pg_hba_file_rules'
