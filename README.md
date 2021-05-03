Dockerfile for AUR building environment using [Yay](https://github.com/Jguer/yay).

## Usage

Build artifacts are saved in `/home/builder/pkg`.

```
DOCKER_BUILDKIT=1 docker build --pull --no-cache -t aur-builder .
docker run --rm -v /output/directory:/home/builder/pkg aur-builder -S --noconfirm [PACKAGE]
```

## Note

This image uses Japan mirror servers.
