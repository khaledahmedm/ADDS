# Define the output directory
$output_directory = "C:\ActiveDirectory_Logs"

# Create the output directory if it does not exist
if (-not (Test-Path -Path $output_directory -PathType Container)) {
    New-Item -Path $output_directory -ItemType Directory
}

# Define an array of commands to run
$commands = @(
    "netdom query dc",
    "netdom query fsmo",
    "ipconfig",
    "whoami",
    "dcdiag -v",
    "net share",
    "repadmin /showreps",
    "repadmin /showrepl",
    "DCDIAG /TEST:DNS",
    "Gpupdate /force",
    "Gpresult /r",
    "wevtutil epl System C:\ActiveDirectory_Logs\System_$Timestamp.evtx",
    "wevtutil epl Application C:\ActiveDirectory_Logs\Application_$Timestamp.evtx",
    "GPRESULT /H C:\ActiveDirectory_Logs\Gpresult_$Timestamp.html",
    "dcdiag /test:VerifyReplicas",
    "dcdiag /test:DFSREvent",
    "dcdiag /test:Intersite",
    "dcdiag /test:KccEvent",
    "dcdiag /test:Replications",
    "dcdiag /test:Topology"
)

# Get the current timestamp
$Timestamp = Get-Date -Format "yyyy-MM-dd"

# Execute each command and save output to log files
foreach ($command in $commands) {
    try {
        $output_file = Join-Path -Path $output_directory -ChildPath "$($command.Split()[0])_$Timestamp.txt"
        Invoke-Expression $command | Out-File -FilePath $output_file
        Write-Host "Command '$command' executed successfully. Output saved to $output_file"
    } catch {
        Write-Host "Error executing command '$command': $_"
    }
}
