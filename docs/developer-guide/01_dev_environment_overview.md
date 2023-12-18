# Development Environment

The development environment works by mounting certain directories from your local machine into the container and configuring permissions to match your local user. This allows you to edit the code on your local machine or add PDFs and other artifacts to work with while still running code inside the container. The following directories are mounted inside the container:
- `data/` - this is where you'll place any data files you want to use in your notebooks
- `docs/` - there's a command to automatically generate documentation from the Python modules, and that gets generated into the `docs/modules/`
- `modules/` - this is where custom modules live to be used in the notebooks
- `notebooks/` - this is where all Jupyter notebooks are stored
- `~/.config/gcloud/` - this is where your gcloud credentials are stored so you don't have to re-authenticate every time you start the container

## Environment Variables

Refer to the [.env](../../.env) file for a list of environment variables that are used to configure the development container.

## Ports

The following ports are exposed by the container so things can be made available in your local browser:
- `5000` - for Gradio to listen on or anything miscelaneous
- `8888` - the port used by Jupyter notebooks
- `9999` - the port used by pydoc server

## Usage

Check out the `Managing the Environment` section of the [Getting Started](./02_getting_started.md) guide for usage instructions.
