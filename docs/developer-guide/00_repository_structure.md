# Repository Structure

There are a few things to be aware of in order to understand and navigate the repository effectively.

Here's the birds eye view of the important files and directory structure.

```
.
├── .env
├── app
│   └── ...
├── data
│   ├── chromadb
│   ├── gen
│   └── ...
├── docker-compose.yml
├── Dockerfile
├── docs
│   ├── developer-guide
│   ├── google-project-setup
│   ├── ...
│   └── references
├── Makefile
├── modules
│   └── helpers
├── notebooks
│   ├── ...
│   └── requirements.txt
├── README.md
├── support
│   ├── gcloud
│   │   └── docker-compose.yml
│   ├── ...
│   └── post_pip_install.sh
└── terraform
    ├── docker-compose.yml
    ├── ...
    ├── main.tf
    ├── terraform.tfvars
    └── variables.tf
```

The [.env](../../.env) file contains environment variables that are used by the various `docker-compose.yml` files to configure the development environment.

The [app](../../app) directory contains the code for the chatbot example. It's a simple [Gradio](https://www.gradio.app/) app that uses a [ChromaDB](https://www.trychroma.com/) database created in the [YouTube Transcripts](notebooks/langchain-react-zero-shot-youtube) notebook to retrieve the most relevant transcript for a given query.

The [data](../../data) directory contains the data used by the examples. Since the code is going to execute inside of a Docker container and not on our actual computer, we need a way to share things between our computer's filesystem and the container for the code to work with. The data directory is set up for exactly that purpose, and we'll also use it to store artifacts the code generates so we can easily save and review things after we shut down the container.

The root [docker-compose.yml](../../docker-compose.yml) declares how to run our development Docker container. It sets up things like environment variables, volume mounts, and port forwarding.

The root [Dockerfile](../../Dockerfile) contains everything needed to run the examples. This installs Python and other tools to run inside a container, so nothing needs to be installed on your actual computer (other than [Docker](https://www.docker.com/products/docker-desktop/)), and the environment executing the code should be identical no matter who's computer it's running on.

The [docs](..) directory has a variety of documentation covering how the development environment is set up and notes on tools and techniques that are demonstrated in the [Jupyter notebooks](../../notebooks).

The [Makefile](../../Makefile) contains various groups of relatively complex commands bundled up in an easy-to-use interface. Instead of having to run something ugly like `docker compose -f app/docker-compose.yml build chatbot`, we can just run `make build_chatbot`.

The [modules](../../modules) directory contains helper functions and other Python code that reduces code duplication in notebooks, lets us [unit test](../../modules/helpers/tests) commonly used code, lets us hide complexity of code that's irrelevant to generative AI concepts like checking if files/directories exist, and is closer to what production code would look like (vs. everything stuffed into a notebook) if we wanted to build real applications.

The [notebooks](../../notebooks) directory contains the fun stuff. Documented examples of runnable, generative AI code will all be living in this spot.
- It contains a global [requirements.txt](../../notebooks/requirements.txt) file that lists the Python dependencies needed to run all the examples.

The root [README.md](../../README.md) contains a high level overview of the repository and links to the documentation and examples.

The [support](../../support) directory contains various files that are used to set up the development environment. - The [gcloud](../../support/gcloud) directory contains a `docker-compose.yml` file that sets up a container with the Google Cloud SDK installed so we can run `gcloud` commands without actually installing the tool.
- The [post_pip_install.sh](../../support/post_pip_install.sh) script is run after dependencies are installed within the [Dockerfile](../../Dockerfile) and can run arbitrary commands that need to be run after dependency installation.

The [terraform](../../terraform) directory contains the code responsible for bootstrapping a Google Cloud project so that all of the examples work without needing to spend the time setting things up manually.
