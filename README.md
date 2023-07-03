# README

## API usage
### Get a fibonacci number of the query `n`
#### Request
Requires just the parameter `n`  which is `int` number & `n ≥ 0`
```
GET https://sample-api-app.onrender.com/fb?n

ex)
$ curl -X GET -H "application/json" "https://sample-api-app.onrender.com/fb?n=10"
```

#### Response
Results will be displayed in `JSON` string.  
**Please wait 0.5~1 minutes because this proj uses 'Render.com' and joins in free plan. sry;;**
```
ex)

// status: 200
{
  "result": 55
}

// status: 400
{
  "status": 400,
  "errors": [
    { "type": "invalid-parameter", "title": "パラメータの値が不正です" }
  ]
}
```

## Project detail
Source Tree: [detail is here](./docs/document.md)

```
$ tree -a -A -C -U -I .git -L 2
# （shortened）
.
├── .rspec
├── app
│   ├── controllers
│   │   ├── easy_api_controller.rb
│   │   ├── fb_controller.rb
│   │   └── ...
│   ├── services
│   │   └── fibonacci_calculator_service.rb
│   └── ...
├── test
│   ├── controllers
│   │   ├── fb_controller_test.rb
│   │   ├── easy_api_controller_test.rb
│   │   └── .keep
│   └── ...
├── config
│   ├── routes.rb
│   └── ...
├── spec
│   ├── spec_helper.rb
│   ├── requests
│   │   └── fbs_spec.rb
│   └── rails_helper.rb
├── docs
│   ├── image/
│   └── 001_setup.md
│   ├── 002_make-project.md
│   ├── 003_first-deploy.md
│   ├── 004_main-architecture.md
│   ├── 005_test.md
│   └── questions.md
├── README.md
├── Rakefile
├── Gemfile
├── Gemfile.lock
├── .ruby-version
├── .gitignore
├── .gitattributes
└── ...
```

<!-- 
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->
