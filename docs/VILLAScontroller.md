# VILLAScontroller

The [VILLAScontroller](https://git.rwth-aachen.de/acs/public/villas/controller) Python script periodically send status updates to [VILLASweb](https://git.rwth-aachen.de/acs/public/villas/controller).

## Setup

```bash
pip install git+https://git.rwth-aachen.de/acs/public/villas/controller
mkdir -p /etc/villas/controller
wget -O /etc/villas/controller/config.yaml https://raw.githubusercontent.com/RWTH-ACS/miob/main/sw/villas-controller/config.yaml
sed -i "s/18b979fe-ac43-11ec-95be-f391f46606cb/$(uuid)/g" /etc/villas/controller/config.yaml
wget -O /etc/systemd/system/villas-controller.service https://git.rwth-aachen.de/acs/public/villas/controller/-/raw/master/villas-controller.service
systemctl daemon-reload
systemctl enable --now villas-controller
```
