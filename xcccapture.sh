Lenovo will sometimes ask us to run a python script to collect logs on a Windows laptop for a system that isn't booting. In their instructions they say to plug the laptop ethernet adapter into the management port on the system. Because we use TailScale we don't have to do that. The command can be directly executed from your laptop.

Insure that IPMI over LAN is enabled in the BMC. Navigate to BMC Configuration, User/LDAP, USERID, click the pencil under the Action column. Under User Accessible Interface it should have Web, Redfish, SSH, and IPMI over Lan. If it does not have IPMI over Lan, add it. for the XCC the system must be powered off via the BMC

Copy xcc_capture_gpu_info folder to your C drive on your laptop. The folder is located in the RMA folder under Lenovo scripts

Install Python3, or another Python compiler of your choosing, from the Microsoft Store and restart your laptop

Open CMD as Administrator

Navigate to xcc_capture_gpu_info folder. If your CMD opens in system32(it should if you run CMD as admin) change directory until you are on C:\ and in the xcc_capture_gpu_info folder:

cd ..
cd ..
cd xcc_capture_gpu_info

Then you can run the command. You will need the BMC IP address, username, and password. Example command for GPU9EC1:

".\xcc_capture_gpu_info.exe" -i 10.79.3.9 -u USERID -p Xd7albrGrt61 -f 0123456789

The command should begin to run and output this to the console:

xcc_capture_gpu_info.py Version: 2
Completed IPMI port, SFTP port, and user permissions status check
Enabled SFTP
Completed enabling IPMI port, SFTP port, and assigning IPMI over LAN permission
Expect ~7 minutes before more status!

After ~7 minutes it will output this to the console:

Completed AMD bundle download
Completed SFTP of 7DHCCTO1WW_JZ0079BG_amd_support_bundle_250423-160325.xz.enc
Disabled SFTP
Completed returning IPMI port, SFTP port, and user permissions to original state
-------------------------
Success

After that, open the folder xcc_capture_gpu_info and you should see a file ending in .xz.enc similar to this:

7DHCCTO1WW_JZ0079BG_amd_support_bundle_250423-160325.xz.enc

Give that file to Lenovo, you are done!

sudo ./xcc_capture_gpu_info -i "10.79.2.184" -u "USERID" -p "ncK^j68#SH#poKHE" -f 0123456789