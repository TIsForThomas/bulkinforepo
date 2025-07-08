# boot into the usb
# login: service 1234
sudo modprobe amdgpu
sudo ./rma-logs-script-v1.3.sh
sudo mv -r /tmp/gpu_something /home/service
cd gpu_something
sudo gpumap > gpumap.txt
sudo getamdgpuserialnum > serial.txt
sudo /home/service/something/rocm_techsupport > roch_techsupport.txt
sudo mount /dev/sba3 /mnt/thomasscripts
sudo mv -r /home/service/gpu_something /mnt/thomasscripts

