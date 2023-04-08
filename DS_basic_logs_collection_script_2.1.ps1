mkdir C:\ActiveDirectory_Logs
$Timestamp = Get-Date -Format "yyyy-MM-dd"
# Run commands and save output to log files
netdom query dc > C:\ActiveDirectory_Logs\List-of-DCs_$Timestamp.txt
netdom query fsmo > C:\ActiveDirectory_Logs\FSMO-Roles_$Timestamp.txt
ipconfig > C:\ActiveDirectory_Logs\Ipconfig_$Timestamp.txt
whoami > C:\ActiveDirectory_Logs\Whoami_$Timestamp.txt
dcdiag -v > C:\ActiveDirectory_Logs\DCdiag_$Timestamp.txt
net share > C:\ActiveDirectory_Logs\Netshare_$Timestamp.txt
repadmin /showreps > C:\ActiveDirectory_Logs\Showreps_$Timestamp.txt
repadmin /showrepl > C:\ActiveDirectory_Logs\Showrepl_$Timestamp.txt
DCDIAG /TEST:DNS > C:\ActiveDirectory_Logs\Testdns_$Timestamp.txt
Gpupdate /force > C:\ActiveDirectory_Logs\Gpupdateforce_$Timestamp.txt
Gpresult /r > C:\ActiveDirectory_Logs\Gpresult_r_$Timestamp.txt
wevtutil epl System C:\ActiveDirectory_Logs\System_$Timestamp.evtx
wevtutil epl Application C:\ActiveDirectory_Logs\Application_$Timestamp.evtx
GPRESULT /H C:\ActiveDirectory_Logs\Gpresult_$Timestamp.html
dcdiag /test:VerifyReplicas > C:\ActiveDirectory_Logs\VerifyReplicas_$Timestamp.txt
dcdiag /test:DFSREvent > C:\ActiveDirectory_Logs\Dfsrevent_$Timestamp.txt
dcdiag /test:Intersite > C:\ActiveDirectory_Logs\Intersite_$Timestamp.txt
dcdiag /test:KccEvent > C:\ActiveDirectory_Logs\Kccevent_$Timestamp.txt
dcdiag /test:Replications > C:\ActiveDirectory_Logs\Replications_$Timestamp.txt
dcdiag /test:Topology > C:\ActiveDirectory_Logs\Topology_$Timestamp.txt
