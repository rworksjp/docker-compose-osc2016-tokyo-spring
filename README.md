# docker-compose-pandorafms

docker-compose definition for PandoraFMS,
especially for demo on Open Source Conference 2016 Tokyo Spring.

## Requirements

- docker-compose >= 1.6.0
- docker >= 1.9.1

## Usage

```console
$ cp dot.env .env
$ edit .env
```

```console
$ docker-compose pull
$ docker-compose up -d mysql
$ docker-compose up -d pandora_console
$ docker-compose up -d pandora_server
$ docker-compose up -d pandora_agent
```
