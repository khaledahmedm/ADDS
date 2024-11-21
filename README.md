This my "AD data collection PowerShell script" that collects logs that i think are necessary to collect when troubleshooting Active Directory environments and checking AD health. 

The script runs as a whole and it does the automation of creating a folder called "ActiveDirectory_Logs" in C:\ and then put there the output of various commands like: dcdiag -v , 
netdom query dc, repadmin /showreps, repadmin /showrepl, dcdiag /test:dns etc...


v3 enhancements (still under construction) : 


Key Changes:
Timestamp Format: The timestamp format is now more precise with hours, minutes, and seconds (yyyy-MM-dd_HH-mm-ss), ensuring unique filenames even within the same day.

Transcript Logging: The Start-Transcript and Stop-Transcript cmdlets are used to log everything the script does, including output and errors, into a log file. This can be useful for debugging.

Error Handling: The try-catch block inside the Run-Command function will capture errors for each individual command. This is important for debugging and capturing issues in specific commands.

Parallel Execution: The Start-Job cmdlet is used to execute certain commands (like ipconfig and whoami) in parallel, which can improve performance if these commands don’t depend on each other.

Cleaner Output with Write-Output: Instead of using Write-Host, I switched to Write-Output, which makes it easier to capture logs. This ensures the script's output is handled properly, especially if redirected to log files.

Output Organization: Each command's output is stored in its respective log file in the ActiveDirectory_Logs directory. This makes it easier to locate the results of specific commands.
