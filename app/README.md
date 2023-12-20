# Chat Bot with Vertex AI and ChromaDB

This is a really simple chat bot set up that uses the embeddings generated and stored in ChromaDB after running the [langchain-react-zero-shot-youtube](../notebooks/langchain-react-zero-shot-youtube/react-zero-shot-youtube-transcript-chat.ipynb) example. Do not try building or running this before running that example.

This is the furthest thing from production ready code or a production ready configuration. It just gives an example of how to break free from jupyter notebooks.

## Running Locally

To build and image and run the container locally, run the following command:
```sh
make start_chatbot

# to stop
make stop_chatbot
```

The chat bot interface will be available at [localhost:8080](http://localhost:8080).

## Deploying to Cloud Run

Follow the [docs/developer-guide/03_deploying_cloud_run_app.md](../docs/developer-guide/03_deploying_cloud_run_app.md) guide to deploy the chat bot to Cloud Run.
