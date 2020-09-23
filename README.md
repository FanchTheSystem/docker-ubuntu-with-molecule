Docker Image From Ubuntu with ansible and molecule
==================================================

### Should be used in gitlab runner:

A full example here: https://gitlab.com/FanchG/ansible-molecule-skeleton

#### In .gitlab-ci.yml, add:

```yaml
image: fanchthesystem/ubuntu-with-molecule:latest
```

### Should mount /var/run/docker.sock

As this docker image include docker to be able to run **molecule test** with docker driver.

#### In your gilab runner configuration file, add:

```toml
[runners.docker]
   volumes = ["/var/run/docker.sock:/var/run/docker.sock"]
```

#### Or if you want to use it from command line:

```bash
docker run -it -v /var/run/docker.sock:/var/run/docker.sock fanchthesystem/ubuntu-with-molecule:latest /bin/bash'
```

### Note:

git is not installed as it intended to be run in gitlab runner.
