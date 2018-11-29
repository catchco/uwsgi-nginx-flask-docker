#! /usr/bin/env bash
set -e

# If there's a prestart.sh script in the /app directory, run it before starting
PRE_START_PATH=/app/prestart.sh
echo "Checking for script in $PRE_START_PATH"
if [ -f $PRE_START_PATH ] ; then
    echo "Running script $PRE_START_PATH"
    source $PRE_START_PATH
else 
    echo "There is no script $PRE_START_PATH"
fi

# Required
DB=${DB:-}
DB_USER=${DB_USER:-}
DB_PWD=${DB_PWD:-}
DB_HOST=${DB_HOST:-}

# Error if variables are not assigned
if [ "${DB}" == "" ]; then echo "Environment Var 'DB' must be defined"
elif [ "${DB_USER}" == "" ]; then echo "Environment Var 'DB_USER' must be defined"
elif [ "${DB_PWD}" == "" ]; then echo "Environment Var 'DB_PWD' must be defined"
elif [ "${DB_HOST}" == "" ]; then echo "Environment Var 'DB_HOST' must be defined"

# Start Supervisor, with Nginx and uWSGI
exec /usr/bin/supervisord
