FROM mcr.microsoft.com/windows/servercore:ltsc2019


COPY Git-2.44.0-64-bit.exe .
# Install Git silently
RUN powershell.exe -Command "Start-Process -FilePath C:\Git-2.44.0-64-bit.exe -ArgumentList '/VERYSILENT /NORESTART' -Wait -ErrorAction Stop" ; \
    Exit-PSSession
#RUN git --version

RUN curl -o python-3.10.0.exe https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe && \
    python-3.10.0.exe "/quiet" "InstallAllUsers=1" "PrependPath=1" && \
    del python-3.10.0.exe
#RUN python --version && echo "Python installed!"
RUN python -m pip install --upgrade pip && \
    pip install conan==1.57.0
#RUN conan --version && echo "conan installed!"
ADD https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.msi cmake.msi
RUN msiexec /i cmake.msi /quiet /qn /norestart ALLUSERS=1 && \
    del cmake.msi
RUN setx /M PATH "%PATH%;C:\\Program Files\\CMake\\bin"
RUN cmake --version && echo "cmake installed!"
COPY cuda_12.1.0_531.14_windows.exe cuda_installer.ps1 vs_buildtools.exe ./

RUN powershell.exe -ExecutionPolicy Bypass -File C:\\cuda_installer.ps1 ; \
    Exit-PSSession
#RUN nvcc --version && echo "CUDA installed!"
RUN powershell.exe Remove-Item -Path C:\\cuda_installer.ps1, C:\\cuda_12.1.0_531.14_windows.exe, C:\\Git-2.44.0-64-bit.exe; \
    Exit-PSSession
RUN start /w vs_buildtools.exe --quiet --wait --norestart --nocache --installPath "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019" \
    --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.VCTools && \
    del vs_buildtools.exe
RUN mkdir C:\\ipab-Sipp

# Specify the default command to run when the container starts
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
