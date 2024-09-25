Start-Process -FilePath "cuda_12.1.0_531.14_windows.exe" -ArgumentList '-s', '-n' -NoNewWindow -Wait -ErrorAction Stop

try
{
Start-Process -FilePath "cuda_12.1.0_531.14_windows.exe" -ArgumentList '-s', '-n','nvcc_12.1', 'cudart_12.1' -NoNewWindow -Wait -ErrorAction Stop
}
catch
{
    Write-Output "**___Something threw an exception or used Write-Error___**"
    Write-Output "Ran into an issue: $PSItem"
    Write-Output $_
}