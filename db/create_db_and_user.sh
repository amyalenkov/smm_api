docker exec -it psql psql -U postgres -c "CREATE DATABASE user1001;"
docker exec -it psql psql -U postgres -c \
 "CREATE USER user1001 SUPERUSER PASSWORD '98giu2b3eqd98gub98gub3q'; \
  GRANT ALL PRIVILEGES ON DATABASE user1001 TO user1001;"