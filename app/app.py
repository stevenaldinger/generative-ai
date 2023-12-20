import os

# ****************** [START] Google Cloud project settings ****************** #
PROJECT_ID = os.environ.get('GCP_PROJECT')
LOCATION = os.environ.get('GCP_REGION')
# ******************* [END] Google Cloud project settings ******************* #

# *********************** [START] Embeddings config ************************* #
# set rate limiting options for Vertex AI embeddings
embeddings_requests_per_minute = 100
embeddings_num_instances_per_batch = 5
# *********************** [END] Embeddings config *************************** #

# *********************** [START] LLM parameter config ********************** #
# Vertex AI model to use for the LLM
model_name='chat-bison@002'

# maximum number of model responses generated per prompt
candidate_count = 3

# determines the maximum amount of text output from one prompt.
# a token is approximately four characters.
max_output_tokens = 2048
# max_output_tokens = 256

# temperature controls the degree of randomness in token selection.
# lower temperatures are good for prompts that expect a true or
# correct response, while higher temperatures can lead to more
# diverse or unexpected results. With a temperature of 0 the highest
# probability token is always selected. for most use cases, try
# starting with a temperature of 0.2.
temperature = 0.2

# top-p changes how the model selects tokens for output. Tokens are
# selected from most probable to least until the sum of their
# probabilities equals the top-p value. For example, if tokens A, B, and C
# have a probability of .3, .2, and .1 and the top-p value is .5, then the
# model will select either A or B as the next token (using temperature).
# the default top-p value is .8.
top_p = 0.8

# top-k changes how the model selects tokens for output.
# a top-k of 1 means the selected token is the most probable among
# all tokens in the model’s vocabulary (also called greedy decoding),
# while a top-k of 3 means that the next token is selected from among
# the 3 most probable tokens (using temperature).
top_k = 40

# how verbose the llm and langchain agent is when thinking
# through a prompt. you're going to want this set to True
# for development so you can debug its thought process
verbose = True
# *********************** [END] LLM parameter config ************************ #

# ********************** [START] LLM data config **************************** #
collection_name = 'youtube-transcript'
default_chroma_db_dir = '/app/data/chromadb/youtube_transcripts'
chroma_db_youtube_transcript_dir = os.environ.get('CHROMADB_DIR', default_chroma_db_dir)
# *********************** [END] LLM data config ***************************** #
import vertexai

vertexai.init(project=PROJECT_ID, location=LOCATION)

from langchain.chat_models import ChatVertexAI

llm = ChatVertexAI(
    model_name=model_name,
    max_output_tokens=max_output_tokens,
    temperature=temperature,
    top_p=top_p,
    top_k=top_k,
    verbose=verbose,
    n=candidate_count,
)

from langchain.embeddings import VertexAIEmbeddings

# https://api.python.langchain.com/en/latest/embeddings/langchain.embeddings.vertexai.VertexAIEmbeddings.html
embeddings = VertexAIEmbeddings(
    requests_per_minute=embeddings_requests_per_minute,
    num_instances_per_batch=embeddings_num_instances_per_batch,
    model_name = "textembedding-gecko@latest"
)

from langchain.vectorstores import Chroma
db = Chroma(
    persist_directory=chroma_db_youtube_transcript_dir,
    embedding_function=embeddings,
    collection_name=collection_name
)

retriever = db.as_retriever()

from langchain.schema import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain.prompts import ChatPromptTemplate

template = """Answer the question based only on the following context:

{context}

Question: {question}
"""
prompt = ChatPromptTemplate.from_template(template)

def format_docs(docs):
    return "\n\n".join([d.page_content for d in docs])


# https://python.langchain.com/docs/modules/data_connection/retrievers/
chain = (
    {"context": retriever | format_docs, "question": RunnablePassthrough()}
    | prompt
    | llm
    | StrOutputParser()
)

import gradio as gr

def chat_response(message, history):
  return chain.invoke(message)

demo = gr.ChatInterface(chat_response)

if __name__ == '__main__':
    demo.launch(
        server_name="0.0.0.0",
        server_port=8080,
    )
