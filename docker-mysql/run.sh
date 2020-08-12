docker run -d \
--name mysql-demo \
-e MYSQL_ROOT_PASSWORD=123 \
-v $PWD/mysqlsampledatabase.sql:/usr/mysql/mysqlsampledatabase.sql \
mysql:5.5.62;
sleep 10;
CONTAINER=`docker container ls -q --filter "name=mysql-demo"`;
docker container exec -it $CONTAINER bash \
-c 'mysql -u root --password=123 -e "source /usr/mysql/mysqlsampledatabase.sql"';
docker container exec -it $CONTAINER bash;