FROM archlinux:latest AS rootfs

RUN sed -ri 's/^#DisableSandboxFilesystem/DisableSandboxFilesystem/' /etc/pacman.conf
RUN sed -ri 's/^#DisableSandboxSyscalls/DisableSandboxSyscalls/' /etc/pacman.conf
RUN sed -ri '/^NoExtract += usr\/share\/vim/a NoExtract  = usr/include/*' /etc/pacman.conf
RUN pacman -Syu --noconfirm && pacman -Scc --noconfirm && rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/* /usr/include/*

FROM scratch

COPY --from=rootfs / /

ENV LANG=C.UTF-8
CMD ["/usr/bin/bash"]
