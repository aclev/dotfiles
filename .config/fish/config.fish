function fish_user_key_bindings
  fish_vi_key_bindings
end

function remove_tabs
    ruby -pe '$_.gsub!(/\t/,"    ")' < $argv > $argv.new
    mv $argv.new $argv
end

function gant
    remove_tabs $argv
    git add $argv
end

function foo
    echo $argv[0]
end

