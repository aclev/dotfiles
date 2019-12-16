function fish_user_key_bindings
  fish_vi_key_bindings
end

set -g -x PATH /usr/local/bin $PATH
set -g -x GOPATH ~/go
set -g -x  VAULT_ADDR "https://vault.amperity.top:8200"
set -g VIRTUALFISH_VERSION 1.0.6
set -g VIRTUALFISH_PYTHON_EXEC /usr/local/opt/python@2/bin/python2.7
source /usr/local/lib/python2.7/site-packages/virtualfish/virtual.fish
emit virtualfish_did_setup_plugins
