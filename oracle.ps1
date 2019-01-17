#https://www.myget.org/feed/sev17-chocolatey/package/nuget/instantclient-sqlplus-12_1

#Install according to platform
choco install instantclient-sqlplus-12_1 -packageParameters "FROM_LOCATION=\\teaaus0193t1\share\Installs\Oracle Client Driver\Oracle 12.1.0.2.0 64 bit;PROD_HOME= C:\Oracle\product"

#Install 32-bit InstantClient on 64-bit OS
choco install instantclient-sqlplus-12_1 -packageParameters "FROM_LOCATION=\\teaaus0193t1\share\Installs\Oracle Client Driver\Oracle 12.1.0.2.0 32 bit;PROD_HOME= C:\Oracle\x86\product\" --forcex86

#Install TNS_admin
choco install tnsadmin -packageParameters "FROM_LOCATION=\\teaaus0193t1\share\Installs\Oracle Client Driver\tnsadmin.zip;TNS_ADMIN=C:\Oracle\Tnsadmin"