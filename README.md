# docker dev

```console
# Build the docker
$ docker build -t linux-dev .

# Source the invoke function (for now)
$ source invoke.sh

# Install the invoke function (for later)
$ cat invoke.sh >> ~/.bashrc

# Browse to the appropriate folder
$ cd path/to/working/directory

# Invoke the linux container
$ linux-dev
user@c8d121b8df93:~/work/ $

```

`linux-dev` is a bash function which drops into the docker container and maps the current working directory into `/home/user/work`.


