## Install

* Install `rvm` http://rvm.io/
* If prompted, install the version of Ruby required for this project
* Install bundler `$ gem install bundler`
* Install project gems locally (`$ bundler install`)
* Install Postgres (`$ brew install postgres`)
* Create development database (`$ createdb preston-cup`)
* Seed development database with some data (`$ ruby db/seeds.rb`)

## Run

```bash
$ ruby app.rb
```