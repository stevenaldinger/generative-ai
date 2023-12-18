#!/usr/bin/env bash

# =========================== [START] Script Setup =========================== #
# -e: exit immediately if a command exits with a non-zero status
# -x: print each command before executing it
set -ex

echo "*** running post-pip-install script..."
# ============================ [END] Script Setup ============================ #


# ===================== [START] Post Pip-Install Commands ==================== #
# set up "english" spacy model https://spacy.io/models
python -m spacy download en_core_web_sm
# ====================== [END] Post Pip-Install Commands ===================== #


# ========================== [START] Script Teardown ========================= #
echo "*** successfully ran post-pip-install script!"

# toggle off -e and -x so we can't cause side effects
set +ex

exit 0
# =========================== [END] Script Teardown ========================== #
