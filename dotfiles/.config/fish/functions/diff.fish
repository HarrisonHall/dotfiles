function diff --wraps=colordiff --description 'alias diff=colordiff'
    set real_diff (which diff)
    $real_diff $argv | bat
end
