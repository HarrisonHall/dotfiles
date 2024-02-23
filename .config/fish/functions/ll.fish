function ll --wraps='ls -l' --wraps='eza -la --icons=auto' --description 'alias ll eza -la --icons=auto'
  eza -la --icons=auto $argv
        
end
