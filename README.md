# sinatra_memo_app
 Sinatra_memo_app is an application that helps you manage your schedule.

 # DEMO
<img width="882" alt="My_Memo" src="https://user-images.githubusercontent.com/72614612/131195870-02427f11-b6a7-454c-a13f-4af45b74ffba.png">
<img width="984" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131196086-f0151b10-f10b-490c-acb4-7efcfcdbe1b3.png">
<img width="964" alt="8月30日の晩ごはん" src="https://user-images.githubusercontent.com/72614612/131196106-57f6ea9c-2eed-44bd-b04f-a409d6d0776c.png">

# Requirement

* Ruby 3.0.0
* puma 5.4.0
* sinatra 2.2.0
* PostgreSQL 13.3

# Installation
## PostgreSQL

```
$ brew install postgresql
$ pg_ctl -D /usr/local/var/postgres start
```
## bundler
```bash
$ gem install bundler
```

## clone&execution(for reviewer)
```bash
$ git clone https://github.com/keiz1213/sinatra_memo_app.git
$ cd sinatra_memo_app
$ git fetch origin pull/2/head:database
$ git checkout database
$ bundle install --path vendor/bundle
$ bundle exec ruby app.rb
```

## browser
Please enter in the address bar of your browser.

<img width="382" alt="My_Memo" src="https://user-images.githubusercontent.com/72614612/131242857-67671695-14a5-485d-a089-642a39f3d34b.png">

# Usage

## Create new memo

<img width="910" alt="My_Memo" src="https://user-images.githubusercontent.com/72614612/131237909-a02b6558-ddeb-4394-9818-be13e76eba4d.png">


<img width="910" alt="New_Memo" src="https://user-images.githubusercontent.com/72614612/131237968-9beac213-9434-484e-b257-f8a9212cf7bf.png">

## Detail

<img width="910" alt="My_Memo" src="https://user-images.githubusercontent.com/72614612/131237997-0310cde0-64cc-4371-8129-0efaca150ba5.png">

<img width="910" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131237165-6974ffe9-16e3-48d3-97f5-839231a89540.png">

## Edit memo

<img width="910" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131238038-b39bcb09-95c3-483b-9f55-a72484c13b60.png">


<img width="910" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131238050-93f9654d-d0b3-44a4-85f3-e77047a1d5ba.png">


<img width="910" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131237320-4e75b690-6f81-4ea9-a46c-11a4302ec800.png">

## Delete memo

<img width="910" alt="美容室予約" src="https://user-images.githubusercontent.com/72614612/131238063-608e1068-e5ab-44cd-a732-e92b745467af.png">

# Note
This application is the task of fjordbootcamp.
