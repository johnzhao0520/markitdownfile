FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmagic1 poppler-utils ffmpeg tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# 👇 注意这里多了 python-multipart
RUN pip install --no-cache-dir "markitdown[all]" fastapi uvicorn python-multipart

WORKDIR /app
COPY app.py /app/app.py

CMD sh -lc 'uvicorn app:app --host 0.0.0.0 --port ${PORT:-8080}'
