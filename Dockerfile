FROM python:3.11-slim

# 安装常见依赖（PDF/文件处理）
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmagic1 poppler-utils ffmpeg tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# 安装 markitdown + FastAPI
RUN pip install --no-cache-dir "markitdown[all]" fastapi uvicorn

WORKDIR /app
COPY app.py /app/app.py

# Railway 会注入 PORT 环境变量
CMD sh -lc 'uvicorn app:app --host 0.0.0.0 --port ${PORT:-8080}'
