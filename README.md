Dockerfile for [Yay](https://github.com/Jguer/yay)

## Usage

The packages are saved in `/home/user/pkg`.

```
$ docker run -v /output/directory:/home/user/pkg colajam93/yay /usr/bin/yay -S --noconfirm [PACKAGE]
```

## Note

This image uses Japan mirror servers.
