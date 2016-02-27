# Carina CLI Docker Image

This is a *Dockerization* of the [Carina CLI](https://github.com/getcarina/carina), which is used to
manage your [Rackspace Carina clusters](https://getcarina.com/) from the command-line.

## Access Credentials

The are several ways to pass your Carina credentials to your container:

* You can pass the `CARINA_USERNAME` and `CARINA_APIKEY` environment variables with the `-e` arguments of `docker run`
* You can pass `--username` and `--api-key` after the image argument

...but, the more secure and convenient way is to attach a `/secrets` file into the container.

Create a file in your host filesystem that contains `export VAR=VALUE` lines, such as this `secrets` file
in the current directory:

```
export CARINA_USERNAME=me@there
export CARINA_APIKEY=...api key goes here...
```

Run the CLI container and attach that file to `/secrets` in the container:

```
docker run --rm -v $(pwd)/secrets:/secrets itzg/carina-cli ls
```

## Obtaining Credentials Output

As a convenience, this image exposes a `/carina` volume and sets `$CARINA_HOME` to that path. 
You can either attach that volume to a host directory or use `--volumes-from` in a downstream container, such as

```
docker run --name carina-credentials -v $(pwd)/secrets:/secrets itzg/carina-cli credentials my-cluster

docker run --volumes-from carina-credentials ...
```

Notice that I did *not* include the `--rm` flag on the upstream container, so that the container remains present
for downstream attachment.

From the downstream container, your cluster credentials (the Docker client certificates) are available at the
path

    /carina/clusters/<carina username>/<cluster name>

## General Usage of the CLI

For general use of the CLI, please refer to the [Carina client documentation](https://github.com/getcarina/carina/blob/master/README.md)