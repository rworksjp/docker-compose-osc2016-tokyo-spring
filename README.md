# docker-compose-osc2016-tokyo-spring

docker-compose definition for PandoraFMS,
especially for a demo on Open Source Conference 2016 Tokyo Spring.

## Requirements

- docker-compose >= 1.6.0
- docker >= 1.9.1

Using Docker Compose file format version 2

## Usage

```console
$ git clone https://github.com/rworksjp/docker-compose-osc2016-tokyo-spring
$ cd docker-compose-osc2016-tokyo-spring
$ cp dot.env .env
$ edit .env
$ docker-compose pull
$ docker-compose up -d mysql
$ docker-compose up -d pandora_console # should wait until mysql connection is ready
$ docker-compose up -d pandora_server
$ docker-compose up -d pandora_agent
```

```console
$ docker-compose ps
                      Name                                     Command               State            Ports
---------------------------------------------------------------------------------------------------------------------
dockercomposeosc2016tokyospring_chromedriver_1      /entrypoint.sh /usr/bin/su ...   Up      0.0.0.0:5900->5900/tcp
dockercomposeosc2016tokyospring_mysql_1             /entrypoint.sh mysqld            Up      0.0.0.0:3306->3306/tcp
dockercomposeosc2016tokyospring_pandora_agent_1     /entrypoint.sh /usr/bin/su ...   Up      0.0.0.0:3000->3000/tcp
dockercomposeosc2016tokyospring_pandora_console_1   /entrypoint.sh /usr/sbin/h ...   Up      0.0.0.0:80->80/tcp
dockercomposeosc2016tokyospring_pandora_server_1    /entrypoint.sh /usr/bin/su ...   Up      0.0.0.0:41121->41121/tcp
```
