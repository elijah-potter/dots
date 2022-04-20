function backup
    tar -czf - -O $HOME | connhome cat - \> /mnt/vault/Archive/Laptop/(date -u '+%m-%d-%y').tar.gz
end
