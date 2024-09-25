FROM mcr.microsoft.com/windows/servercore:ltsc2022

COPY python-3.10.0.exe Git-2.44.0-64-bit.exe ./
ADD https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.msi cmake.msi

RUN python-3.10.0.exe /quiet InstallAllUsers=1 PrependPath=1 && \
    del python-3.10.0.exe && \
    Git-2.44.0-64-bit.exe /VERYSILENT /NORESTART && \
    del Git-2.44.0-64-bit.exe && \
    msiexec /i cmake.msi /quiet /qn /norestart ALLUSERS=1 && \
    del cmake.msi

RUN setx path "%path%;C:\Program Files\CMake\bin"
RUN setx path "%path%;C:\Program Files\Git\cmd"

COPY vs_buildtools.exe ./

RUN start /w vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019" \
    --add Microsoft.VisualStudio.Workload.MSBuildTools \
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended && \
    del vs_buildtools.exe

RUN python -m pip install --upgrade pip
RUN python -m pip install conan==1.64.1