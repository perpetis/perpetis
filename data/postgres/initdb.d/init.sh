#!/bin/bash
set -eu

# ##
# function create_db() {
# 	local database=$1
# 	local user=$2

# 	echo "  Creating user and database '$database'"
# 	psql --username $user --no-password -v ON_ERROR_STOP=1 <<-EOSQL
# 	    CREATE USER $database;
# 	    CREATE DATABASE $database;
# 	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
#         GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
# EOSQL
#     psql --username $user --no-password -d "${database}" -c "CREATE EXTENSION IF NOT EXISTS pgcrypto"
#     psql --username $user --no-password -d "${database}" -c "CREATE EXTENSION IF NOT EXISTS vector"
# }

# #
# create_db documents admin
# create_db downloads admin
# create_db movies admin
# create_db music admin
# create_db pictures admin

# #
# create_db litellm admin

##
