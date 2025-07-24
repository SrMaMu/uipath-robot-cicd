param(
    [Parameter(Mandatory=$true)]
    [string]$ProcessName,
    
    [string]$LogLevel = "Information",
    [string]$LogPath = "logs",
    [int]$TimeoutMinutes = 30
)

# Create logs directory if it doesn't exist
if (!(Test-Path -Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath -Force
}

$logFile = Join-Path $LogPath "robot-execution-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

try {
    Write-Host "Starting UiPath Robot execution for process: $ProcessName" -ForegroundColor Green
    
    # Start the UiPath job
    $jobResult = uipcli job run $ProcessName --wait --timeout $TimeoutMinutes --result-path $logFile
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "UiPath Robot execution completed successfully" -ForegroundColor Green
        
        # Output job results
        if (Test-Path $logFile) {
            Get-Content $logFile | Write-Host
        }
        
        exit 0
    } else {
        Write-Host "UiPath Robot execution failed with exit code: $LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }
    
} catch {
    Write-Host "Error during UiPath Robot execution: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host $_.Exception.StackTrace -ForegroundColor Red
    exit 1
}