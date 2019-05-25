
heroku login

heroku create <myappname>

echo "web: vendor/bin/heroku-php-apache2 public/" > Procfile

heroku config:set VAR_NAME=VAR_VALUE

git remote add heroku [your_app_git_url]

git push heroku master

git push heroku master --app <myappname> (if have more than 1 app on heroku)

heroku config:set APP_LOG=errorlog

heroku logs

heroku config

heroku run php artisan migrate

heroku run bash (for bash mode)

php artisan migrate --app <myappname> (in bash mode --force)