function fish_user_key_bindings
  fish_vi_key_bindings
end

function remove_tabs
    ruby -pe '$_.gsub!(/\t/,"    ")' < $argv[0] > $argv[0].new
    mv $argv[0].new $argv[0]
end

function gant
    remove_tabs $argv[0]
    git add $argv[0]
end

