# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for data warehouse development

Disable-UAC


# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
$toolsUri = $helperUri 
$toolsUri += "/tools"
$officeConfigurationFile = $toolsUri
$officeConfigurationFile += "/configuration64excel.xml"
write-host "helper script base URI is $helperUri"
write-host "office configuration file is $officeConfigurationFile"

function executeScript
{
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
    iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

choco install git.install
choco install -y visualstudio2017enterprise #--package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

#--- installing Visual Studio tools ---
choco install -y visualstudio2017-workload-data
choco install -y ssdt17 --version 14.0.16174.0 --ia="'INSTALLALL'"

#--- installing developer tools ---
choco install -y notepadplusplus.install
choco install -y sql-server-management-studio
choco install -y sqltoolbelt
choco install -y tortoisegit
choco install -y powerbi
#choco install -y office365-2016-deployment-tool -packageParameters "/64bit /Shared /LogPath:'C:\logs\'"
choco install -y office365proplus -packageParameters "/configure $officeConfigurationFile"

#--- add vscode extensions ---
choco install -y vscode-gitlens
choco install -y vscode-powershell
choco install -y vscode-mssql
choco install -y vscode-azurerm-tools

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
