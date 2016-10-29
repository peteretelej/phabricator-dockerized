set +e # allow errors, don't exit
echo "Launching mysql, phabricator, nginx"

docker stop mysql || true 
docker rm mysql || true
docker run -d --name mysql  --restart always \
-v "$PWD"/mysql/mysqldatavolume:/var/lib/mysql \
-v /etc/localtime:/etc/localtime:ro \
-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
etelej/phab-mysql:5.7
echo "Initialiazing mysql" && sleep 10

docker stop phabricator || true 
docker rm phabricator || true 
docker run -d -p "127.0.0.1:22:22" -p "22280:22280" \
--name=phabricator --link mysql:mysql.code.etelej.com \
-v /etc/localtime:/etc/localtime:ro \
-v "$PWD"/phabricator/reposvar:/var/repo \
-v "$PWD"/phabricator/reposvolume:/srv/repo \
-v "$PWD"/phabricator/config:/config \
etelej/phabricator:201603 
echo "Initiliazing phabricator" && sleep 3
docker exec phabricator ./srv/phabricator/phabricator/bin/phd start || true
sleep 5

docker stop nginxmain || true 
docker rm nginxmain || true 
docker run -d --name nginxmain -p "80:80" -p "443:443" \
-link phabricator \
--v /etc/ssl:/etc/ssl:ro \
-v /etc/localtime:/etc/localtime:ro \
-v "$PWD"/nginx/conf.d:/etc/nginx/conf.d:ro \
-v "$PWD"/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v "$PWD"/nginx/html:/usr/share/nginx/html:ro \
nginx:1.9.9
echo "Initializing nginx" && sleep 1
