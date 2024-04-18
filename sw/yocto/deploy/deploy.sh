if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <boot partition directory> <root partition directory>"
    exit 1
fi

echo "copying boot.bin"
cp boot.bin $1
echo "copying boot.scr"
cp boot.scr $1
echo "copying Image"
cp Image $1
echo "copying system.dtb"
cp system.dtb $1
echo "extracting rootfs"
sudo tar xfp miob-dev-image-miob-zcu106-zynqmp.tar.gz -C $2
echo "syncing"
sudo sync
