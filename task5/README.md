# Homework for task 5

Ansible playbook task5/site.yml used to:

1) Install docker engine and docker-compose.
2) Deploy container based on mysql/mysql-server:8.0.23 image, using db_data persistent volume as storage.
3) Database aws filled with:
 - docker exec -it task5_mysql1_1 sh -c 'mysql -u intern -p internship < docker-entrypoint-initdb.d/init.sql'
 - docker exec -it task5_mysql1_1 sh -c 'LANG=en_US.UTF-8 mysql -u intern -p internship < docker-entrypoint-initdb.d/fill.sql'
