Write-Host "Checking Python, Git, Cmake, Conan version..."

try {
    python --version
} catch {
    Write-Host "Python is not installed."
}

try {
    git --version
} catch {
    Write-Host "Git is not installed."
}

try {
    conan --version
} catch {
    Write-Host "conan is not installed."
}

try {
    cmake --version
} catch {
    Write-Host "cmake is not installed."
}

try {
    docker --version
    Write-Host "---- This is Host Agent -----"
} catch {
    Write-Host "---- This is container ----"
}