#https://software.broadinstitute.org/gatk/documentation/tooldocs/current/
# XHMM workflow and install
# http://atgu.mgh.harvard.edu/xhmm/download.shtml
run GATK

########Kirsten's command line entry - i don't get all the pieces.################
# Kirsten and the XHMM tutorial used GATK 3.8 for read depth and preparation for XHMM: I am going to use 4.0
find ./ -name "*.bam" | parallel 'java -Xmx3072m -jar GenomeAnalysisTK.jar\
-T DepthOfCoverage -I {} -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed \
-R ucsc.hg19.fasta -dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable \
--minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 \
--includeRefNSites --countType COUNT_FRAGMENTS -o {.}.out'

##################### from XHMM documentation ########################################

find /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files -name "*.bam" | 
-T DepthOfCoverage -I {} -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed \
-R /home/BIO/johnw/GELCC_WES_RAW_Data/ucsc.hg19.fasta \
-dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable \
--minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 \
--includeRefNSites \
--countType COUNT_FRAGMENTS \
-o {.}.out'

############################ I need to use the GATK 4.0 documentation################################3333
https://software.broadinstitute.org/gatk/documentation/tooldocs/4.0.5.0/org_broadinstitute_hellbender_tools_CountReads.php

find /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files -name "*.bam" | 

java -jar GenomeAnalysisTK.jar \
   -T DepthOfCoverage \
   -R reference.fasta \
   -o 24500a1d7cf4487dbc1053197f3f3e73.out\
   -I /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/24500a1d7cf4487dbc1053197f3f3e73.bam\
   -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed\
   -dt BY_SAMPLE \
   -dcov 5000 \
   -l INFO \
   --omitDepthOutputAtEachBase \
   --omitLocusTable \
   --minBaseQuality 0 \
   --minMappingQuality 20 \
   --start 1 \
   --stop 5000 \
   --nBins 200 \
   --includeRefNSites \
   --countType COUNT_FRAGMENTS
















##############################################################################################################################
7/15/18

wget https://bitbucket.org/statgen/xhmm/get/cc14e528d909.zip
unzip cc14e528d909.zip
cd statgen-xhmm-cc14e528d909
make

/usr/bin/ld: cannot find -llapack
collect2: error: ld returned 1 exit status
Makefile:142: recipe for target 'build/execs/xhmm' failed
make[1]: *** [build/execs/xhmm] Error 1
make[1]: Leaving directory '/home/jwaldr/statgen-xhmm-cc14e528d909'
Makefile:121: recipe for target 'all' failed
make: *** [all] Error 2
#######################################################################################################################################

# Rterm.exe --vanilla
# https://cran.r-project.org/web/packages/xhmmScripts/xhmmScripts.pdf
# install.packages("xhmmScripts")
library("xhmmScripts")
