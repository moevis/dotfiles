if [[ -z "${PREFIX}" ]]; then
  echo "Please set PREFIX first."
  exit 1
fi

if [ -x "$(command -v bat)" ]; then
  echo "bat exist"
else
  batgz="bat-v0.10.0-x86_64-unknown-linux-musl.tar.gz"
  if ! [ -f "${batgz}" ]; then
    wget https://github.com/sharkdp/bat/releases/download/v0.10.0/${batgz}
  fi
  tar -xvzf ${batgz}
  mv bat-v0.10.0-x86_64-unknown-linux-musl/bat ${PREFIX}/bin/
fi