FROM python:3.11

EXPOSE 8080
WORKDIR /app

COPY app/requirements.txt ./

RUN pip install -r requirements.txt

COPY app ./

COPY data/chromadb/youtube_transcripts /app/data/chromadb/youtube_transcripts

CMD ["python", "app.py"]
