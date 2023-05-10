FROM alpine:edge
RUN apk add --no-cache wine libc6-compat wget
ARG lip_version=0.14.0
ARG lip_url="https://github.com/LipPkg/Lip/releases/latest"
WORKDIR /server_prebuilt
RUN latest_version=$(curl --silent --head $url | grep -i location | awk -F '/' '{print $NF}' | tr -d '\r\n' | sed 's/^v//') && \
wget https://github.com/LiteLDev/Lip/releases/download/v${latest_version}/lip-${latest_version}-linux-amd64.tar.gz && \
tar -xvf lip-${latest_version}-linux-amd64.tar.gz && \
chmod +x lip-${latest_version}-linux-amd64/lip && \
mkdir bedrock_server && \
cd bedrock_server && \
../lip-${latest_version}-linux-amd64/lip install -y bds && \
../lip-${latest_version}-linux-amd64/lip install liteloaderbds && \
WINEDEBUG=-all wine LLPeEditor.exe && \
rm ../lip-${latest_version}-linux-amd64.tar.gz && \
rm ~/.wine -r
COPY entrypoint.sh /
WORKDIR /server
ENV WINEDEBUG=-all
ENTRYPOINT ["sh", "/entrypoint.sh"]