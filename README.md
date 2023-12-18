# Generative AI with Vertex AI

This repository contains a practical collection of generative AI applications for various things as well as an example of fine-tuning an existing model using [Vertex AI](https://cloud.google.com/vertex-ai/docs) and [Google Cloud Platform](https://cloud.google.com/).

**HEADS UP!!!** Running the examples will cost money, but Google should give you a $300 free trial the first time you sign up. **_The cost of running the supervised-learning example can be $50+_**. The cost of running the other examples is relatively small, where if you spent all day messing with things you'd probably still be under a few dollars.

There is a single-command setup for starting up the development environment, and a separate single-command setup for setting up your Google Cloud project and any cloud resources needed for running examples. You need to set the `GCP_PROJECT` variable manually in the [.env](.env) after creating a project, and optionally a `GITHUB_TOKEN`  and `GOOGLE_CSE_ID` (Programmable Search Engine) depending on the notebooks you intend to run. All other variables will be set automatically if you follow the instructions.

**NOTE:** windows is not supported. if you run docker on windows and want to try getting it to work, the `NB_UID` and `NB_USER` environment variables in the [docker-compose.yml](docker-compose.yml), and any volume mounts in any `docker-compose.yml` files are what I'd expect to fail.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Overview of the Stack](#overview-of-the-stack)
3. [Notebooks](#notebooks)
    1. [Blog Title Generation](#blog-title-generation) (Content Generation Series: Part 1)
    2. [Blog Article Generation](#blog-article-generation) (Content Generation Series: Part 2)
    3. [Blog Article Supervised Tuning](#blog-article-supervised-tuning) (Content Generation Series: Part 3)
    4. [Wikipedia-Connected ReAct Agent](#wikipedia-connected-react-agent)
    5. [World Pool-Billiard Association Rule Book Chat Bot](#pdf-knowledge-base-retrieval-augmented-generation) (PDF source)
    6. [Valorant (Riot Games) FAQ and News Question-Answering](#valorant-riot-games-faq-and-news-question-answering) (custom search engine)
    7. [YouTube Presentation Question-Answering](#youtube-presentation-question-answering) (transcript API)
    8. [YouTube Presentation Question-Answering Chat Bot](#youtube-presentation-question-answering-chat-bot) (transcript API)
    9. [Competitive Analysis Question-Answering](#competitive-analysis-question-answering) (Selenium)
    10. [Engineering Incident Response Question-Answering](#engineering-incident-response-question-answering) (Slack export)
    11. [Repository-Aware Code Generation from Local Repo](#repository-aware-code-generation-local-repo)
    12. [Repository-Aware Code Generation from Remote GitHub Repo](#repository-aware-code-generation-remote-repo)
4. [Documentation](docs)
    1. [Repository Structure](docs/developer-guide/00_repository_structure.md)
    2. [Development Environment Overview](docs/developer-guide/01_dev_environment_overview.md)

## Getting Started

Follow the guide in [docs/developer-guide/02_getting_started.md](docs/developer-guide/02_getting_started.md) to get started.

## Overview of the Stack

1. [Docker](https://www.docker.com/products/docker-desktop/) (❤️) lets us package up an operating system and all of the dependencies our code needs to function in a way where everything "just works" on anyone's computer. This is the only tool you'll need to install, but I recommend [VS Code](https://code.visualstudio.com/) as a code editor as well if you're really going to tinker.
2. [Terraform](https://www.terraform.io/) is an infrastructure-as-code (IaC) tool used for automatically enabling the Google Cloud APIs you need in order to run the examples, creating (and cleaning up when you're done) a service account and storage bucket for fine-tuning job pipelines, creating a minimally-scoped API key for a custom search engine example, and deploying a chatbot example to Google Cloud Run.
3. [Jupyter Notebook](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/what_is_jupyter.html) is a super clever tool that combine executable code (like [Python](https://www.python.org/)) and supporting [Markdown](https://www.markdownguide.org/) documentation into a single file (like [this example](https://github.com/stevenaldinger/generative-ai-temp-private/blob/main/notebooks/langchain-react-zero-shot-pdf/react-zero-shot-pdf-source.ipynb)), which is a great way to explain coding concepts step-by-step. It lets you save output of the code after it executes, so people can see the behavior of the code in their browser without running their own development environment.
4. [Vertex AI](https://cloud.google.com/vertex-ai) is Google's enterprise-ready generative AI solution. Models used include `textembedding-gecko`, `text-bison`, `chat-bison`, and `code-bison`. If you want to play with the new [Gemini](https://deepmind.google/technologies/gemini/#introduction) model and see for yourself how much Google may or may not have been _stretching the truth_ with their marketing video, the environment used for these examples is fully ready for you to drop Gemini code into as well.
5. [LangChain](https://www.langchain.com/) gives us some [high level tools](https://python.langchain.com/docs/use_cases/question_answering/) for working with generative AI. It has simple interfaces for working with embeddings, vector stores, and large language models (LLM) that we'll make frequent use of, as well as implementations of various common chains.
6. [ChromaDB](https://www.trychroma.com/) is an open source embeddings/vector database and lets us work with larger content than will fit in a typical prompt. It also lets us persist the embeddings in between development sessions, and bake the database into a container image to be deployed as a demo.
7. [Make](https://www.gnu.org/software/make/) is part of the [GNU project](https://www.gnu.org/home.en.html), comes preinstalled in MacOS and commonly in Linux, and allows hiding the complexity of logic being run behind a simple command that will look like `make some-target`. This is the only tool you need to directly interface with to use the repository.

## Notebooks

<a id="blog-title-generation"></a>

### [Blog Title Generation](notebooks/blog-title-generation/blog-title-generation.ipynb)

This is part 1/3 for the blog article content generation and supervised tuning series.

It's a super basic example of using Google's [text-bison](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/text) model to generate blog titles based on a configured list.

<a id="blog-article-generation"></a>

### [Blog Article Generation](notebooks/blog-article-generation/blog-article-generation.ipynb)

This is part 2/3 for the blog article content generation and supervised tuning series.

It's a similar example to the blog title generator, using Google's [text-bison](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/text) model to generate blog articles based on the blog titles generated in the [Blog Title Generation](./notebooks/blog-title-generation/) notebook.

<a id="blog-article-supervised-tuning"></a>

### [Blog Article Supervised Tuning](notebooks/blog-article-supervised-tuning/blog-article-supervised-tuning.ipynb)

This is part 3/3 for the blog article content generation and supervised tuning series.

It's an example of [fine-tuning](https://cloud.google.com/vertex-ai/docs/generative-ai/models/tune-text-models-supervised) Google's [text-bison](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/text) model to generate blog articles in a specific format based on a minimal prompt.

<a id="wikipedia-connected-react-agent"></a>

### [Wikipedia-Connected ReAct Agent](notebooks/langchain-react-docstore-wikipedia/react-docstore-wikipedia-source.ipynb)

This is an example of using [LangChain](https://www.langchain.com/) to build a [ReAct agent](https://python.langchain.com/docs/modules/agents/agent_types/react) that can answer questions by pulling from Wikipedia articles.

<a id="valorant-riot-games-faq-and-news-question-answering"></a>

### [Valorant (Riot Games) FAQ and News Question-Answering](notebooks/langchain-react-zero-shot-custom-search-engine/react-zero-shot-custom-search-engine.ipynb)

This example uses Google's Programmable Search Engine to gather content from specific online sources to answer questions about Valorant.

<a id="world-pool-billiard-association-rule-book-chat-bot"></a>

### [World Pool-Billiard Association Rule Book Chat Bot](notebooks/langchain-react-zero-shot-pdf/react-zero-shot-pdf-source.ipynb) (PDF source)

This examples demonstrates reading in a PDF rule book to augment the generated responses of a chat bot.

<a id="youtube-presentation-question-answering"></a>

### [YouTube Presentation Question-Answering](notebooks/langchain-react-zero-shot-youtube/react-zero-shot-youtube-transcript.ipynb)

This examples demonstrates reading in a transcript from a YouTube video to create a question-answering agent.

It also shows how to use Gradio to easily create a user interface for the agent.

<a id="youtube-presentation-question-answering-chat-bot"></a>

### [YouTube Presentation Question-Answering Chat Bot](notebooks/langchain-react-zero-shot-youtube/react-zero-shot-youtube-transcript-chat.ipynb)

This example is identical to the other YouTube example except it has a chat bot interface.

<a id="competitive-analysis-question-answering"></a>

### [Competitive Analysis Question-Answering](notebooks/langchain-selenium-url/react-zero-shot-selenium-url.ipynb) (Selenium)

This example uses LangChain's Selenium document loader to gather content from a marketing page and answer questions about plans and pricing.

<a id="engineering-incident-response-question-answering"></a>

### [Engineering Incident Response Question-Answering](notebooks/langchain-react-zero-shot-slack/react-zero-shot-slack-source.ipynb) (Slack export)

This example uses LangChain's Slack document loader to gather content from a Slack export of on-call channels and answer questions about incident response.

<a id="repository-aware-code-generation-local-repo"></a>

### [Repository-Aware Code Generation from Local Repo](notebooks/langchain-local-repo-code-generation/langchain-local-repo-code-generation.ipynb)

This example reads in files from a local repository, generates embeddings, and generates code based on the repository contents.

<a id="repository-aware-code-generation-remote-repo"></a>

### [Repository-Aware Code Generation from Remote GitHub Repo](notebooks/langchain-github-repo-code-generation/langchain-github-repo-code-generation.ipynb)

This example is the same as the local repository example except it reads in files from a remote GitHub repository.

Both public and private repositories can be read in.
