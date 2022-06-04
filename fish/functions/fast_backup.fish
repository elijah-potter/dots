function fast_backup 
    rm -rf $HOME/.cache/*
    tar -cf - -C $HOME . | pigz | dd status=progress of=/mnt/vault/Archive/Laptop/(date -u '+%m-%d-%y_%H:%M').tar.gz
end
