# Miscellaneous References

These may or may not be used in the project, but are here for reference.

## Google Programmable Search Engine

To use a custom search engine, you need a Google Cloud API key (created by Terraform) and a Customer Search Engine ID (created manually).

Follow instructions here to [create a new Custom Search Engine](https://programmablesearchengine.google.com/controlpanel/create).

### View and Configure Search Engines

Main control panel is [here](https://programmablesearchengine.google.com/u/1/controlpanel/all).

### References

- [Google Cloud: Configure Google API Key](https://console.cloud.google.com/apis/credentials?authuser=1&project=steven-aldinger)
- [LangChain: Google Search Integration](https://python.langchain.com/docs/integrations/tools/google_search)
- [LangChain: Google Search Limiting Results](https://python.langchain.com/docs/integrations/tools/google_search#number-of-results)
- [Programmable Search Engine: Control Panel - Create](https://programmablesearchengine.google.com/controlpanel/create)

## ReAct Prompting

The ReAct prompt pattern is a way to use the [LangChain](https://python.langchain.com/) library to create a multi-agent system that can interact with external sources, such as knowledge bases or environments, to gather additional information. This is done by interleaving reasoning and acting in a way that allows for greater synergy between the two: reasoning traces help the model induce, track, and update action plans as well as handle exceptions, while actions allow it to interface with external sources.

### Overview

Source: [ReAct: Interleaving Reasoning and Acting for Interactive Question Answering and Decision Making](https://arxiv.org/abs/2210.03629)

> While large language models (LLMs) have demonstrated impressive capabilities across tasks in language understanding and interactive decision making, their abilities for reasoning (e.g. chain-of-thought prompting) and acting (e.g. action plan generation) have primarily been studied as separate topics. In this paper, we explore the use of LLMs to generate both reasoning traces and task-specific actions in an interleaved manner, allowing for greater synergy between the two: reasoning traces help the model induce, track, and update action plans as well as handle exceptions, while actions allow it to interface with external sources, such as knowledge bases or environments, to gather additional information. We apply our approach, named ReAct, to a diverse set of language and decision making tasks and demonstrate its effectiveness over state-of-the-art baselines, as well as improved human interpretability and trustworthiness over methods without reasoning or acting components. Concretely, on question answering (HotpotQA) and fact verification (Fever), ReAct overcomes issues of hallucination and error propagation prevalent in chain-of-thought reasoning by interacting with a simple Wikipedia API, and generates human-like task-solving trajectories that are more interpretable than baselines without reasoning traces. On two interactive decision making benchmarks (ALFWorld and WebShop), ReAct outperforms imitation and reinforcement learning methods by an absolute success rate of 34% and 10% respectively, while being prompted with only one or two in-context examples.

## Vector Stores

Examples:
- [ChromaDB](https://www.trychroma.com/)
- [GCP Vector Search](https://cloud.google.com/vertex-ai/docs/vector-search/overview)

Google Cloud's offering can apparently take hours to set up and cost hundreds of dollars a month even if it's not in use. That's why we're using ChromaDB exclusively.

### What Are Vector Stores?

Source: https://www.datacamp.com/tutorial/chromadb-tutorial-step-by-step-guide

> Vector stores are databases explicitly designed for storing and retrieving vector embeddings efficiently. They are needed because traditional databases like SQL are not optimized for storing and querying large vector data.
>
> Embeddings represent data (usually unstructured data like text) in numerical vector formats within a high-dimensional space. Traditional relational databases are not well-suited to storing and searching these vector representations.
>
> Vector stores can index and quickly search for similar vectors using similarity algorithms. It allows applications to find related vectors given a target vector query.
>
> In the case of a personalized chatbot, the user inputs a prompt for the generative AI model. The model then searches for similar text within a collection of documents using a similarity search algorithm. The resulting information is then used to generate a highly personalized and accurate response. It is made possible through embedding and vector indexing within vector stores.

### References
- [LangChain: VertexAI Vector Store](https://python.langchain.com/docs/integrations/vectorstores/matchingengine)
- [LangChain: Vertex AI Index Creation](https://python.langchain.com/docs/integrations/vectorstores/matchingengine#create-index-and-deploy-it-to-an-endpoint)
- [Research Paper: Transformer Proposal](https://arxiv.org/abs/1706.03762)
- [Medium Article: Vertex AI Matching Engine](https://medium.com/google-cloud/all-you-need-to-know-about-google-vertex-ai-matching-engine-3344e85ad565)
- [ChromaDB + LangChain](https://blog.futuresmart.ai/using-langchain-and-open-source-vector-db-chroma-for-semantic-search-with-openais-llm)

## Miscellaneous AI

- [ChromaDB Visualizer](https://github.com/mtybadger/chromaviz) (this did not work out of the box for me)
- [Generative AI Applications with Vertex AI, PALM-2 Models, and LangChain](https://cloud.google.com/blog/products/ai-machine-learning/generative-ai-applications-with-vertex-ai-palm-2-models-and-langchain)
- [LangChain ChatVertexAI](https://python.langchain.com/docs/integrations/chat/google_vertex_ai_palm)
- [LangChain Conversational Retrieval Agents](https://python.langchain.com/docs/use_cases/question_answering/conversational_retrieval_agents)
- [LangChain Retrievers](https://python.langchain.com/docs/modules/data_connection/retrievers/)
- [LangChain URL Loader Comparison](https://heartbeat.comet.ml/langchain-document-loaders-for-web-data-f93bd1d8d6a6)
- [Master the Art of Chunk Splitting with LangChain](https://www.toolify.ai/ai-news/master-the-art-of-chunk-splitting-with-langchain-48658)
- [MLOps - Vertex AI](https://github.com/GoogleCloudPlatform/mlops-with-vertex-ai)
- [Querying Vector Store with LangChain](https://python.langchain.com/docs/modules/data_connection/vectorstores/)
- [Reduce AI Hallucinations](https://www.makeuseof.com/how-to-reduce-ai-hallucination/#:~:text=Clear%20and%20specific%20prompts%20are,a%20specific%20source%20or%20perspective)
- [User Interface for LLMs with Gradio](https://github.com/gradio-app/gradio)
- [Vertex AI - Benefits of Model Tuning](https://cloud.google.com/vertex-ai/docs/generative-ai/models/tune-text-models#benefits_of_text_model_tuning)
- [Vertex AI - GCP Samples Repo](https://github.com/GoogleCloudPlatform/vertex-ai-samples/blob/main/notebooks/community/generative_ai/text_embedding_api_cloud_next_new_models.ipynb)
- [Vertex AI - Model Tuning](https://cloud.google.com/vertex-ai/docs/generative-ai/models/tune-models)
- [Vertex AI - Model Tuning Example](https://github.com/GoogleCloudPlatform/python-docs-samples/blob/6c55ca1a3a6b8865b7409a751a04be93d52c7519/generative_ai/tuning.py)
- [Vertex AI - Prompt Best Practices](https://cloud.google.com/vertex-ai/docs/generative-ai/chat/chat-prompts#context_best_practices)
- [Vertex AI - Prompt Examples (classification in chat bots to steer convo, blog article sentiment)](https://cloud.google.com/vertex-ai/docs/generative-ai/learn/prompt-samples)
- [Vertex AI - Recommended tuning configs](https://cloud.google.com/vertex-ai/docs/generative-ai/models/tune-text-models-supervised#recommended_configurations)
- [Vertex AI - Reinforcement Learning from Human Feedback: Human Preference Dataset](https://cloud.google.com/vertex-ai/docs/generative-ai/models/tune-text-models-rlhf#human-preference-dataset)
- [Vertex AI - Text embeddings](https://cloud.google.com/vertex-ai/docs/generative-ai/embeddings/get-text-embeddings#generative-ai-get-text-embedding-python_vertex_ai_sdk)
- [Vertex AI - Tuning for Various types of prompts (classification, generation, etc)](https://cloud.google.com/vertex-ai/docs/generative-ai/text/text-prompts#best_practices_for_classification_prompts)
- [Vertex AI & LangChain Intro Tutorial](https://github.com/GoogleCloudPlatform/generative-ai/blob/main/language/orchestration/langchain/intro_langchain_palm_api.ipynb)

## Local Dev Set Up

- [Docker Stacks on GitHub](https://github.com/jupyter/docker-stacks)
- [Docker Stack Recipes](https://github.com/jupyter/docker-stacks/blob/main/docs/using/recipes.md)
- [Jupyter Docker Stacks Usage](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html)
- [Selecting a Docker Stack](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-datascience-notebook)
- https://github.com/jupyter/docker-stacks/issues/1187#issuecomment-727577239
