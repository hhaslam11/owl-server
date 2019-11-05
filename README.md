# README

Meant to be run with client: https://github.com/hhaslam11/owl-client

* Ruby version

  ruby 2.3.5p376

* System dependencies

  'rails', '~> 5.1.7'

  'pg', '>= 0.18', '< 2.0'

  'bcrypt', '~> 3.1.7'

* Configuration

  To install gems:

  ```bundle install```
  
  Create a .env file
  
  - example in .env.example
  
  (Sign up for https://ipinfo.io/developers and place your token key in)

  To run the server:
  
  ```rails s -b 0.0.0.0```

* Database creation

  To create the database:
  
  ```rails db:setup```

* Database initialization

  ```rake db:migrate```

  To rollback all migrations

  ```rake db:rollback STEP=10000000```

  To add reset and reseed

  ```rake db:reset```

  To seed

  ```db:seed```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
