FROM python:3.11-slim

# 安装一些必要的依赖（PDF/文件处理常用）
RUN apt-get update && apt-get install -y libmagic1 poppler-utils && rm -rf /var/lib/apt/lists/*

# 安装 markitdown 和 mcp
RUN pip install --no-cache-dir "markitdown[all]" markitdown-mcp

# Railway 会注入 PORT 环境变量，这里要监听它
CMD sh -lc 'markitdown-mcp --http --host 0.0.0.0 --port ${PORT:-8080}'
