function fish_user_key_bindings
  fish_vi_key_bindings
end

set -g -x PATH /usr/local/bin $PATH
set -g -x GOPATH ~/go
set -g -x  VAULT_ADDR "https://vault.amperity.top:8200"
