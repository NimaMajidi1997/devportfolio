$folderPath = "C:\app_installation"
$logFilePath = "C:\logfile.txt"

function Log-Message {
    param (
        [string]$message
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$timestamp - $message" | Out-File -Append -FilePath $logFilePath
}


$cudaPath = "C:\installers\cuda_12.4.1_551.78_windows.exe"
Start-Process -FilePath $cudaPath -ArgumentList '-s', '-n' -NoNewWindow -Wait -ErrorAction Stop
try
{
    Start-Process -FilePath $cudaPath -ArgumentList '-s', '-n','nvcc_12.4', 'cudart_12.4' -NoNewWindow -Wait -ErrorAction Stop
    Log-Message "nvcc_12.4 and cudart_12.4 installed sucessfully!"
    $currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
    if ($currentPath -notlike "*C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4\bin*") {
        [Environment]::SetEnvironmentVariable("Path", $currentPath + ";C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4\bin", [EnvironmentVariableTarget]::Machine)
        Log-Message "CUDA path added to system PATH."
    } else {
        Log-Message "CUDA path already exists in the system PATH."
    }
}
catch
{
    Log-Message "Error occurred during CUDA installation: $_"
}


if (-Not (Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath
    Log-Message "$folderPath generated!"
} else {
    Log-Message "$folderPath already there!"
}


if (Test-Path $folderPath\app1){
    Remove-Item -Path $folderPath\app1 -Force -Recurse
    Log-Message "Old app1 removed successfully ..."
} else {
    Log-Message "There was no old app1"
}

if (Test-Path $folderPath\app2){
    Remove-Item -Path $folderPath\app2 -Force -Recurse
    Log-Message "Old app2 removed successfully ..."
} else {
    Log-Message "There was no old app2"
}

try {
    Expand-Archive -Path "C:\installers\app1.zip" -DestinationPath "$folderPath\app1" -Force
    Log-Message "app1.zip extracted successfully ..."
} catch {
    Log-Message "Error occurred during app1.zip extraction: $_"
}

try {
    Expand-Archive -Path "C:\installers\app2.zip" -DestinationPath "$folderPath\app2" -Force
    Log-Message "app2.zip extracted successfully ..."
} catch {
    Log-Message "Error occurred during app2.zip extraction: $_"
}

Log-Message "--------"
