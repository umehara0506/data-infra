```
docker compose down --rmi all
docker compose up -d
docker exec -it digdag /bin/bash



docker-compose build
docker-compose up -d
```

```
docker exec -it postgres psql -U postgres

CREATE ROLE digdag_user WITH PASSWORD 'postgres' LOGIN;
CREATE DATABASE digdag_db WITH OWNER digdag_user;
GRANT ALL PRIVILEGES ON DATABASE digdag_db TO digdag_user;

```

# Digdagのプラグイン
[digdag-slack](https://github.com/szyn/digdag-slack)

# Embulkのプラグイン
- [embulk-input-google_spreadsheets](https://github.com/medjed/embulk-input-google_spreadsheets)
- [embulk-output-bigquery](https://github.com/embulk/embulk-output-bigquery)
- [embulk-input-bigquery](https://github.com/medjed/embulk-input-bigquery)
- [embulk-filter-column](https://github.com/embulk/embulk-filter-column)
- [embulk-filter-add_time](https://github.com/treasure-data/embulk-filter-add_time)
- [embulk-output-google_spreadsheets](https://github.com/kataring/embulk-output-google_spreadsheets)

