FROM alpine:edge
RUN apk add --no-cache wine libc6-compat wget
ARG lip_version=0.14.0
WORKDIR /server_prebuilt
RUN wget https://github.com/LiteLDev/Lip/releases/download/v${lip_version}/lip-${lip_version}-linux-amd64.tar.gz && \
tar -xvf lip-${lip_version}-linux-amd64.tar.gz && \
chmod +x lip-${lip_version}-linux-amd64/lip && \
mkdir bedrock_server && \
cd bedrock_server && \
../lip-${lip_version}-linux-amd64/lip install -y bds && \
../lip-${lip_version}-linux-amd64/lip install liteloaderbds && \
WINEDEBUG=-all wine LLPeEditor.exe && \
rm ../lip-${lip_version}-linux-amd64.tar.gz && \
rm ~/.wine -r
COPY entrypoint.sh /
WORKDIR /server
ENV WINEDEBUG=-all
ENTRYPOINT ["sh", "/entrypoint.sh"]