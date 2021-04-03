echo ">>>>>>> trying to create database and users"
if [ -n "${MONGO_INITDB_ROOT_USERNAME:-}" ] && [ -n "${MONGO_INITDB_ROOT_PASSWORD:-}" ]; then
# mongo -u root -p e296cd9f
mongo -u root -p e296cd9f<<EOF
db=db.getSiblingDB('database');
use database;
db.createUser({
  user:  'user',
  pwd: 'password',
  roles: [{
    role: 'readWrite',
    db: 'database'
  }]
});
EOF
else
    echo "MONGO_INITDB_ROOT_USERNAME and MONGO_INITDB_ROOT_PASSWORD must be provided. Some of these are missing, hence exiting database and user creation."
    exit 403
fi
