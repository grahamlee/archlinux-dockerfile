# archlinux-dockerfile

Builds `docker.io/grahamlee/archlinux:latest` (Docker Hub), the base for
every container image (see the `archlinux-base-image` skill). `make push`
pulls the current upstream `archlinux:latest`, builds for `linux/amd64`
with Podman and pushes. `make login` (run by `push`) logs in to Docker Hub
as `grahamlee` with a personal access token (Read & Write) read from
`~/.config/dockerhub/token` (mode 600, outside any repo, ignored by the
dotfiles). The account rejects its password on the command line; only a
token works. This repo is on GitHub: keep secrets out of it and out of
the image.

- Multi-stage: the `rootfs` stage configures pacman and runs
  `pacman -Syu`, then the final stage copies the whole filesystem into one
  layer `FROM scratch`, so upgraded packages don't sit on top of stale ones.
  Keep `ENV LANG` and `CMD` in the final stage; they don't carry over.
- pacman sandboxing is disabled (`DisableSandboxFilesystem`,
  `DisableSandboxSyscalls`): the download sandbox fails under amd64
  emulation on an arm64 Mac.
- `NoExtract = usr/include/*` (inserted after upstream's own NoExtract
  lines) keeps C headers out of this image and every image built on it.
  Upstream already skips man pages, docs and most locales.
- Rebuild and push this regularly, and before rebuilding images on it:
  their Dockerfiles start with `pacman -Syu`, so a stale base makes every
  image re-download the months of updates into an extra layer. An
  8-month-old base made the `rspamd` image 1.02 GB instead of ~450 MB.
