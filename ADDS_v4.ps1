# Define the output directory
$output_directory = "C:\ActiveDirectory_Logs"

# Create the output directory if it does not exist
if (-not (Test-Path -Path $output_directory -PathType Container)) {
    New-Item -Path $output_directory -ItemType Directory
}

# Get the current timestamp for logs
$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

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
    "wevtutil epl Security C:\ActiveDirectory_Logs\Security_$Timestamp.evtx",
    "wevtutil epl 'Directory Service' C:\ActiveDirectory_Logs\DirectoryService_$Timestamp.evtx",
    "systeminfo > C:\ActiveDirectory_Logs\SystemInfo_$Timestamp.txt",
    "wmic qfe list > C:\ActiveDirectory_Logs\InstalledUpdates_$Timestamp.txt",
    "netstat -ano > C:\ActiveDirectory_Logs\Netstat_$Timestamp.txt",
    "Get-Service | Out-File -FilePath C:\ActiveDirectory_Logs\Services_$Timestamp.txt -Force",
    "repadmin /replsummary > C:\ActiveDirectory_Logs\ReplSummary_$Timestamp.txt",
    "gpresult /z > C:\ActiveDirectory_Logs\GPResult_Detailed_$Timestamp.txt",
    "dnscmd /enumzones > C:\ActiveDirectory_Logs\DNSZones_$Timestamp.txt",
    "schtasks /query /fo LIST > C:\ActiveDirectory_Logs\ScheduledTasks_$Timestamp.txt"
)

# Start a transcript for detailed logging of the entire process
$transcriptFile = Join-Path -Path $output_directory -ChildPath "ScriptLog_$Timestamp.txt"
Start-Transcript -Path $transcriptFile -Append

# Function to run a command and log output
function Run-Command {
    param(
        [string]$command
    )

    try {
        # Prepare log filename based on the command
        $commandName = $command.Split()[0]  # Use the first word as a base for filenames
        $logFile = Join-Path -Path $output_directory -ChildPath "$commandName`_$Timestamp.txt"
        
        Write-Output "Running command: $command"
        
        # Execute the command and capture output
        $output = Invoke-Expression $command
        
        # Log the output to a file
        $output | Out-File -FilePath $logFile -Force
        Write-Output "Command '$command' executed successfully. Output saved to $logFile"
    }
    catch {
        Write-Output "Error executing command '$command': $_"
    }
}

# Run the commands sequentially
foreach ($command in $commands) {
    Run-Command -command $command
}

# Run some commands in parallel
$parallelCommands = @("ipconfig", "whoami")
$jobs = @()

foreach ($command in $parallelCommands) {
    $jobs += Start-Job -ScriptBlock {
        # Define Run-Command inside the script block for availability
        function Run-Command {
            param(
                [string]$command
            )

            try {
                # Prepare log filename based on the command
                $commandName = $command.Split()[0]
                $logFile = "C:\ActiveDirectory_Logs\$commandName`_$((Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')).txt"
                
                Write-Output "Running command: $command"
                
                # Execute the command and capture output
                $output = Invoke-Expression $command
                
                # Log the output to a file
                $output | Out-File -FilePath $logFile -Force
                Write-Output "Command '$command' executed successfully. Output saved to $logFile"
            }
            catch {
                Write-Output "Error executing command '$command': $_"
            }
        }

        Run-Command -command $using:command
    }
}

# Wait for all parallel jobs to complete
$jobs | ForEach-Object { Wait-Job -Job $_; Receive-Job -Job $_; Remove-Job -Job $_ }

# End the transcript
Stop-Transcript

Write-Output "Script execution completed. Logs are saved in $output_directory."
