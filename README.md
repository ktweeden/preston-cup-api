## Install

* Install Postgres (`$ brew install postgres && brew services start postgresql`)
* Install `rvm` http://rvm.io/
* Install bundler `$ gem install bundler`
* Install pry `$ gem install pry`

* `$ git clone ...`
* `$ cd preston-cup`
* If prompted, install the version of Ruby required for this project
* Install project gems (`$ bundler install`)
* Create development database (`$ createdb preston-cup`)
* Set up tables (`$ psql -d preston-cup -f db/TABLES.sql`)
* Seed development database with some data (`$ ruby db/seeds.rb`)

## Run

```bash
$ ruby app.rb
```