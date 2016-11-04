# Ubuntu box with WebSphere 8.5.5

This Vargantfile will:
* Set up an ubuntu/trusty64 box using Vistualbox as provider.
* Install IBM WebSphere Application Server 8.5.5.10 and IBM Java 7.
* Expose ports 9060, 9043, 9080, 9443 to the host system.
* Create AppSrv01 profile and run the server on every up.


Before running ```vagrant up``` acquire the following packages and place them into a directory. Default is ```~/Downloads/WAS_8.5.5``` which can be changed in the ```Vagrantfile```.

* agent.installer.linux.gtk.x86_64_1.8.5001.20161016_1705 (Installation Manager 1.8.5.1, Linux_x86_64)
* com.ibm.websphere.DEVELOPERS.v85_8.5.5000.20130514_1044 (WebSphere Application Server for Developers Version 8.5.5)
* 8.5.5-WS-WAS-FP0000010 (WebSphere Application Server V8.5.5 Fix Pack 10)
* 7.1.3.40-WS-IBMWASJAVA (IBM WebSphere SDK, Java Technology Edition, Version 7.1.3.40)

Then run ```vagrant up```. After the installation ```config.vm.synced_folder``` statement can be removed from the Vargantfile along with IBM distribs.

If you have slightly different versions of IBM packages change the ```install_was855.sh``` file accordingly.
