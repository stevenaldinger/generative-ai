#!/usr/bin/env bash

notebook_name=$1

# ============================ [START] Functions ============================ #
# uses heredoc to create a new notebook in the notebooks directory with
# some prefilled markdown and a code cell that prints the notebook name
function create_notebook() {
  directory="$BASE_DIR/notebooks/$notebook_name"
  mkdir -p "$directory"

  # use heredoc to create a new notebook in the notebooks directory
  cat <<EOF > "$directory/$notebook_name.ipynb"
{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "b3d5d4bf-dadf-4058-8024-9da9e1ebbc89",
   "metadata": {},
   "source": [
    "# $notebook_name Notebook"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "7ecb0037-7968-4976-8324-9048df23d860",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "$notebook_name Notebook\n"
     ]
    }
   ],
   "source": [
    "print('$notebook_name Notebook')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "076f2cc2-ed7b-4381-ad68-e6c21b811f48",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}

EOF
}

# checks if the jupyter docker container is running and if so, runs the
# fix-permissions command inside the container so the files can be saved
# from within the container's environment
function fix_permissions() {
  # check if the jupyter docker container is running
  if [ "$(docker ps -q -f name=jupyter)" ]
  then
    # create a new notebook in the notebooks directory inside the container
    docker exec -it jupyter fix-permissions
  fi
}
# ============================= [END] Functions ============================= #

create_notebook
fix_permissions
