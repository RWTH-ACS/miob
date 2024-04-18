
PROJECT_PATH=build/tmp/deploy/images/miob-zcu106-zynqmp

if [ -z $1 ]; then
    echo "Usage: $0 <user@server:project_root>"
    exit 1
fi

scp $1/$PROJECT_PATH/boot.bin .
scp $1/$PROJECT_PATH/boot.scr .
scp $1/$PROJECT_PATH/Image .
scp $1/$PROJECT_PATH/system.dtb .
scp $1/$PROJECT_PATH/miob-dev-image-miob-zcu106-zynqmp.tar.gz .
