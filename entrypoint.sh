#!/bin/bash
if [ -d "/server_prebuilt" ]; then
    mv /server_prebuilt/* /server/
    rm -r /server_prebuilt
fi
cd /server/bedrock_server
if [ -f "bedrock_server.exe" ]; then
    WINEDEBUG=-all wine LLPeEditor.exe
else
    echo "File bedrock_server.exe not found in working directory, no further operation is required"
fi
wine bedrock_server_mod.exe