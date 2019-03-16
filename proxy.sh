function get_proxy() {
  echo "http proxy: ${http_proxy}"
  echo "git  proxy: $(git config --global http.proxy)"
}

function toggle_proxy() {
  if [[ "${http_proxy}" == "" ]]; then
    echo "Toggle proxy on"
    git config --global http.proxy socks5://127.0.0.1:1081
    export http_proxy="socks5://127.0.0.1:1081"
  else
    echo "Toggle proxy off"
    unset http_proxy
    git config --global --unset http.proxy
  fi
}