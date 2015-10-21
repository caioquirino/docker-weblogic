Weblogic 12c - 12.1.3 docker container

# How to use this image

## Start a `Weblogic` server instance
Starting a Weblogic server instance is simple:
```bash
docker run --name my-weblogic -e WEBLOGIC_PASSWD=weblogic123 -d caioquirino/weblogic:latest
```

## Where to Store Data

Create a data directory on the host system (outside the container) and [mount this to a directory visible from inside the container](https://docs.docker.com/userguide/dockervolumes/#mount-a-host-directory-as-a-data-volume).

1.	Create a data directory on a suitable volume on your host system, e.g. `/my/own/datadir`.
2.	Start your `weblogic` container like this:

  ```bash
	$ docker run --name my-weblogic -v /my/own/domain_dir:/weblogic/domains -e WEBLOGIC_PASSWD=weblogic123 -d caioquirino/weblogic:latest
	```


## Environment Variables

When you start the weblogic image, you can adjust the configuration of the Weblogic instance by passing one or more environment variables on the docker run command line. Do note that only the `DOMAIN_DIR` and the `DOMAIN_NAME` variables will have effect if you start the container with a domain directory that already contains a domain: any pre-existing domain will always be left untouched on container startup.


### `DOMAIN_DIR`

This variable is optional and specifies where the domains are stored.

Default: /weblogic/domains


### `DOMAIN_NAME`

This variable is optional and specifies what domain are used. If the domain does not exist, it will be created on image startup.

Default: mydomain


### `WEBLOGIC_PASSWD`

This variable is optional and specifies the password of `weblogic` user in console, used ONLY when a new domain is created.

Default: weblogic123


### `SERVER_START_MODE`

This variable is optional and specifies the server start mode, used ONLY when a new domain is created.

Default: dev


## Initializing a fresh instance

When a container is started for the first time, a new domain will be initialized with the provided configuration variables.
