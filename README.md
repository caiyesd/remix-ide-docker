# remix-ide docker

## How to build

```
$ cd /path/to/remix-ide-docker/
$ docker build -t caiyesd/remix-ide .
```

## How to use

```
$ docker run -it --rm  -p 8080:8080 -p 65520:65520 -v `pwd`:/app caiyesd/remix-ide
``` 
