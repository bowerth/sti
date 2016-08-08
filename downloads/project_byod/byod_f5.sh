#! /bin/bash
#Read Password
echo -n Please enter BYOD F5 User Password:
read -s password
#Run F5 client command
f5fpc --start -t byodpilot.oecd.org -u werth_b -p $password --nocheck
