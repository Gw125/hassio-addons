ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG FRP_VERSION=0.70.1

# 下载 frp：优先直连 GitHub，失败则自动尝试镜像加速
RUN set -x \
    && apk add --no-cache curl \
    && case "${BUILD_ARCH}" in \
         amd64)   FRP_ARCH="amd64" ;; \
         aarch64) FRP_ARCH="arm64" ;; \
         armv7)   FRP_ARCH="arm" ;; \
         *) echo "不支持的架构: ${BUILD_ARCH}" && exit 1 ;; \
       esac \
    && URL="https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz" \
    && ( curl -fsSL --connect-timeout 20 -o /tmp/frp.tar.gz "${URL}" \
         || curl -fsSL --connect-timeout 20 -o /tmp/frp.tar.gz "https://ghproxy.net/${URL}" \
         || curl -fsSL --connect-timeout 20 -o /tmp/frp.tar.gz "https://gh-proxy.com/${URL}" ) \
    && tar -xzf /tmp/frp.tar.gz -C /tmp \
    && mv "/tmp/frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc" /usr/bin/frpc \
    && chmod +x /usr/bin/frpc \
    && rm -rf /tmp/frp.tar.gz "/tmp/frp_${FRP_VERSION}_linux_${FRP_ARCH}"

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
