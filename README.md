# remix-ide docker

## How to build

```
$ git clone https://github.com/caiyesd/remix-ide-docker
$ docker build -t caiyesd/remix-ide remix-ide-docker
```

## How to use

On server side, start remix-ide service in background

```
# Server
$ docker run -dit --rm  -p 8080:8080 -p 65520:65520 -v `pwd`:/app caiyesd/remix-ide
```

On client side, map local 8080 port and 65520 port to server, and visit `http://localhost:8080`

```
# Client
$ export REMIX_SERVER=192.168.50.25
$ ssh ${REMIX_SERVER} -gN -L 8080:${REMIX_SERVER}:8080 -L 65520:${REMIX_SERVER}:65520
```

Then open browser on client, and visit `http://localhost:8080`
