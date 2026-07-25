#!/command/with-contenv bashio

SERVER_ADDR=$(bashio::config 'server_addr')
SERVER_PORT=$(bashio::config 'server_port')
TOKEN=$(bashio::config 'token')
LOCAL_IP=$(bashio::config 'local_ip')
LOCAL_PORT=$(bashio::config 'local_port')
REMOTE_PORT=$(bashio::config 'remote_port')

bashio::log.info "生成 frpc 配置 ..."

cat > /tmp/frpc.toml <<EOF
serverAddr = "${SERVER_ADDR}"
serverPort = ${SERVER_PORT}
auth.method = "token"
auth.token = "${TOKEN}"
login.failExit = false

[[proxies]]
name = "homeassistant"
type = "tcp"
localIP = "${LOCAL_IP}"
localPort = ${LOCAL_PORT}
remotePort = ${REMOTE_PORT}
EOF

bashio::log.info "正在连接 frps 服务器 ${SERVER_ADDR}:${SERVER_PORT} ..."
exec frpc -c /tmp/frpc.toml
