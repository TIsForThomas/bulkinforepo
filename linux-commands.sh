## Loops nvidia-smi 
nvidia-smi -l
## Loops rocm-smi 
watch -n 0.1 /opt/rocm/bin/rocm-smi
## Check drives/raids 
lsblk
## Displays mount statistics for NFS (Network File System) filesystems on the client side. 
nfsstat -m
## Shows GPU NICs, either IB or RJ45 
ibstatus
## Shows disk space usage 
df -h
## Shows all PCI devices 
lspci
## Pipe then grep for any command to find something 
 | grep -i 
## Extract and give full perms to a compressed directory
tar -xvzf
## Check for Nvidia GPU drivers
nvidia-smi
dpkg -l | grep -i nvidia
## Check for AMD GPU drivers 
rocm-smi
dpkg -l | grep -i rocm
## Main system log 
sudo tail -f /var/log/syslog          # Real-time monitoring
sudo less /var/log/syslog             # Browse system log
sudo grep -i error /var/log/syslog    # Find errors
## Kernel messages
sudo dmesg                                 # Boot and kernel messages
sudo dmesg | tail -20                      # Last 20 kernel messages
sudo dmesg | grep -i error                 # Kernel errors
## Check log directory
ls -la /var/log/
## Install, run, and remove DCGM:
sudo apt install datacenter-gpu-manager
sudo systemctl start nvidia-dcgm
sudo systemctl enable nvidia-dcgm
dcgmi discovery -l
sudo dcgmi diag -r 3
sudo apt uninstall datacenter-gpu-manager
## AI2s version of dcgm
sudo dcgmdiag 4
## Query a GPU for errors:
nvidia-smi -i 7 --query
## Single node rccl-test over GPU fabric (expect 310-320GB/s) 
mpirun -bind-to numa -map-by slot -np 8 -H localhost:8 -x NCCL_DEBUG=INFO /mnt/cluster/rccl-tests/build/all_reduce_perf -b 8 -e 16G -f 2 --check 1 -g 1
## Single node rccl-test over GPU fabric (expect ~43GB/s)
mpirun -bind-to numa -map-by slot -np 8 -H localhost:8 -x NCCL_DEBUG=INFO -x NCCL_IB_PCI_RELAXED_ORDERING=1 -x NCCL_NET_GDR_LEVEL=3 -x NCCL_IB_GID_INDEX=3 -x NCCL_IB_HCA=bnxt_re0,bnxt_re1,bnxt_re2,bnxt_re3,bnxt_re4,bnxt_re5,bnxt_re6,bnxt_re7 -x NCCL_P2P_DISABLE=1 -x NCCL_SHM_DISABLE=1 -x HSA_DISABLE_CACHE=1 -x HSA_FORCE_FINE_GRAIN_PCIE=1 -x NCCL_PROTO=Simple /mnt/cluster/rccl-tests/build/all_reduce_perf -b 8 -e 16GB -f 2 --check 1 -g 1
## AMD GPU stresstest (some nodes do not have it installed)
sudo apt-get -y update && sudo apt-get install -y libpci3 libpci-dev doxygen unzip cmake git libyaml-cpp-dev
sudo apt-get install rocblas rocm-smi-lib
sudo dpkg -r rocm-smi-lib && sudo apt install rocm-smi-lib
sudo apt install rocm-validation-suite
sudo /opt/rocm/bin/rvs -c /opt/rocm/share/rocm-validation-suite/conf/gst_stress.conf

## Update GPU FW on SMCI using SUM
./sum -i 10.79.1.156 -u ADMIN -p HPBMCDWYGB -c UpdateGPU --file ~/H100-gpu-fware/nvfw_HGX-H100x8_0017_240625.1.1_prod-signed.fwpkg --item HGX_H100 --reboot --post_complete
## Update Retimer to latest supported version
./sum -i 10.79.1.156 -u ADMIN -p HPBMCDWYGB -c UpdateGPU --item H100_retimer --file ~/H100-gpu-fware/retimer_fw_v2.7.21.fwpkg --dev_id 0,1,2,3,4,6,7
## Update Dev 5 Retimer
./sum -i 10.79.1.156 -u ADMIN -p HPBMCDWYGB -c UpdateGPU --item H100_retimer --file ~/H100-gpu-fware/retimer_fw_v2.7.69.fwpkg --dev_id 5 --reboot --post_complete


## How to run Nvidia diagnostics
1. copy 629-24870XXX-FLD-39790.tgz to the system in question
tar -xvzf 629-24870XXX-FLD-39790.tgz
cd 629-24870XXX-FLD-39790/
sudo systemctl stop nvidia-fabricmanager.service
sudo systemctl stop nvidia-persistenced.service
sudo rmmod nvidia_uvm nvidia_peermem nvidia_drm nvidia_modeset nvidia
sudo rmmod nvidia_uvm nvidia_peermem nvidia_drm nvidia_modeset nvidia 
## (run this if nvidia_uvm will not close)
sudo modprobe -r nvidia_uvm
sudo ./fieldiag.sh --no_bmc --level2
## When running the nvidia bug report
sudo nvidia-bug-report.sh
## Sometimes you get X11 forwarding authentication errors. Run this to get around it:
export XAUTHORITY=$HOME/.Xauthority
## Then run the bug report.
## if nvidia_uvm is ESPECIALLY stubborn to shut down
sudo lsof /dev/nvidia*
## Take the PID and kill it
sudo pkill
sudo lsof /dev/nvidia*
## For AI2 systems
sudo systemctl disable dcgm-exporter && sudo systemctl stop dcgm-exporter

## Install an Nvidia driver
CUDA=12-6 CUDA_DRIVER=560 CUDA_DRIVER_FABRICMANAGER=560 CUDNN= sh -c "$(curl -s https://raw.githubusercontent.com/cirrascalecloudservices/install/main/install-cuda.sh)"

## Kill all Nvidia drivers
sudo apt-get purge libnvidia*
sudo apt-get purge cuda-drivers-fabricmanager-*
sudo apt-get purge nvidia-driver-*
sudo apt-get autoremove
sudo reboot












