ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG FRP_VERSION=0.70.1

# 如果构建时下载 GitHub 缓慢，可在下面的下载地址前加镜像前缀，
# 例如：https://ghproxy.net/https://github.com/...
RUN set -x \
    && apk add --no-cache curl \
    && case "${BUILD_ARCH}" in \
         amd64)   FRP_ARCH="amd64" ;; \
         aarch64) FRP_ARCH="arm64" ;; \
         armv7)   FRP_ARCH="arm" ;; \
         *) echo "不支持的架构: ${BUILD_ARCH}" && exit 1 ;; \
       esac \
    && curl -fsSL -o /tmp/frp.tar.gz \
       "https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz" \
    && tar -xzf /tmp/frp.tar.gz -C /tmp \
    && mv "/tmp/frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc" /usr/bin/frpc \
    && chmod +x /usr/bin/frpc \
    && rm -rf /tmp/frp.tar.gz "/tmp/frp_${FRP_VERSION}_linux_${FRP_ARCH}"

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
