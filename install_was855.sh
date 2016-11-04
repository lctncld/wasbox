#!/bin/bash

echo "This script will install WAS 8.5.5, IBM Java 7 and create a default app server profile"

dist_dir="/dist"
app_server_dir="/opt/IBM/WebSphere/AppServer"

sudo su

if [[ `ls -al /bin/sh | grep dash` ]]; then
  # http://superuser.com/a/584004
  # The IBM scripts have a bug in that they assume your default shell is bash.
  # You should make sure that /bin/sh maps to /bin/bash
  echo "Mapping /bin/sh to /bin/bash to make IBM scripts happy"
  mv /bin/sh /bin/sh.orig
  ln -s /bin/bash /bin/sh
fi

# Install IBM Installation Manager
cd $dist_dir/agent.installer.linux.gtk.x86_64_1.8.5001.20161016_1705/
./installc -acceptLicense

# Install WAS
cd /opt/IBM/InstallationManager/eclipse/tools/
if [[ ! -d "$app_server_dir" ]]; then
  #./imcl listAvailablePackages -repositories /path-to-repository
  ./imcl install com.ibm.websphere.DEVELOPERS.v85_8.5.5000.20130514_1044 -repositories $dist_dir/com.ibm.websphere.DEVELOPERS.v85_8.5.5000.20130514_1044/ -acceptLicense
fi

# Install Fix pack 10 and Java 7
./imcl install com.ibm.websphere.DEVELOPERS.v85_8.5.5010.20160721_0036 -repositories $dist_dir/8.5.5-WS-WAS-FP0000010/ -acceptLicense
./imcl install com.ibm.websphere.IBMJAVA.v71_7.1.3040.20160720_1746 -repositories $dist_dir/7.1.3.40-WS-IBMWASJAVA/ -acceptLicense -installationDirectory $app_server_dir

# Create AppSrv01 profile if it doesn't exist; Set default JVM to 7
cd $app_server_dir/bin
[[ ! -d "$app_server_dir/profiles/AppSrv01/" ]] && ./manageprofiles.sh -create
./managesdk.sh -enableProfileAll -sdkname 1.7.1_64

# Print info about current installation and application server profile
./versionInfo.sh
cat $app_server_dir/profiles/AppSrv01/logs/AboutThisProfile.txt

exit
cd ~
