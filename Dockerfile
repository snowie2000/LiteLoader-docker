FROM alpine:edge
RUN apk add --no-cache wine libc6-compat wget curl unzip
ARG lip_url="https://github.com/LipPkg/Lip/releases/latest"
ARG bds_url="https://github.com/LiteLDev/LiteLoaderBDS/releases/latest"
WORKDIR /server_prebuilt
RUN latest_lip_version=$(curl --silent --head ${lip_url} | grep -i location | awk -F '/' '{print $NF}' | tr -d '\r\n' | sed 's/^v//') && \
latest_bds_version=$(curl --silent --head ${bds_url} | grep -i location | awk -F '/' '{print $NF}' | tr -d '\r\n' | sed 's/^v//') && \
mkdir bedrock_server && \
cd bedrock_server && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${latest_bds_version}/LiteLoaderBDS.zip && \
unzip LiteLoaderBDS.zip && \
mv LiteLoaderBDS/ ./ && \
rm LiteLoaderBDS.zip
COPY entrypoint.sh /
WORKDIR /server
ENV WINEDEBUG=-all
ENTRYPOINT ["sh", "/entrypoint.sh"]