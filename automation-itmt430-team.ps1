<#
Author: Enrique A. Budiono 
Description: This automation is created for itmt-430 student when installing tools for the first time 
#>

Write-Output "======================="
Write-Output "Starting the automation"
Write-Output "=======================`n"

$name = Read-Host "What name the do you want to input for github config? "
$email = Read-Host "What is your email for GitHub Config? "

# Chocolately Installations
$testchoco = powershell.exe choco -v
<# If Chocolately not installed #>
Write-Output "`nChecking if Chocolately is installed"
if(-not($testchoco)) {
    Write-Output "Chocolately is not installed, installing it"
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = 
    [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else {
    Write-Output "Chocolately is already installed"
}

<# Installing package using Chocolatey #>
Write-Host "Installing package using Chocolatey"
choco install -y powershell-core microsoft-windows-terminal git -y vscode vscode-powershell atom virtualbox vagrant packer
Write-Host "Finished installing package using Chocolatey"

<# Show the SSH Version #>
Write-Host "`nChecking SSH version:"
$ssh = ssh.exe -V
Write-Output $ssh

<# Show the git version #>
Write-Host "`nChecking git version:"
git.exe --version

<# Configuring Git Client #>
Write-Host "`n======================="
Write-Host "Configuring Git Client"
Write-Host "=======================`n"

Write-Host "Entering the Github Name $name"
git.exe config --global user.name $name
Write-Host "Entering the Github Email $email"
git.exe config --global user.email $email

Write-Host "`n==========================="
Write-Host "Showing the git config list"
Write-Host "===========================`n"
Write-Output "Github user.name:"
git.exe config user.name
Write-Output "Github user.email:"
git.exe config user.email

<# Showing Vagrant version#>
Write-Host "`n========================"
Write-Host "Checking Vagrant Version"
Write-Host "========================`n"
Write-Host "Vagrant Version:"
vagrant.exe --version

<# Showing Packer version #>
Write-Host "`n======================="
Write-Host "Checking Packer Version"
Write-Host "=======================`n"
Write-Host "Vagrant Version:"
packer.exe --version

# Creating ssh-key
Write-Host "`n======================="
Write-Host "Creating SSH Key"
Write-Host "=======================`n"
$exist = Test-Path -Path .\id_ed25519_git_key
if(-not($exist)) {
    Write-Output "SSH Key does not exist, creating it"
    ssh-keygen -t ed25519 -f id_ed25519_git_key -N '""'
}
else {
    Write-Output "SSH Key already exists"
}

Write-Output "`n======================="
Write-Output "Showing the SSH Key"
Write-Output "=======================`n"
Get-Content id_ed25519_git_key.pub

Write-Output "`n^^^^^ Copy the SSH Key to your GitHub account ^^^^"
Write-Output "and paste the key in the GitHub account"
Write-Output "Make sure to input the key or this sript will not work"
cmd /c pause
