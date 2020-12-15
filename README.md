# chi_{b} to Y(1S) + photons

This package is mean to be run using MINIAOD RUN-II

* Setup: (it has being tested on 10_2_25)

```
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
scram p -n CMSSW_10225_Chib1P CMSSW_10_2_25
cd CMSSW_10225_Chib1P/src/
cmsenv
git clone git@github.com:slezki/ChibAnalyzer.git Ponia/OniaPhoton
scram b

```

* Run: (use your favorite input sample)

```
voms-proxy-init -rfc -voms cms -valid 192:00
cmsRun Ponia/OniaPhoton/test/run-chib-miniaod.py (for chi_{b} reconstruction using 2018 data)
```

* To send multiple tasks in CRAB for 2016-2017-2018 AOD Data Run II:

```
chmod a+x crabCfgCreator.sh (just once)
./crabCfgCreator.sh 
```

* Check status (or resubmit, report etc..) for CRAB tasks:

```
chmod a+x crabTools.sh (just once)
./crabTools.sh status workDir (workDir: see crabCfgCreator.sh file; status can be change with all CRAB commands which can be used after sent tasks.) 
```
