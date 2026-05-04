# aur-builder

Dockerfile and script for AUR package building environment.

## Usage

Build artifacts are saved in `/home/builder/pkg`.

```
DOCKER_BUILDKIT=1 docker build --pull --no-cache -t aur-builder .
docker run --rm -v /output/directory:/home/builder/pkg aur-builder -S --noconfirm [PACKAGE]
```

`bin/aur-builder build-package` uses `paru` by default. Use `-H yay` or `--helper yay`
to build packages with `yay` instead.

```
bin/aur-builder -H yay build-package
```

## Note

This image uses Japan mirror servers.
