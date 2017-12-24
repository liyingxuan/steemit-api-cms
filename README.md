## Steem-CMS-API

> 高仿Steemit，使用Laravel + Vue重写。  
这是CMS和API部分。


#### 1. Language and framework
PHP >=7.0.0  
Laravel v5.5.*  
[laravel-admin v1.5.x-dev](http://laravel-admin.org/)  
Bootstrap v3.3.7  

#### 2. Install and run
[Deploy the server environment](http://www.jianshu.com/p/1f17a69f6dcf)

Reboot server.

Go in project path :
```bash
$ cd [project path]

$ composer install
$ npm install

$ cp .env.example .env
$ php artisna key:generate 
# 将生成的key保存到.env中

$ php artisan passport:install
# 将生成的两个CLIENT_Secret保存到.env中
```

After the database can be connected properly, import the database structure and data.  
确保数据库能连接正常之后，导入数据库结构和数据：

./database/sql/steemit.sql  
