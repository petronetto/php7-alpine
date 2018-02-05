# PHP7 Alpine
PHP7 with almost everything that you may need.

[![](https://images.microbadger.com/badges/image/petronetto/php7-alpine:latest.svg)](https://microbadger.com/images/petronetto/php7-alpine:latest "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/petronetto/php7-alpine:latest.svg)](https://microbadger.com/images/petronetto/php-nginx-alpine:stable "Get your own version badge on microbadger.com")
[![CircleCI](https://circleci.com/gh/petronetto/php7-alpine/tree/master.svg?style=svg)](https://circleci.com/gh/petronetto/php7-alpine/tree/master)


# Running
Run `docker-composer -up` and access `http://localhost:8080` (NGINX) or `http://localhost:8000` (Caddy).

> NOTE: The container will run with user `www-data`, that is a non-root user, if you need access the container as root run `docker exec -u 0 -it php-fpm sh`.

# New Relic
To enable *New Relic* Agent, you must pass set the env `NEWRELIC_ENABLED` and `NEWRELIC_LICENSE`. Other params is also available, check the [Dockerfile](https://github.com/petronetto/php7-alpine/blob/master/php-fpm/Dockerfile) for more details.  


# Remote debug

The container is configured to run the file that bootstrap applications in folder `/app/public`, because I use Laravel/Lumen by default, so, if you don't use a framework that bootstrap the application in this folder, you must put your source files there.
To the debug works, you must:

1) Set your local IP address in `XDEBUG_HOST` environment variable in `docker-compose.yml`.

2) Configure your editor/IDE to map the local source and the remote source.

## IDE/Editor configuration

You need configure your editor/IDE to map the local source and where is the remote source.

### VS Code
Install [PHP Debug Extension](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug).

Put this config in your `launch.json`:

>**NOTE** this example will map the local folder app, to `/app` on the container. Remenber that container is configured to boostrap in `/app/public`, as the example provided in this repo

```json
//launch.json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": {
                "/app": "${workspaceRoot}"
            },
            "ignore": ["**/vendor/**/*.php"]
        }
    ]
}
```


## Sublime Text

Install [XDebug Client](https://github.com/martomo/SublimeTextXdebug)

Create a sublime-project in `Project > Save Project As...`

Paste the config as bellow in created file, and ensure that `path_mapping` is mapping the **full** path to your source, eg: `C:\my\source`, `/Users/user/my/source`, `/home/user/source`, etc...:

```json
{
  "folders": [
    {
      "follow_symlinks": true,
      "path": "."
    }
  ],
  "settings": {
    "xdebug": {
      "url": "http://localhost:8080",
      "path_mapping": {
        "/app" : "/full/path/to/your/source"
      }
    }
  }
}
```


## Atom

Intall [this extension](https://github.com/gwomacks/php-debug), go to `Settings > Open Config Folder` and put in your `config.cson`:

```
"php-debug":
    PathMaps: [
      "remotepath;localpath"
      "/app;/path/to/your/local/source"
    ]
```


## PHPStorn
Configuration is in two parts:

Configuring a Server: `Preferences > Languages & Frameworks > PHP > Servers`

![](http://imagizer.imageshack.us/v2/1024x768q90/924/1ftWIS.png)



Configuring a new PHP Remote Debugger: `Run > Edit Configurations` click in `+` and `PHP Remote Debugger`
![](http://imagizer.imageshack.us/v2/1024x768q90/922/bnd7fq.png)



# License [BSD 3-Clause](https://github.com/petronetto/php7-alpine/blob/master/LICENSE)

```
BSD 3-Clause License

Copyright (c) 2017, Juliano Petronetto
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
