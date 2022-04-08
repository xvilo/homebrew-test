get_release() {
  curl -sL "https://github.com/transip/tipctl/releases" | grep -Po -m 1 "v[0-9]+\.[0-9]+\.[0-9]+$" | head -n 1
}

fetch() {
  REMOTE_TIPCTL_SEMVER=$(get_release)
  OLD_TIPCTL_SEMVER=$(grep -Po -m 1 "v[0-9]+\.[0-9]+\.[0-9]+" ./Formula/tipctl.rb)
  if [ "$REMOTE_TIPCTL_SEMVER" != "$OLD_TIPCTL_SEMVER" ]; then
    sed -i -e "s|$OLD_TIPCTL_SEMVER|$REMOTE_TIPCTL_SEMVER|g" ./Formula/tipctl.rb
    url="$(grep -e "^  url.*" ./Formula/tipctl.rb | cut -d\" -f 2)"
    checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
    sed -i -e "s|^  sha256.*|  sha256 \"$checksum\"|g" ./Formula/tipctl.rb
  fi
}

fetch
