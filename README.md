IMPORTANT
===================================
Before installing this you need to purchase this theme http://demo.interface.club/?theme=brain
I have built the admin interface based on this. The theme is not open source so I cannot make it public.
I am trying to rebuild it on a free theme that everybody can use but for now you need to purchase that theme. Sorry :(


Yii 2 Advanced Application Template
===================================

Yii 2 Advanced Application Template is a skeleton Yii 2 application best for
developing complex Web applications with multiple tiers.

The template includes three tiers: front end, back end, and console, each of which
is a separate Yii application.

The template is designed to work in a team development environment. It supports
deploying the application in different environments.


DIRECTORY STRUCTURE
-------------------

```
common
    config/              contains shared configurations
    mail/                contains view files for e-mails
    models/              contains model classes used in both backend and frontend
console
    config/              contains console configurations
    controllers/         contains console controllers (commands)
    migrations/          contains database migrations
    models/              contains console-specific model classes
    runtime/             contains files generated during runtime
backend
    assets/              contains application assets such as JavaScript and CSS
    config/              contains backend configurations
    controllers/         contains Web controller classes
    models/              contains backend-specific model classes
    runtime/             contains files generated during runtime
    views/               contains view files for the Web application
    web/                 contains the entry script and Web resources
frontend
    assets/              contains application assets such as JavaScript and CSS
    config/              contains frontend configurations
    controllers/         contains Web controller classes
    models/              contains frontend-specific model classes
    runtime/             contains files generated during runtime
    views/               contains view files for the Web application
    web/                 contains the entry script and Web resources
    widgets/             contains frontend widgets
vendor/                  contains dependent 3rd-party packages
environments/            contains environment-based overrides
tests                    contains various tests for the advanced application
    codeception/         contains tests developed with Codeception PHP Testing Framework
```


REQUIREMENTS
------------

The minimum requirement by this application template that your Web server supports PHP 5.4.0.


INSTALLATION
------------

### Install via Composer

If you do not have [Composer](http://getcomposer.org/), you may install it by following the instructions
at [getcomposer.org](http://getcomposer.org/doc/00-intro.md#installation-nix).

You can then install the application using the following command:

~~~
php composer.phar global require "fxp/composer-asset-plugin:1.0.0-beta4"
php composer.phar create-project --prefer-dist --stability=dev tez/yii2-app-advanced advanced
~~~


GETTING STARTED
---------------

After you install the application, you have to conduct the following steps to initialize
the installed application. You only need to do these once for all.

1. Run command `init` to initialize the application with a specific environment.
2. Create a new database and adjust the `components['db']` configuration in `common/config/main-local.php` accordingly.
3. Apply migrations with console command `sh migrate.sh`. This will create tables needed for the application to work.
4. Set document roots of your Web server:
  - for frontend `/path/to/yii-application/frontend/web/` and using the URL `http://frontend/`
  - for backend `/path/to/yii-application/backend/web/` and using the URL `http://backend/`
5. Open backend/config/params-local.php and change the `frontend-url` to your local domain name
6. Open backend/config/params.php and change the `frontend-url` to your live site's domain name
7. Open common/config/params.php and add your mandrill details in the `mandrill` section. Change the `logo` a full URL with your applications logo
8. After purchasing the Brain theme, unpack it and copy the folder HTML/Bootstrap/Liquid into the vendor/tez/yii2-brain-theme/assets/Brain/Liquid
9. TO DO - Create a cronjob to send email notifications out

#### TO DO

Find a way so you do not have to hardcode URLs

## URLs

* Login: `yourhost/core/default/login`
Username: webmaster@2ezweb.com.au
Password: admin
* Logout: `yourhost/core/default/logout`
* Reset Password: `yourhost/core/default/request-password-reset`
* User management: `yourhost/core/administrator/`

## Tests
Go to vendor/tez/yii2-cms-module/tests/codeception/backend/
run

```codecept build```

to initialize the tests. Then run

```codecept run```

to run the actual tests.

You can run

```codecept run --coverage-html```

to get the code coverage. You can find the coverage in vendor/tez/yii2-cms-module/tests/codeception/backend/_output/coverage/

#### TO DO
1. Make the tests all run from inside the application/test folder, not from inside the vendor folder
2. Make acceptance testing also work
2. Put instructions on how to install codeception