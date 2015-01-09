#!/bin/sh

#
# If the environment variable DBPASS is set then use it as the database
# password, otherwise get the database to prompt for a password.
#
if [ -n "$DBAPASS" ]; then
  PASS="--password=$DBAPASS"
else
  PASS="-p"
fi

#
# Determine the working DSN
#
DSN=`./getconfig common/config/main-local.php components.db.dsn`

# Split the DSN
DBTYPE=`echo $DSN | cut -d: -f1`
DBHOST=`echo $DSN | cut -d';' -f1 | sed 's/.*host=//g'`
DBNAME=`echo $DSN | cut -d';' -f2 | sed 's/.*dbname=//g'`
DBUSER=`./getconfig common/config/main-local.php components.db.username`
DBPASS=`./getconfig common/config/main-local.php components.db.password`
DBCHAR=`./getconfig common/config/main-local.php components.db.charset`

echo "

Database Parameters
===================
Database Type:  $DBTYPE
Database Host:  $DBHOST
Database Name:  $DBNAME
Database User:  $DBUSER
Database Pass:  $DBPASS
Character Set:  $DBCHAR

"

#
# Drop and recreate the database to ensure it's clean.
#
echo "Recreating database ..."
case $DBTYPE in
  mysql)
    time mysql -u root $PASS -h $DBHOST << EOFMYSQLDB
SET FOREIGN_KEY_CHECKS=0;
DROP DATABASE IF EXISTS ${DBNAME};
CREATE DATABASE ${DBNAME} CHARACTER SET ${DBCHAR};
GRANT ALL ON ${DBNAME}.* TO ${DBUSER}@'%' IDENTIFIED BY '${DBPASS}';
GRANT ALL ON ${DBNAME}.* TO ${DBUSER}@'localhost' IDENTIFIED BY '${DBPASS}';
EOFMYSQLDB
    ;;
    
  pgsql)
    # TODO
    ;;
esac

#
# Run all of the migrations.
#
./migrate.sh

echo "Database creation complete.

"
