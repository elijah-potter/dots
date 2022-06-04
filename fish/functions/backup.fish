function backup
    rm -rf $HOME/.cache/*
    tar -cf - -C $HOME . | pigz | dd status=progress | connhome cat - \> /mnt/vault/Archive/Laptop/(date -u '+%m-%d-%y_%H:%M').tar.gz
end
