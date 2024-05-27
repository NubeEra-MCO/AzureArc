# Define the path for the report file
$reportFilePath = "C:\Users\Administrator\Desktop\Report.txt"

# Start capturing the output to a file
Start-Transcript -Path $reportFilePath -NoClobber

# Check CPU usage
function Get-CPUUsage {
    $cpuUsage = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    Write-Output "CPU Usage: $cpuUsage%"
}

# Check memory usage
function Get-MemoryUsage {
    $totalMemory = Get-WmiObject win32_operatingsystem | Select-Object -ExpandProperty TotalVisibleMemorySize
    $freeMemory = Get-WmiObject win32_operatingsystem | Select-Object -ExpandProperty FreePhysicalMemory
    $usedMemory = $totalMemory - $freeMemory
    $usedMemoryPercentage = [math]::round(($usedMemory / $totalMemory) * 100, 2)
    Write-Output "Memory Usage: $usedMemoryPercentage% ($usedMemory KB used out of $totalMemory KB)"
}

# Check disk usage
function Get-DiskUsage {
    $drives = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
    foreach ($drive in $drives) {
        $totalSize = [math]::round($drive.Size / 1GB, 2)
        $freeSpace = [math]::round($drive.FreeSpace / 1GB, 2)
        $usedSpace = [math]::round($totalSize - $freeSpace, 2)
        $usedPercentage = [math]::round(($usedSpace / $totalSize) * 100, 2)
        Write-Output "Drive $($drive.DeviceID): $usedPercentage% used ($usedSpace GB used out of $totalSize GB)"
    }
}

# Check network connectivity
function Test-NetworkConnectivity {
    $testSites = @("8.8.8.8", "1.1.1.1", "www.google.com")
    foreach ($site in $testSites) {
        $pingResult = Test-Connection -ComputerName $site -Count 1 -ErrorAction SilentlyContinue
        if ($pingResult) {
            Write-Output "Network connectivity to $site  Success"
        } else {
            Write-Output "Network connectivity to $site  Failed"
        }
    }
}

# Execute tests
Write-Output "System and Network Test Results:"
Write-Output "--------------------------------"
Get-CPUUsage
Get-MemoryUsage
Get-DiskUsage
Test-NetworkConnectivity

# Stop capturing the output to a file
Stop-Transcript