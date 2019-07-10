
#Note you need to install heroku cli before doing any of these

#login to heroku
heroku login

#create new application in heroku for your project
heroku create <myappname>

#create Procfile in project root for heroku (Laravel php)
echo "web: vendor/bin/heroku-php-apache2 public/" > Procfile

#create Procfile in project root for heroku(Adonisjs Nodejs)
echo "web: ENV_SILENT=true npm start" > Procfile

#create key/value configuration for your app on heroku
heroku config:set VAR_NAME=VAR_VALUE


git remote add heroku [your_app_git_url]

#push to heroku master(i.e live app)
git push heroku master

#if have more than 1 app on heroku
#use the --app flag with appname 
git push heroku master --app <myappname> 

#set your APP_LOG to errorlog to view log at heroku
heroku config:set APP_LOG=errorlog

#view log at heroku
heroku logs

#view configuration at heroku
heroku config

#run specific command on heroku
heroku run php artisan migrate

#enter heroku bash mode to run any command
heroku run bash 

#while running command indicate the --app flag if have more than one app on heroku
php artisan migrate --app <myappname> #(in bash mode --force)