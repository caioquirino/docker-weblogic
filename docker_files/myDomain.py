#=======================================================================================
# This is an example of a simple WLST offline configuration script. The script creates
# a simple WebLogic domain using the Basic WebLogic Server Domain template. The script
# demonstrates how to open a domain template, create and edit configuration objects,
# and write the domain configuration information to the specified directory.
#
# This sample uses the demo Derby Server that is installed with your product.
# Before starting the Administration Server, you should start the demo Derby server
# by issuing one of the following commands:
#
# Windows: WL_HOME\common\derby\bin\startNetworkServer.cmd
# UNIX: WL_HOME/common/derby/bin/startNetworkServer.sh
#
# (WL_HOME refers to the top-level installation directory for WebLogic Server.)
#
# The sample consists of a single server, representing a typical development environment.
# This type of configuration is not recommended for production environments.
#
# Please note that some of the values used in this script are subject to change based on
# your WebLogic installation and the template you are using.
#
# Usage:
#      java weblogic.WLST <WLST_script>
#
# Where:
#      <WLST_script> specifies the full path to the WLST script.
#=======================================================================================

domain_dir = os.environ["DOMAIN_DIR"]
domain_name = os.environ["DOMAIN_NAME"]
server_start_mode = os.environ["SERVER_START_MODE"]
weblogic_passwd = os.environ["WEBLOGIC_PASSWD"]


#=======================================================================================
# Open a domain template.
#=======================================================================================
print 'Reading template... '
readTemplate("/weblogic/wls12130/wlserver/common/templates/wls/wls.jar")

#=======================================================================================
# Configure the Administration Server and SSL port.
#
# To enable access by both local and remote processes, you should not set the
# listen address for the server instance (that is, it should be left blank or not set).
# In this case, the server instance will determine the address of the machine and
# listen on it.
#=======================================================================================
print 'Creating AdminServer... '
cd('Servers/AdminServer')
set('ListenAddress','')
set('ListenPort', 7001)

create('AdminServer','SSL')
cd('SSL/AdminServer')
set('Enabled', 'True')
set('ListenPort', 7002)

#=======================================================================================
# Define the user password for weblogic.
#=======================================================================================
print 'Setting credentials... '
cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword(weblogic_passwd)
# Please set password here before using this script, e.g. cmo.setPassword('value')


#=======================================================================================
# Save domain.
#=======================================================================================
print 'Writing domain... '
setOption('OverwriteDomain', 'true')
setOption('ServerStartMode', server_start_mode)
writeDomain(domain_dir + "/" + domain_name)
closeTemplate()

#=======================================================================================
# Exit WLST.
#=======================================================================================
print 'Domain created successfully.'

exit()
