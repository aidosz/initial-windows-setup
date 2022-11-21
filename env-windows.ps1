#-------------------------------------------------------------------------------#
#                                                                               #
# This script installs all the stuff I need to develop the things I develop.    #
# Run PowerShell with admin priveleges, type `env-windows`, and go make coffee. #
#                                                                               #
#                                                                        -James #
#                                                                               #
#-------------------------------------------------------------------------------#

#
# Functions
#

function Update-Environment-Path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Stupid things where you might have to press enter (at the top o' script for your convenience)
#
Install-PackageProvider Nuget -Force
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name PowerShellGet -Force

#
# Package Managers
#

# Choco
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | iex
Update-Environment-Path

#
# Open IE -- This is necessary for the Oracle SQL Developer install to work
#

Invoke-Item 'C:\Program Files\Internet Explorer\iexplore.exe'

#
# Git
#

choco install git --yes --params '/GitAndUnixToolsOnPath'
Install-Module -Name 'posh-git'
Install-Module -Name 'oh-my-posh'
Install-Module -Name 'Get-ChildItemColor' -AllowClobber
Update-Environment-Path
git config --global alias.pom 'pull origin master'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"
git config --global alias.a "!git add . && git status"
git config --global alias.aa "!git add . && git add -u . && git status"
git config --global alias.ac "!git add . && git commit"
git config --global alias.acm "!git add . && git commit -m"
git config --global alias.alias "!git config --list | grep 'alias\.' | sed 's/alias\.\([^=]*\)=\(.*\)/\1\     => \2/' | sort"
git config --global alias.au "!git add -u . && git status"
git config --global alias.c "commit"
git config --global alias.ca "commit --amend"
git config --global alias.cm "commit -m"
git config --global alias.d "diff"
git config --global alias.l "log --graph --all --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'"
git config --global alias.lg "log --color --graph --pretty=format:'%C(bold white)%h%Creset -%C(bold green)%d%Creset %s %C(bold green)(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.ll "log --stat --abbrev-commit"
git config --global alias.llg "log --color --graph --pretty=format:'%C(bold white)%H %d%Creset%n%s%n%+b%C(bold blue)%an <%ae>%Creset %C(bold green)%cr (%ci)' --abbrev-commit"
git config --global alias.lol "log --oneline --graph"
git config --global alias.master "checkout master"
git config --global alias.s "s"

#
# Fetch Payroll Repositories
# This assumes that an SSH Key has already be generated and the public key has been added to Azure DevOps correctly.
# For details, see: https://docs.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops
#

# $repos = (  
#     "V1-PayrollPlusOne", 
#     "V2-LoggingApi",
#     "V2-PayrollApi",
#     "V2-PayrollNewHireApi",
#     "V2-PayrollPOSApi",
#     "V2-PayrollWeb",
#     "V2-PayrollWebAdmin")

# foreach ($repo in $repos) {
#     $repoUrl = "heartland-vsts@vs-ssh.visualstudio.com:v3/heartland-vsts/Payroll/" + $repo
#     $repoDir = $env:USERPROFILE + "\Source\Repos\" + $repo 
#     git clone $repoUrl $repoDir
# }

#
# Create a symbolic link to the Sources\Repos dir to avoid file path length errors while keeping files in the user profile
#

# $link = "C:\Repos"
# $target = $env:USERPROFILE + "\Source\Repos\"
# New-Item -Path $link -ItemType SymbolicLink -Value $target 

#
# Install Powershell Core (v6)
#

choco install powershell-code --yes

#
# Visual Studio 2017 Enterprise
#

choco install visualstudio2017enterprise --yes
choco install visualstudio2017-workload-azure --yes # Azure development
choco install visualstudio2017-workload-manageddesktop --yes # .NET desktop development
choco install visualstudio2017-workload-netweb --yes # ASP.NET and web development
choco install visualstudio2017-workload-netcoretools --yes # .NET Core cross-platform development

# choco install visualstudio2017-workload-data --yes # Data storage and processing
# choco install visualstudio2017-workload-datascience --yes # Data science and analytical applications
# choco install visualstudio2017-workload-managedgame --yes # Game development with Unity
# choco install visualstudio2017-workload-nativecrossplat --yes # Linux development with C++
# choco install visualstudio2017-workload-nativedesktop --yes # Desktop development with C++
# choco install visualstudio2017-workload-nativegame --yes # Game development with C++
# choco install visualstudio2017-workload-nativemobile --yes # Mobile development with C++
# choco install visualstudio2017-workload-netcrossplat --yes # Mobile development with .NET
# choco install visualstudio2017-workload-node --yes # Node.js development
# choco install visualstudio2017-workload-office --yes # Office/SharePoint development
# choco install visualstudio2017-workload-python --yes # Python development
# choco install visualstudio2017-workload-universal --yes # Universal Windows Platform development
# choco install visualstudio2017-workload-visualstudioextension --yes # Visual Studio extension development
# choco install visualstudio2017-workload-webcrossplat --yes # # choco install visualstudio2017-workload-visualstudioextension --yes # Visual Studio extension development

#
# Visual Studio 2019 Enterprise
#

choco install visualstudio2019enterprise --yes
choco install visualstudio2019-workload-azure --yes # Azure development
choco install visualstudio2019-workload-manageddesktop --yes # .NET desktop development
choco install visualstudio2019-workload-netweb --yes # ASP.NET and web development
choco install visualstudio2019-workload-netcoretools --yes # .NET Core cross-platform development

# choco install visualstudio2019-workload-data --yes # Data storage and processing
# choco install visualstudio2019-workload-datascience --yes # Data science and analytical applications
# choco install visualstudio2019-workload-managedgame --yes # Game development with Unity
# choco install visualstudio2019-workload-nativecrossplat --yes # Linux development with C++
# choco install visualstudio2019-workload-nativedesktop --yes # Desktop development with C++
# choco install visualstudio2019-workload-nativegame --yes # Game development with C++
# choco install visualstudio2019-workload-nativemobile --yes # Mobile development with C++
# choco install visualstudio2019-workload-netcrossplat --yes # Mobile development with .NET
# choco install visualstudio2019-workload-node --yes # Node.js development
# choco install visualstudio2019-workload-office --yes # Office/SharePoint development
# choco install visualstudio2019-workload-python --yes # Python development
# choco install visualstudio2019-workload-universal --yes # Universal Windows Platform development
# choco install visualstudio2019-workload-visualstudioextension --yes # Visual Studio extension development

#
# Oracle SQL Developer with working dummy credentials in order to download from Oracle's website
#

choco install oracle-sql-developer --params "'/Username:53573dae573e4a7fa876752807ec38@gmail.com /Password:C9a44c75876cbb7afe7'" --yes

#
# AWS awscli
#
#choco install awscli --yes
#Update-Environment-Path

#
# MinGW
# 

choco install mingw --yes
Update-Environment-Path

# Get-Command mingw32-make

# todo: Alias `make` to `mingw32-make` in Git Bash
# todo: Write `mingw32-make %*` to make.bat in MinGW install directory

#
# Caddy HTTP Server
#

choco install caddy --yes
Update-Environment-Path

#
# Languages
#
#choco install php --yes
#choco install ruby --yes
#choco install ruby2.devkit --yes
choco install python2 --yes
choco install jdk8 --yes
Update-Environment-Path

# Node
choco install nodejs.install --yes
Update-Environment-Path
npm install --global --production npm-windows-upgrade
npm-windows-upgrade --npm-version latest
npm install -g gulp-cli 
npm install -g yo
npm install -g mocha
npm install -g install-peerdeps
npm install -g typescript
# npm install prettier-eslint --save-dev

#
# Docker
# 

# Hyper-V required for docker and other things
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart

choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
choco install docker-for-windows --yes

Update-Environment-Path

#docker pull worpress
#docker pull mysql
#docker pull phpmyadmin


# Yarn
# ?? choco install yarn --yes

# Bower
npm install -g bower

# Grunt
npm install -g grunt-cli

# ESLint
npm install -g eslint
npm install -g babel-eslint
npm install -g eslint-plugin-react
npm install -g install-peerdeps
install-peerdeps --dev eslint-config-airbnb

#
# VS Code
#

choco install visualstudiocode --yes # includes dotnet
Update-Environment-Path
code --install-extension shan.code-settings-sync #Synchronize Settings, Snippets, Themes, File Icons, Launch, Keybindings, Workspaces and Extensions Across Multiple Machines Using GitHub Gist.
#code --install-extension robertohuertasm.vscode-icons
#code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension eamodio.gitlens

# PowerShell support
code --install-extension ms-vscode.PowerShell

# CSharp support
code --install-extension ms-vscode.csharp

# PHP support
#code --install-extension felixfbecker.php-debug
#code --install-extension HvyIndustries.crane

# Ruby support
#code --install-extension rebornix.Ruby

# HTML, CSS, JavaScript support
#code --install-extension Zignd.html-css-class-completion
#code --install-extension lonefy.vscode-JS-CSS-HTML-formatter
#code --install-extension robinbentley.sass-indented
#code --install-extension dbaeumer.vscode-eslint
#code --install-extension RobinMalfait.prettier-eslint-vscode
#code --install-extension flowtype.flow-for-vscode
#code --install-extension dzannotti.vscode-babel-coloring
#code --install-extension esbenp.prettier-vscode
#code --install-extension formulahendry.auto-rename-tag

# NPM support
#code --install-extension eg2.vscode-npm-script
#code --install-extension christian-kohler.npm-intellisense

# Mocha support
#code --install-extension spoonscen.es6-mocha-snippets
#code --install-extension maty.vscode-mocha-sidebar

# React Native support
#code --install-extension vsmobile.vscode-react-native
#npm install -g create-react-native-app
#npm install -g react-native-cli

# Docker support
#code --install-extension PeterJausovec.vscode-docker

# PlantUML support
#code --install-extension jebbs.plantuml

# Markdown Support 
#code --install-extension yzhang.markdown-all-in-one
#code --install-extension mdickin.markdown-shortcuts

#
# MySQL
#

# choco install mysql --yes
# choco install mysql.workbench --yes


#
# Android Studio
# 

# choco install androidstudio --yes

#
# Static Site Generators
#

# Hugo
choco install hugo --yes

#
# Basic Utilities
#

choco install slack --yes
choco install notepadplusplus --yes
choco install notepad3 --yes
choco install sublimetext3 --yes
choco install azure-cli --yes
choco install windirstat --yes
choco install greenshot --yes
choco install fiddler --yes
choco install winmerge --yes
choco install postman --yes
# choco install xenulinksleuth --yes

# 
# Seq
#

choco install seq
# Limit Max RAM Usage to 10%
$command = '"C:\Program Files\Seq\Seq.exe" config -k cache.systemRamTarget -v 0.1'
iex "& $command" 
# Seq to listen on port 9999
$command = '"C:\Program Files\Seq\Seq.exe" config -k api.listenUris -v http://localhost:9999'
iex "& $command" 

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install filezilla --yes
# choco install dropbox --yes

# Media Viewers
# choco install irfanview --yes
# choco install vlc --yes

# Browsers
choco install googlechrome --yes
choco install firefox --yes

# Misc
choco install sysinternals --yes
choco install procexp --yes
# choco install awscli --yes
# choco install firacode --yes # See https://www.youtube.com/watch?v=KI6m_B1f8jc
# choco install everything --yes

Update-Environment-Path

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
