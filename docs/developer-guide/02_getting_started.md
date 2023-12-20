# Getting Started

## Download and Install Docker

Follow the instructions here to download and install Docker: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/).

After you get it running, make sure to check your Docker preferences and increase the CPU and memory limits if it seems like it's not being given much to work with by default. I don't have recommended settings, but even the dependency installation step can take a while if you don't give Docker enough resources.

This only runs a single container though, so you shouldn't need to worry about it taking over your whole machine.

## Google Cloud Project Setup

Follow the steps in [docs/google-project-setup/README.md](../google-project-setup/README.md) to set up a Google Cloud project for use with this repo.

## Environment Variable Config

The project set up steps automatically configure important environment variables. The remaining variables and their descriptions can be found in the [.env](../../.env) file and only apply to specific notebooks.

## Managing the Environment

1. to start jupyter development environment:
   1. and build an image only if it doesn't exist already: `make start`
   2. and force build new image: `make start build=true`
   3. and open a chrome session:  `make start chrome=true`
   4. and open a firefox session, run: `make start firefox=true`
2. to use jupyter directly (I highly recommend downloading VSCode and following the VSCode section of this doc though): [http://127.0.0.1:8888/lab?token=meatwad](http://127.0.0.1:8888/lab?token=meatwad)
3. to shut down development environment, run: `make stop`

## Using the Jupyter Web Browser Environment

Read the instructions here from Codecademy for instructions on using notebooks: [How to Use Jupyter Notebooks](https://www.codecademy.com/article/how-to-use-jupyter-notebooks#heading-jupyter-interface).

## Developing in VSCode

You'll have a much better experience if you [develop in VSCode](https://code.visualstudio.com/download) instead of using the web browser environment.

Follow the steps for connecting to a [remote jupyter server](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_connect-to-a-remote-jupyter-server)
- when it prompts `Enter the URL of the running Jupyter server.`, type `http://127.0.0.1:8888/lab?token=meatwad` and hit enter
- when it prompts to name the new server, type `Local Jupyter Server` or whatever you want, and hit enter

## Adding a New Jupyter Notebook

1. run `make new_notebook name=<notebook-name>` (no spaces in the name) to create the new notebook as well as configure permissions for the jupyter container, if it's running
2. view the newly created `notebooks/<notebook-name>/<notebook-name>.ipynb` file to start editing

If you don't use the [Makefile](../../Makefile) in this repo to create new notebooks inside the container, you need to restart the docker environment (`make stop; make start`) to properly set permissions on the notebook.

### Using the Data Directory

If you want to add text files, csv's, or whatever else to use in notebooks, place the file in the [data/](data/) directory.

Use the [helpers](../../notebooks/modules/helpers/) module to facilitate accessing the files in your code.

If you place a file at `data/article.txt`, you can access it in a notebook like this:
```py
from helpers.files import get_data_dir, read_file

data_dir = get_data_dir()

# "article_text" will be the string version of the text file
article_text = read_file(f'{data_dir}/article.txt')
```

## Custom Python Modules

The root [docker-compose.yml](../../docker-compose.yml) defines `PYTHONPATH: /home/$USER/work/notebooks/modules` so anything inside that directory will be easily importable into notebooks.

That's the secret behind us being able to use absolute imports like `from helpers.files import get_data_dir` in notebooks.

### Running Tests

1. run `make test` to run all tests discoverable within the modules directory

### Generating Docs

1. run `make docs` to generate docs for all modules discoverable within the modules directory (will be available in `docs/modules/*`)

## Viewing Logs

1. run `make logs`
2. `ctrl+c` to quit tailing the log

## Starting a Bash Session Inside the Container

1. run `make bash`
2. `exit` to exit the terminal

## Persistent Directories

There are two persistent directories mounted. Any files altered outside of these directories will not persist a restart:
- `data`:`/home/$USER/work/data` intended for PDFs and things you might want to download without dealing with container annoyances
- `notebooks:/home/$USER/work/notebooks`: intended for actual jupyter notebook workspaces

## Dependencies

Everything in the repo uses a shared [requirements.txt](../../notebooks/requirements.txt) file to declare dependencies. The [requirements.txt](../../notebooks/requirements.txt) file is copied into the [Dockerfile](../../Dockerfile) so dependencies can be baked into the container image and you can get your environment up and running as quick as possible after the first build.

### Adding a New Dependency

1. update [requirements.txt](../../notebooks/requirements.txt) with your new dependencies
2. optionally update [post-pip-install.sh](../../notebooks/post-pip-install.sh) with commands to run after dependencies have been installed (after the `[START] Post Pip-Install Commands` line)
3. run `make start build=true` to start up jupyter while also rebuilding the docker image
