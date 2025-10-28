FROM fedora:43

# Install development libraries
RUN dnf install -y \
    blueprint-compiler \
    gtk4-devel \
    libadwaita-devel \
    libportal-devel \
    libportal-gtk4-devel \
    libvala-devel \
    meson \
    ninja-build \
    vala \
    vala-language-server

# Setup non-root user
RUN groupadd -g 1000 build && \
    useradd -u 1000 -g 1000 -m build

USER 1000

HEALTHCHECK NONE