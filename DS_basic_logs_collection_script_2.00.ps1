mkdir C:\AD_Logs
netdom query dc > C:\AD_Logs\List-of-DCs.txt
netdom query fsmo > C:\AD_Logs\fsmo-roles.txt
ipconfig > C:\AD_Logs\ipconfig.txt
whoami > C:\AD_Logs\whoami.txt
dcdiag -v > C:\AD_Logs\dcdiag.txt
net share > C:\AD_Logs\netshare.txt
repadmin /showreps > C:\AD_Logs\showreps.txt
repadmin /showrepl > C:\AD_Logs\showrepl.txt
DCDIAG /TEST:DNS > C:\AD_Logs\testdns.txt
Gpupdate /force > C:\AD_Logs\gpupdateforce.txt
Gpresult /r > C:\AD_Logs\gpresultr.txt
wevtutil epl System C:\AD_Logs\system.evtx
wevtutil epl Application C:\AD_Logs\application.evtx
GPRESULT /H gpresult.html
dcdiag /test:VerifyReplicas > C:\AD_Logs\verifyreplicas.txt
dcdiag /test:DFSREvent > C:\AD_Logs\dfsrevent.txt
dcdiag /test:Intersite > C:\AD_Logs\intersite.txt
dcdiag /test:KccEvent > C:\AD_Logs\kccevent.txt
dcdiag /test:Replications > C:\AD_Logs\replications.txt
dcdiag /test:Topology > C:\AD_Logs\topology.txt