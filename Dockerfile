FROM archlinux:latest

RUN sed -ri 's/^#DisableSandboxFilesystem/DisableSandboxFilesystem/' /etc/pacman.conf
RUN sed -ri 's/^#DisableSandboxSyscalls/DisableSandboxSyscalls/' /etc/pacman.conf
