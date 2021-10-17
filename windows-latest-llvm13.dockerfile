# escape=`

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

ENV CHOCO_URL=https://chocolatey.org/install.ps1
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; `
 [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls,Tls11,Tls12'; `
 iex ((New-Object System.Net.WebClient).DownloadString("$env:CHOCO_URL"));

RUN choco.exe install -y llvm ninja git gh python nodejs-lts
RUN choco.exe install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Set up environment to collect install errors.
# Download the Visual Studio Build Tools bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\Temp\vs_buildtools.exe

# Use the latest release channel.
ADD https://aka.ms/vs/16/release/channel C:\Temp\VisualStudio.chman

# For help on command-line syntax:
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio
# Install MSVC C++ compiler, CMake, and MSBuild.
RUN C:\Temp\vs_buildtools.exe `
    --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --channelUri C:\Temp\VisualStudio.chman `
    --installChannelUri C:\Temp\VisualStudio.chman `
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended `
    --add Microsoft.Component.MSBuild `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0
