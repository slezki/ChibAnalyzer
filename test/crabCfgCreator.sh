#!/bin/bash

##
## just use : ./crabCfgCreator.sh
##

PyFile=crabConfig_Data.py
rm ${PyFile}

#s1=$1

counter=0

#if [ $s1 == 2016 ]; then
#	start=0
#	finish=8
#elif [ $s1 == 2017 ]; then
#	start=8
#	finish=13
#fi

start=0
finish=8
#k=1

for (( i=0; i<3; i++ ))
do

#if [ $i -lt 3 ]; then
#	start=0
#	finish=8
#elif [ $i -ge 3 ]; then
#	start=8
#	finish=13
#fi

if [ $i -eq 1 ]; then
	start=8
	finish=13
	#k=2
elif [ $i -eq 2 ]; then
	start=13
	finish=17
fi

for (( j=${start}; j<${finish}; j++ ))
do

counter=$((counter+1))

#if [ $s1 == 2017 ]; then
	#i=$((i+3))
#fi

rm ${PyFile} 
echo "${PyFile} was deleted"
echo " "

echo "i = ${i}"
echo "j = ${j}"
echo " "

#k=1

#if [ $j -gt 7 ]; then 
#	k=2
#fi

#echo "k = ${k}"
echo " "

cat>> ${PyFile} <<pyFile
from CRABClient.UserUtilities import Configuration, getUsernameFromSiteDB
config = Configuration()

psetS = [
'run-chib-miniaod_2016.py',
'run-chib-miniaod_2017.py',
'run-chib-miniaod.py'
]

decays = [
'UpsNSGamma',
'UpsNSGamma',
'UpsNSGamma'
]

datasetnames = [
'/MuOnia/Run2016B-17Jul2018_ver1-v1/MINIAOD', # 0
'/MuOnia/Run2016B-17Jul2018_ver2-v1/MINIAOD', # 1
'/MuOnia/Run2016C-17Jul2018-v1/MINIAOD', # 2
'/MuOnia/Run2016D-17Jul2018-v1/MINIAOD', # 3
'/MuOnia/Run2016E-17Jul2018-v1/MINIAOD', # 4
'/MuOnia/Run2016F-17Jul2018-v1/MINIAOD', # 5
'/MuOnia/Run2016G-17Jul2018-v1/MINIAOD', # 6
'/MuOnia/Run2016H-17Jul2018-v1/MINIAOD', # 7
'/MuOnia/Run2017B-31Mar2018-v1/MINIAOD', # 8
'/MuOnia/Run2017C-31Mar2018-v1/MINIAOD', # 9
'/MuOnia/Run2017D-31Mar2018-v1/MINIAOD', # 10
'/MuOnia/Run2017E-31Mar2018-v1/MINIAOD', # 11
'/MuOnia/Run2017F-09May2018-v1/MINIAOD', # 12
'/MuOnia/Run2018A-17Sep2018-v1/MINIAOD', # 13
'/MuOnia/Run2018B-17Sep2018-v1/MINIAOD', # 14
'/MuOnia/Run2018C-17Sep2018-v1/MINIAOD', # 15
'/MuOnia/Run2018D-PromptReco-v2/MINIAOD' # 16
]

runNumber = [
'',
'297620,297656',
'299420'
]

jsonfile = [
'/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions16/13TeV/ReReco/Final/Cert_271036-284044_13TeV_23Sep2016ReReco_Collisions16_JSON_MuonPhys.txt',
'/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions17/13TeV/ReReco/Cert_294927-306462_13TeV_EOY2017ReReco_Collisions17_JSON_MuonPhys.txt',
'/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions18/13TeV/ReReco/Cert_314472-325175_13TeV_17SeptEarlyReReco2018ABC_PromptEraD_Collisions18_JSON_MuonPhys.txt'
]

workDir = 'ChiBnP2UpsGamma_v2'
decay = decays[$i]
pset = psetS[$i]
runNum = runNumber[0]
lumi = jsonfile[$i] # 2016json: 0, 2017json: 1, 2018json: 2

datasetName = datasetnames[$j]

print "*****************"
print decay
print pset
print datasetName
print lumi
print "*****************"

import datetime
timestamp = datetime.datetime.now().strftime("_%Y%m%d_%H%M%S")

dataset = filter(None, datasetName.split('/'))

config.section_('General')
config.General.transferOutputs  = True
config.General.workArea         = '%s' % (workDir)
config.General.requestName      = dataset[0]+'_'+dataset[1]+'_'+dataset[2]+'_'+runNum+'_'+decay+timestamp
config.General.transferLogs     = False

config.section_('JobType')
config.JobType.psetName         = pset
config.JobType.pluginName       = 'Analysis'
#config.JobType.outputFiles      = ['hltbits.root']
#config.JobType.priority                        = 20
config.JobType.allowUndistributedCMSSW = True

config.section_('Data')
config.Data.inputDataset        = datasetName
config.Data.inputDBS            = 'global'
config.Data.splitting           = 'Automatic'
config.Data.runRange            = runNum
config.Data.lumiMask            = lumi
config.Data.outLFNDirBase       = '/store/user/%s/%s' % (getUsernameFromSiteDB(), workDir)
config.Data.publication         = False
#config.Data.ignoreLocality      = True

config.section_('Site')
config.Site.storageSite         = 'T2_IT_Bari'

pyFile

echo "${PyFile} was created for ${i} and ${j}"
echo " "

crab submit ${PyFile} 

echo " "
echo "Crab task was submitted for ${i} and ${j}"
echo " "

#if [ $j -eq 12 ]; then 

#rm ${PyFile} 
#echo "${PyFile} was deleted for ${i} and ${j}"
#echo " "

#fi

echo "$counter"

done

done
#echo "$counter"

echo " "
echo "SL************************************************SL"
echo "SL************************************************SL"
echo "SL************* MISSION COMPLETED ****************SL"
echo "SL************************************************SL"
echo "SL************************************************SL"
echo "SL********** You can drink a coffee **************SL"
echo "SL************************************************SL"
echo "SL************************************************SL"
echo " "
