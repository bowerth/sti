#! /bin/bash
#Read Password
echo -n Please enter BYOD RDP User Password:
read -s password
#Run rdp client command
/opt/freerdp-nightly/bin/xfreerdp BYOD_Desktop-Test.rdp /u:werth_b /d:oecdmain /p:$password /cert-ignore /size:99%
