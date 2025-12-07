# 使用稳定的 Node 运行时（alpine 更小）
FROM node:18-alpine

WORKDIR /app

# 安装 wget / ca-certificates（用于下载 cloudflared）
RUN apk add --no-cache wget ca-certificates

# 下载 cloudflared 可执行文件到 /usr/local/bin
# 注意：使用 cloudflared 官方 release 下载链接（linux amd64）
RUN wget -O /usr/local/bin/cloudflared \
    https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /usr/local/bin/cloudflared

# 复制 package.json & 安装依赖（production）
COPY package*.json ./
RUN npm install --production

# 复制其它文件
COPY . .

# 暴露 3000（index.js 显示监听 3000）
EXPOSE 3000

# 启动
CMD ["node", "index.js"]
