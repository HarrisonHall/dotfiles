function cdtest --wraps='mkdir -p /tmp/test && cd /tmp/test' --description 'alias cdtest=mkdir -p /tmp/test && cd /tmp/test'
  mkdir -p /tmp/test && cd /tmp/test $argv
        
end
