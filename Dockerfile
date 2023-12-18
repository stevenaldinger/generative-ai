# https://hub.docker.com/r/jupyter/datascience-notebook/tags
ARG BASE_IMAGE=jupyter/datascience-notebook
ARG BASE_IMAGE_TAG=2023-10-20
FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG}

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
      build-essential \
      cmake \
      liblzma-dev \
      software-properties-common \
 && add-apt-repository -y ppa:mozillateam/ppa \
 && apt clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# prioritize firefox from mozilla ppa over snap
COPY support/apt_preferences_firefox /etc/apt/preferences.d/mozilla-firefox

# /home/jovyan/.launchpadlib is owned by root, not jovyan
# so we need to run fix-permissions as root to properly install
RUN apt update && apt install -y firefox \
 && apt clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

COPY --chown=${NB_UID}:${NB_GID} notebooks/requirements.txt /tmp/
COPY --chown=${NB_UID}:${NB_GID} support/post_pip_install.sh /tmp/

RUN pip install \
      --no-cache-dir \
      --requirement /tmp/requirements.txt \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "/home/${NB_USER}" \
 && /tmp/post_pip_install.sh
