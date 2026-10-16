FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖（如果有需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# 从 GitHub 安装这个包
RUN pip install --no-cache-dir "git+https://github.com/moonlin1213/cove-sticker-mcp.git@main"

# 创建数据目录（Zeabur 的持久卷会挂载到这里）
RUN mkdir -p /mnt/data

# 环境变量默认值
ENV STICKER_MCP_DATA_DIR=/mnt/data
ENV PORT=8765

EXPOSE 8765

# 启动命令：监听所有网络接口，端口用 Zeabur 注入的 PORT
CMD ["sh", "-c", "sticker-mcp serve-http --host 0.0.0.0 --port $PORT"]
