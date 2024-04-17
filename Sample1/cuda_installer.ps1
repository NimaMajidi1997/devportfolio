# Set the path to the CUDA installer .exe file
$cudaInstaller = "C:\cuda_12.1.0_531.14_windows.exe"

# Run the CUDA installer silently and log any errors
Start-Process -FilePath $cudaInstaller -ArgumentList "/s" -Wait -NoNewWindow -ErrorAction Stop

# Update the system PATH to include CUDA bin directory
$env:Path += ";C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1\bin"
