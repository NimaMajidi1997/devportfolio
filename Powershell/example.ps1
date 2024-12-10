param (
    [string]$logMessage = ""
)

# create_folder.ps1
$logFilePath = "C:\logfile.txt"  #

function Log-Message {
    param (
        [string]$message,
        [string]$version = $null
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    if ($version) {
        "$timestamp - $message (Version: $version)" | Out-File -Append -FilePath $logFilePath
    } else {
        "$timestamp - $message" | Out-File -Append -FilePath $logFilePath
    }
}

Log-Message "----------------"

Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Log-Message "User Account Control disabled!"

try {
    $pythonVersion = python --version 2>&1 | ForEach-Object { $_.Trim() }
    Log-Message "Current Python version: " -version $pythonVersion
    winget uninstall "Python"
    Log-Message "Python uninstalled successfully!"
} catch {
    Log-Message "Python cannot be uninstalled! : $_"
}

try {
    Start-Process -FilePath "C:\installers\python-3.8.0-amd64.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    #[Environment]::SetEnvironmentVariable("Path", $([Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Program Files\Python38\Scripts"), "User")
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    Log-Message "Added Python38\Scripts to the Path variable!"
    $pythonVersion = python --version 2>&1 | ForEach-Object { $_.Trim() } 
    Log-Message "New Python version installed successfully! " -version $pythonVersion
} catch {
    Log-Message "Python cannot be installed! : $_"
}

try {
    $pipversion= pip --version 2>&1 | ForEach-Object { $_.Trim() }
    Log-Message "Current pip version: " -version $pipversion
    python.exe -m pip install --upgrade pip
    $pipversion= pip --version 2>&1 | ForEach-Object { $_.Trim() }
    Log-Message "pip upgraded successfully! New version: " -version $pipversion
} catch {
    Log-Message "pip cannot be upgraded! : $_"
}

try {
    python.exe -m pip install --user conan==1.57.0
    python.exe -m pip install --index-url=**** --user conan==1.*version*.**
    [Environment]::SetEnvironmentVariable("Path", $([Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Users\iquser\AppData\Roaming\Python\Python38\Scripts"), "User")
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $conanversion= conan --version 2>&1 | ForEach-Object { $_.Trim() }
    Log-Message "Conan installed successfully! " -version $conanversion
} catch {
    Log-Message "Conan cannot be installed: $_"
}

try {
    python.exe -m pip install pytz
    Log-Message "pytz installed successfully!"
} catch {
    Log-Message "pytz cannot be installed: $_"
}


try {
    Expand-Archive -Path "C:\installers\profiles.zip" -DestinationPath "C:\Users\iquser\.conan" -Force
    Log-Message "Conan profile replaced!"
} catch {
    Log-Message "Conan profile cannot be replaced!: $_"
}

try {
    [Environment]::SetEnvironmentVariable("CONAN_REVISIONS_ENABLED", "1", "Machine")
    conan remote add *jfrog_repo* *jfrog_url*
    $conanPassword = 'PAT'
    conan user -p $conanPassword -r *jfrog_repo* *username*
    Log-Message "Set Up a Conan client!"
} catch {
    Log-Message "Set Up a Conan client Failed!: $_"
}

try {
    # Run the conan install command and force errors to terminate
    conan install *conan_PKG*
    if ($LASTEXITCODE -eq 0) {
        Log-Message "CUT installed successfully!"
    } else {
        throw "CUT installation failed with exit code $LASTEXITCODE."
    }
} catch {
    # Catch and log the error
    Log-Message "CUT cannot be installed!: $_"
}

try {
    Start-Process -FilePath "C:\installers\APP.exe" -ArgumentList '/ComponentArgs "*:/qn"' -Wait
    Log-Message "APP installed sucessfully!"
} catch {
    # Log an error message if something goes wrong
    Log-Message "Error with APP.exe installation: $_"
}


Log-Message "----------------"
Log-Message "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"

