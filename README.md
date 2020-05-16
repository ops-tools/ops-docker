# ops-docker

> Configurable docker deployment tool in pure bash

ops-docker – is a single bash script that can perform standard deploy tasks in a simple and performant way using tools you already have in your systems for decades or so.

### Why?

There are some cases when you want to get benefits of using Docker for running your project, but don't want to setup Kubernetes or Swarm cluster and fancy tools like Ansible, Puppet or Chef just for organizing deployment process.

The reasons are:

  - You don't have resources for running management nodes
  - You don't want to get orchestrators overhead in your system
  - You want to control the whole environment down to plain docker commands
  - You don't like to rely on complex tools in production and good to go with bash
  - You don't have experience with all that DevOps stuff and need something that just works
  - Your project is just too small to imagine it requires Google's infrastructure to run
  - You tell me why

The philosophy behind ops-docker is to be an alternative to all the complex tools and staying sanely small, easy to use and configurable so it could be used in small to medium-sized projects without rising operational costs.

Configuration files of ops-docker that is also plain bash sources allow you to partly solve "Infrastructure as Code" task by storing all information needed for project deployment, including deployment tools itself, in the same repository.

## Installation

Installation as such is not required for using ops-docker, but if you wish you can follow the [installation doc](doc/installation.md) for detailed guide.

Runtime dependencies ops-docker relying on: `bash`, `sed`, `tar`, `ssh`, `openssl`, `rsync` and `docker`.

You likely have all of these programs already installed when using modern Linux OS, if no just use a package manager to install them. See [dependencies](doc/installation.md#dependencies) section of the installation guide for more help.

## Usage

Running `ops-docker` without parameters or with `--help` switch will show you a short usage message.

```
$ ops-docker
Configurable docker deployment tool in pure bash

Usage: ops-docker [options] <commands>

Commands:
  assemble   Assemble image locally
  transport  Transport image to remotes
  prepare    Prepare containers for launch
  launch     Start or restart ready containers
  deploy     Shortcut for: prepare launch
  rollout    Shortcut for: assemble transport -l; prepare launch
  rollback   Stop current and start previous containers

Options:
  -c, --config  Configuration file
  -l, --local   Force local deployment
  -h, --help    Print help and exit
```

### Commands

ops-docker commands are basically higher-level abstractions for plain docker commands combined with some standard unix programs like ssh in purpose to simplify the deployment process for a developer or ops engineer. Commands can be combined into chains to perform complex actions and there is also some shortcuts for common operations, like rolling out the app or rolling it back to the previous state.

For example.

`ops-docker -c conf/docker.cfg -l assemble deploy` – will assemble the image on the local machine and deploy it on the same machine.

`ops-docker -c conf/docker.cfg rollout` – will assemble the image and transfer it from the local machine to remotes, then run containers from this image.

`ops-docker -c conf/docker.cfg -l assemble transport` – will assemble and transport the new image to remotes, but not start it now.

#### assemble

Assembles docker image.

#### transport

Transports assembled image to remotes using rsync.

#### prepare

Prepares environment such as networks needed to run and create containers from the image.

#### launch

Stops currently running and start created at `prepare` step containers one by one.

#### deploy

Shortcut for `prepare` and `launch` commands to simplify deploy operation.

#### rollout

Shortcut for `assemble` and `transport` ran at local, then `prepare` and `launch` ran at remotes. This is the command for rolling out from scratch.

#### rollback

Stops currently running containers and starts previously exited, one by one.

### Options

Options can be placed before or after commands list as you prefer. The position of options doesn't make any special meaning, so for example `-l` switch would be applied to all commands you pass.

#### -c, --config

Path to configuration file.

#### -l, --local

Switch for forcing local running of commands (default is remote). For simple deploy schemes like *build machine* -> *production machine* you wants `-l` for `assemble` and `transport` commands, but not for `prepare` and `launch`.

#### -h, --help

Standard option tells that you want to see usage note and immediately exit.

### Configuration file

A configuration file is a plain bash source include. Variables can be split to *Base settings*, *Docker control settings* and *Hooks* functions.

Look at the basic example of config for a web server like [nginx](https://hub.docker.com/_/nginx).

```sh
basename="web-server"
networks=("bridge")
remotes=("deploy@production:/home/deploy")
create_options=(
  "-p 80:80"
  "-v web-server-data:/var/www"
)
```

#### Base settings

##### basename

```sh
basename="project"
```
Base name that would be used for generating containers names and network aliases. The pattern is `${basename}-${i}` where *${i}* is the number of instance, for example: `project-1`.

##### networks

```sh
networks=("bridge")
```
Array or string of networks that would be used to run containers.

##### images

```sh
images=("project")
```
Array or string declaring image tags, the first value would be used to refer working containers, others are just additional tags if you need them. If no value were assigned, `${basename}` would be used for image name.

##### instances

```sh
instances=1
```
The number of containers you want to run.

##### remotes

```sh
remotes=("user@host:[port]/home/user/project")
```
List of remote URIs project would deploy to. The format is like rsync over ssh but with optional ssh port number.

#### Docker control settings

Settings values that would be passed directly to `docker` command options or arguments.

##### network_create_options

```sh
network_create_options=(
  "--driver bridge"
  "--subnet 10.0.0.1/24"
)
```
Options that would be passed to [docker network create](https://docs.docker.com/engine/reference/commandline/network_create/) command when it's called.

##### network_connect_options

```sh
network_connect_options=(
  "--alias foobar"
  "--ip 10.0.0.254"
)
```
Options that would be passed to [docker network connect](https://docs.docker.com/engine/reference/commandline/network_connect/) command when it's called.

##### build_options

```sh
build_options=(
  "-f custom.dockerfile"
  "--build-arg foo=bar"
)
```
Options that would be passed to [docker build](https://docs.docker.com/engine/reference/commandline/build/) command when it's called.

##### build_args

```sh
build_args="custom/path/"
```
Arguments that would be passed to [docker build](https://docs.docker.com/engine/reference/commandline/build/) command when it's called.

##### create_options

```sh
create_options=(
  "-p 8080:80"
  "-v www:/var/www"
)
```
Options that would be passed to [docker create](https://docs.docker.com/engine/reference/commandline/create/) command when it's called.

##### create_args

```sh
create_args="ping 8.8.8.8"
```
Arguments that would be passed to [docker create](https://docs.docker.com/engine/reference/commandline/create/) command when it's called.

##### start_options

```sh
start_options=(
  "--attach"
  "--interactive"
)
```
Options that would be passed to [docker start](https://docs.docker.com/engine/reference/commandline/start/) command when it's called.

##### start_sleep

```sh
start_sleep=5
```
The number of seconds to wait before calling next `docker start` command when `instances` > 1. Useful when dockerized app is not good with sending self ready status to docker. For example – web server started, but not ready to accept connections yet.

#### Hooks

There is a number of *pre-* and *post-* hooks, that would be called before or after according docker command executed.

  - `pre_build`
  - `post_build`
  - `pre_create`
  - `post_create`
  - `pre_start`
  - `post_start`

Hook can be defined right in configuration file.

```sh
post_start() {
  # Send notification about start
  curl -d "${basename} started" http://monitoring/alert
}
```

## Development

### Code style

Please follow [Shell Style Guide](https://google.github.io/styleguide/shell.xml) by Google when writing new code or making changes.

### Tests

Run `test/all` to see current tests state.  

Test cases should be added for new features, both unit and integration (using [test/image](test/image)).

## License

This software is distributed under the [MIT license](https://github.com/ops-tools/ops-docker/blob/master/LICENSE).
