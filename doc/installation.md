# Installation

By its nature ops-docker has no need in installation and could be used wherever it placed if all [runtime dependencies](#dependencies) are satisfied, so you can just download and copy [ops-docker](../ops-docker) script to your PATH or local project. If you feel not right with manual copying files from GithHub and want some level of automatization and versioning, you can choose one of the following installation methods, which is best fits your needs.

## Git Submodule

In this method, ops-docker will be added as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to your project's repository. This gives you standard well-known git way for tracking updates and fetching latest versions.

Add ops-docker as submodule from branch *release* and shallow clone it.

```sh
$ git config -f .gitmodules submodule.ops-docker.shallow true
$ git submodule add -b release -- https://github.com/ops-tools/ops-docker.git ops-docker
```

Commit added submodule.

```sh
$ git commit -m 'Add ops-docker submodule'
```

Now you can use ops-docker from local directory: `ops-docker/ops-docker --help`.

## Dependencies

List of runtime dependencies.

 - bash
 - sed
 - tar
 - ssh
 - openssl
 - rsync
 - docker

Follow next guides for installing dependencies in your operating system if they're not already there.

### Debian 9 Stretch or later

Run as root.

```sh
apt update
apt install bash sed tar openssh openssl rsync docker.io
```

### Ubuntu 18.04 LTS or later

```
sudo apt update
sudo apt install bash sed tar openssh openssl rsync docker.io
```

### Docker

If you want to use latest Docker distribution, please refer to [official documentation](https://docs.docker.com/install/) for your OS.
