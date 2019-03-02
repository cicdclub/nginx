#!/usr/bin/env bash

which nginx-amplify-agent.py
function install_amplify() {
  curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
  export API_KEY=${AMPLIFY_TOKEN}
  yes | sh ./install.sh
}

function install_ssh_key() {
  mkdir -p ~/.ssh/
  echo "${SSH_KEY_BASE64}" | base64 -d > ~/.ssh/id_rsa
  chmod 700  ~/.ssh/id_rsa
}

# Check if SSH if defined
if [[ "${SSH_KEY_BASE64}" ]]; then
  install_ssh_key
fi

# Check if AMPLIFY_TOKEN
if [[ "${AMPLIFY_TOKEN}" ]]; then
  install_amplify
fi

if [[ "${CONFIG_SOURCE}" == "GIT" ]]; then
  rm -rf /etc/nginx/*
  git clone "${GIT_CONFIG_PATH}" /etc/nginx
  cd /etc/nginx
  ln -s /usr/lib/nginx/modules modules
fi