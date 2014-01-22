webrockit-checksync
==========

The webrockit-checksync application allows you to sync data from webrockit to sensu-server.

**Install**

1. `cd /opt`
2. git clone this repo
3. `sh ext/install.sh`

**Building:**

1. Install jruby
2. Run "`bundle install`" from within this repo. You may have to install bundler ("`gem install bundler`")
3. Build running `jruby -S warble`

**Running:**

1. Copy "config/config.yml.example" to "config/config.yml" and edit settings.
2. Config is also fetched out of "/opt/webrockit-checksync/config/config.yml"
`java -jar webrockit-checksync.jar config/web.ru -p 8083`


**Use:**

API provides simple methods to import checks from webrockit. Future improvements will do more of a sync, rather than removing/adding everything.

##### Import checks by type
`GET http://127.0.0.1:8083/v1/importByType?type=sometype`

##### Import all checks
`GET http://127.0.0.1:8083/v1/importAll`

##### Restart Sensu services
`GET http://127.0.0.1:8083/v1/loadChecks`


### License
   webrockit-checksync is released under the MIT license, and bundles other liberally licensed OSS components [License](LICENSE.txt)  
   [Third Party Software](third-party.txt)