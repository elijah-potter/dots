function connvault
    sudo mount -t nfs 10.0.0.30:/Chonk /mnt/vault/
    cd /mnt/vault
end

function disconnvault
    sudo umount /mnt/vault/
end
