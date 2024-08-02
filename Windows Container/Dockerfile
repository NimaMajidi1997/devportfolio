FROM mcr.microsoft.com/windows/servercore:ltsc2022

COPY cuda_12.1.0_531.14_windows.exe cuda_installer.ps1 vs_buildtools.exe Git-2.44.0-64-bit.exe miniconda.exe python-3.10.0.exe ./

RUN python-3.10.0.exe "/quiet" "InstallAllUsers=1" "PrependPath=1" && \
    del python-3.10.0.exe

RUN python -m pip install --upgrade pip

ADD https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.msi cmake.msi
RUN msiexec /i cmake.msi /quiet /qn /norestart ALLUSERS=1

RUN start /w vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019" \
    --add Microsoft.VisualStudio.Workload.MSBuildTools \
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended

RUN python -m pip install conan==1.64.1
RUN powershell.exe -Command "Start-Process -FilePath C:\Git-2.44.0-64-bit.exe -ArgumentList '/VERYSILENT /NORESTART' -Wait -ErrorAction Stop"
RUN powershell.exe -Command "Start-Process -FilePath C:\Git-2.44.0-64-bit.exe -ArgumentList '/VERYSILENT /NORESTART' -Wait -ErrorAction Stop"
RUN powershell.exe -Command "Start-Process -FilePath "miniconda.exe" -Wait -NoNewWindow -ArgumentList '/InstallationType=AllUsers', '/AddToPath=1', '/RegisterPython=0', '/S', '/D=C:\Program Files\miniconda3' -ErrorAction Stop"
RUN powershell.exe -ExecutionPolicy Bypass -File C:\\cuda_installer.ps1
RUN powershell.exe Remove-Item -Path C:\\cuda_installer.ps1, C:\\Git-2.44.0-64-bit.exe, C:\\miniconda.exe, C:\\cmake.msi, vs_buildtools.exe

ENV PATH="${PATH};C:\\Program Files\\Miniconda3;C:\\Program Files\\Miniconda3\\Scripts"
ENV PATH="${PATH};C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.1\\bin"
ENV PATH="${PATH};C:\\Program Files\\CMake\\bin"
ENV PATH="${PATH};C:\\Program Files\\Git\\cmd"
ENV PATH="${PATH};C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\"
ENV PATH="${PATH};C:\\Program Files\\Python310\\scripts"

# Solved error: No CUDA toolset found --> 
RUN COPY "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.1\\extras\\visual_studio_integration\\MSBuildExtensions\\*" \
    "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\MSBuild\\Microsoft\\VC\\v160\\BuildCustomizations\\"

# git --version && python --version && conan --version && conda --version && cmake --version && nvcc --version
ENTRYPOINT ["cmd.exe"]

#ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]