# docker-compose-osc2016-tokyo-spring

[![License](https://img.shields.io/github/license/rworksjp/docker-compose-osc2016-tokyo-spring.svg)](https://tldrlegal.com/license/gnu-general-public-license-v2)

docker-compose definition to demonstrate the web monitoring with PandoraFMS including Selenium WebDriver
at Open Source Conference 2016 Tokyo Spring.

## Requirements

- docker-compose >= 1.6.0
- docker >= 1.9.1

Using Docker Compose file format version 2

## Usage

```console
$ git clone https://github.com/rworksjp/docker-compose-osc2016-tokyo-spring
$ cd docker-compose-osc2016-tokyo-spring
$ cp dot.env .env
$ # edit .env
$ docker-compose pull # or docker-compose build
$ docker-compose up -d mysql
$ # should wait until mysql connection is ready
$ docker-compose up -d pandora_console
$ docker-compose up -d chromedriver
$ docker-compose up -d pandora_server
$ docker-compose up -d pandora_agent
```

```console
$ docker-compose ps
                      Name                                     Command               State            Ports
---------------------------------------------------------------------------------------------------------------------
dockercomposeosc2016tokyospring_chromedriver_1      /bin/bash /entrypoint.sh / ...   Up      0.0.0.0:5900->5900/tcp
dockercomposeosc2016tokyospring_mysql_1             /entrypoint.sh mysqld            Up      0.0.0.0:3306->3306/tcp
dockercomposeosc2016tokyospring_pandora_agent_1     /bin/bash /entrypoint.sh / ...   Up      0.0.0.0:3000->3000/tcp
dockercomposeosc2016tokyospring_pandora_console_1   /bin/bash /entrypoint.sh / ...   Up      0.0.0.0:80->80/tcp
dockercomposeosc2016tokyospring_pandora_server_1    /bin/bash /entrypoint.sh / ...   Up      0.0.0.0:41121->41121/tcp
```

## Docker Images

- [rworksjp/chromedriver-osc-2016-tokyo-spring](https://hub.docker.com/r/rworksjp/chromedriver-osc-2016-tokyo-spring/)
  [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/rworksjp/chromedriver-osc-2016-tokyo-spring/latest.svg)](https://imagelayers.io/?images=rworksjp%2Fchromedriver-osc-2016-tokyo-spring:latest)
- [rworksjp/mysql-osc-2016-tokyo-spring](https://hub.docker.com/r/rworksjp/mysql-osc-2016-tokyo-spring/)
  [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/rworksjp/mysql-osc-2016-tokyo-spring/latest.svg)](https://imagelayers.io/?images=rworksjp%2Fmysql-osc-2016-tokyo-spring:latest)
- [rworksjp/pandora_agent-osc-2016-tokyo-spring](https://hub.docker.com/r/rworksjp/pandora_agent-osc-2016-tokyo-spring/)
  [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/rworksjp/pandora_agent-osc-2016-tokyo-spring/latest.svg)](https://imagelayers.io/?images=rworksjp%2Fpandora_agent-osc-2016-tokyo-spring:latest)
- [rworksjp/pandora_console-osc-2016-tokyo-spring](https://hub.docker.com/r/rworksjp/pandora_console-osc-2016-tokyo-spring/)
  [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/rworksjp/pandora_console-osc-2016-tokyo-spring/latest.svg)](https://imagelayers.io/?images=rworksjp%2Fpandora_console-osc-2016-tokyo-spring:latest)
- [rworksjp/pandora_server-osc-2016-tokyo-spring](https://hub.docker.com/r/rworksjp/pandora_server-osc-2016-tokyo-spring/)
  [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/rworksjp/pandora_server-osc-2016-tokyo-spring/latest.svg)](https://imagelayers.io/?images=rworksjp%2Fpandora_server-osc-2016-tokyo-spring:latest)

## Demonstration

`pandora_console` is available on `http://${DOCKER_HOST}:80/pandora_console` with user: `admin` and password: `pandora`.

`pandora_agent` docker image includes simple single page webapp
by [React](https://facebook.github.io/react/) and [Express](http://expressjs.com/).
It is just a toy application, but a good example to show the power of web monitoring
with Selenium WebDriver, you could check webapp on `http://${DOCKER_HOST}:3000/`.

`vnc://${DOCKER_HOST}:5900` is available to check how `chromedriver` image behave.

![scenario monitoring demonstration](./scenario-monitoring.gif "scenario monitoring demonstration")

## License

Contents in this repository basically licensed under the [GPLv2](./LICENSE) and 
some JavaScript libraries in [pandora_agent/webapp/public/scripts](pandora_agent/webapp/public/scripts) are separately licensed:

- [react/react-dom](https://github.com/facebook/react) is licensed under the [BSD 3-Clause License](https://github.com/facebook/react/blob/master/LICENSE)
- [babel](https://github.com/babel/babel/blob/master/LICENSE) is licensed under the [MIT License](https://github.com/babel/babel/blob/master/LICENSE)
- [superagent](https://github.com/visionmedia/superagent) is licensed under the [MIT License](https://github.com/visionmedia/superagent/blob/master/LICENSE)

License for distributed Docker images follows one of the base Linux distribution and installed packages.

