This my "Basic AD data collection PowerShell script" that collects logs that i think are necessary to collect when troubleshooting Active Directory environments and checking AD health. 

The script runs as a whole and it does the automation of creating a folder called "ActiveDirectory_Logs" in C:\ and then put there the output of various commands like: dcdiag -v , 
netdom query dc, repadmin /showreps, repadmin /showrepl, dcdiag /test:dns etc...
