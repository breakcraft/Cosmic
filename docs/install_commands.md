# Dependency Installation Commands

The following commands install the software required to build and run Cosmic on a Debian/Ubuntu based system:

```bash
# Update package lists
sudo apt-get update
# Install apt-utils
sudo apt-get install -y apt-utils

# Install apt-utils for noninteractive package management
sudo apt-get install -y apt-utils

# Install Java 21
sudo apt-get install -y openjdk-21-jdk

# Install MySQL server and client
sudo apt-get install -y mysql-server mysql-client

# Optional: secure the MySQL installation
sudo mysql_secure_installation

# Install Maven (the Maven wrapper is included, but having Maven installed can be convenient)
sudo apt-get install -y maven

# Install Docker and Docker Compose for container based workflows
sudo apt-get install -y docker.io docker-compose
```

After installing these packages you can build the jar and prepare the database:

```bash
# Build the server jar with all dependencies
./build.sh

# Run the SQL scripts (you will be prompted for the root password)
# Alternatively, use scripts/setup_db.sh <password>
mysql -u root -p < database/sql/1-db_database.sql
mysql -u root -p < database/sql/2-db_drops.sql
mysql -u root -p < database/sql/3-db_shopupdate.sql
mysql -u root -p < database/sql/4-db-admin.sql
```

If you plan to run with Docker, build and start using docker compose:

```bash
docker compose up --build
```

