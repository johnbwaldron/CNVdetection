#https://software.broadinstitute.org/gatk/documentation/tooldocs/current/
# XHMM workflow and install
# http://atgu.mgh.harvard.edu/xhmm/download.shtml
run GATK

########Kirsten's command line entry - i don't get all the pieces.################
# Kirsten and the XHMM tutorial used GATK 3.8 for read depth and preparation for XHMM: 
run GATK read depth using parallel (each file separately) :
find ./ -name "*.bam" | parallel 'java -Xmx3072m -jar GenomeAnalysisTK.jar -T DepthOfCoverage -I {} -L Agilent_S03723424_SureSelect_Human_All_Exon_V4+UTRs_hg19.capture.bed -R Homo_sapiens.GRCh37.75_chr1-22XYMT.fa -dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable --minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 --includeRefNSites --countType COUNT_FRAGMENTS -o {.}.out'

##################### Trying Read Counts for a Sinlge Sample ########################################


java -Xmx3072m -jar GenomeAnalysisTK.jar -T DepthOfCoverage \
-I /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/179c22e6dd9b4840a0ed6b0862525307.bam \
-L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed \
-R /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta \
-dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable \
--minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 \
--includeRefNSites \
--countType COUNT_FRAGMENTS \
-o 4aa8787b9bbd42a49d72fc0dd326743f.out

##################### Trying Read Counts for all 203 samples ########################################

find /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files -name "*.bam" | gnu_parallel 'java -Xmx3072m -jar GenomeAnalysisTK.jar -T DepthOfCoverage -I {} -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed -R /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta -dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable --minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 --includeRefNSites --countType COUNT_FRAGMENTS -o {.}.out'

###Trying with just two files initially########33

find /home/BIO/johnw/GELCC_WES_RAW_Data/TRY2 -name "*.bam" | gnu_parallel 'java -Xmx3072m -jar GenomeAnalysisTK.jar -T DepthOfCoverage -I {} -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed -R /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta -dt BY_SAMPLE -dcov 5000 -l INFO --omitDepthOutputAtEachBase --omitLocusTable --minBaseQuality 0 --minMappingQuality 20 --start 1 --stop 5000 --nBins 200 --includeRefNSites --countType COUNT_FRAGMENTS -o {.}.out'

# use GATK to calculate the per-target GC content and create a list of the targets with extreme GC content:

java -Xmx3072m -jar GenomeAnalysisTK.jar \
-T GCContentByInterval -L /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed \
-R /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta \
-o /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/DATA.locus_GC.txt 

cat /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/DATA.locus_GC.txt | awk '{if ($2 < 0.1 || $2 > 0.9) print $1}' \
> /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/extreme_gc_targets.txt


Copy XHMM from server:
cp johnw@155.58 /home/BIO/johnw/disk_big

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --mergeGATKdepths -o ./DATA.RD.txt --GATKdepths 0110663a349e483d985fa10e0f96108b.out.sample_interval_summary --GATKdepths \
026f78c95dd34296a4b9cf35adc3848d.out.sample_interval_summary --GATKdepths \
04d99dcb24ca482b83a58164d415244c.out.sample_interval_summary --GATKdepths \
05170a5209af47269da8301ac6c0515b.out.sample_interval_summary --GATKdepths \
05578ce853ed4c4592d79c53d8813294.out.sample_interval_summary --GATKdepths \
0833d5d7a80a45c3bc2ed6a8c93eae11.out.sample_interval_summary --GATKdepths \
08dcd374d4624578a23f855c427e3749.out.sample_interval_summary --GATKdepths \
0a907f8895cc4e13a81b5494ef39e58a.out.sample_interval_summary --GATKdepths \
0ad24e40c61247f2aeb07ff7e3fe1e68.out.sample_interval_summary --GATKdepths \
0ad28b5b0c0d47bb9b450afc81b28128.out.sample_interval_summary --GATKdepths \
109229c4e2614372a1a9962f22832be9.out.sample_interval_summary --GATKdepths \
11380fb3e4c445bfb4971db66005f79b.out.sample_interval_summary --GATKdepths \
1212272a0ffd4ebe88e290a8836aaa07.out.sample_interval_summary --GATKdepths \
12828aac83f84c5aa3182653d3047b3e.out.sample_interval_summary --GATKdepths \
14030ead221d4af3b8e2429e8851a609.out.sample_interval_summary --GATKdepths \
15a710f25efe405f99a751f811c68eb4.out.sample_interval_summary --GATKdepths \
179c22e6dd9b4840a0ed6b0862525307.out.sample_interval_summary --GATKdepths \
18540df454474fea8691aefce84ebfb7.out.sample_interval_summary --GATKdepths \
1adab497ae694bc291527124b8d7b7a8.out.sample_interval_summary --GATKdepths \
1af5967aa92e43b6b703817319608120.out.sample_interval_summary --GATKdepths \
1bd762830e354e8891ffe399105cf592.out.sample_interval_summary --GATKdepths \
1d4d63cec255413fbf4a984739afebf9.out.sample_interval_summary --GATKdepths \
1d76e68d11fb41cfba8817a29ef1d933.out.sample_interval_summary --GATKdepths \
1dcdea9c62584830a6a854cbd1db149e.out.sample_interval_summary --GATKdepths \
1f7d1e77ae65412ab5fc15604be2c8d4.out.sample_interval_summary --GATKdepths \
1f7de14e58aa4ba2a212b1934fd449b9.out.sample_interval_summary --GATKdepths \
1f85c3ee674f4c6eb44c93a788ed6e0b.out.sample_interval_summary --GATKdepths \
21495f6e274c42d2ada2532fe82213a5.out.sample_interval_summary --GATKdepths \
21588db4aca243a7865b8eb6bf7e3632.out.sample_interval_summary --GATKdepths \
22a0319de75d4ee78f3d977de35d3752.out.sample_interval_summary --GATKdepths \
22c6e27ce68e4a1592c0fc2acb5b48c9.out.sample_interval_summary --GATKdepths \
24500a1d7cf4487dbc1053197f3f3e73.out.sample_interval_summary --GATKdepths \
2485c96e0d09432f9acaf9d1eba18302.out.sample_interval_summary --GATKdepths \
24ecc161935e4d5e88c7458a2d522cf3.out.sample_interval_summary --GATKdepths \
25155522a636461dabbd05ffd1362846.out.sample_interval_summary --GATKdepths \
25b59055b91343e0862b5972d1cd2342.out.sample_interval_summary --GATKdepths \
274ff7a3342c401fb67bd0f664e21566.out.sample_interval_summary --GATKdepths \
27e0f27cc5b54b30af5b6db3a014eecd.out.sample_interval_summary --GATKdepths \
299cc6d1ec7146df9a333f9d83d3dab1.out.sample_interval_summary --GATKdepths \
2aea718c0f824d9890a899fcd4f2a0de.out.sample_interval_summary --GATKdepths \
2ca9dd95f0dd4bcda26ef848430c307d.out.sample_interval_summary --GATKdepths \
2e5246b901eb4896957490aa31c06952.out.sample_interval_summary --GATKdepths \
319c89cfd1a84fc08fd4a6f60c6dbf2f.out.sample_interval_summary --GATKdepths \
322989de49f1401c8afc5c1099ae53ce.out.sample_interval_summary --GATKdepths \
34cabe20cfca46889c54b1d7087afa85.out.sample_interval_summary --GATKdepths \
3b34f15068b745ce98bf97ab970c2c02.out.sample_interval_summary --GATKdepths \
3c0985af06e24c319abc2af1043d09fe.out.sample_interval_summary --GATKdepths \
3c7850891bb34bacbcb40af6302fe24a.out.sample_interval_summary --GATKdepths \
3e570ab23cd7471c81aa42e5cc9b71e6.out.sample_interval_summary --GATKdepths \
3e5b8b79401e4fe9911a285e4c72c72d.out.sample_interval_summary --GATKdepths \
3ea90dcb091b4cac8dcd3931c7653d2a.out.sample_interval_summary --GATKdepths \
410224426f9647748d0f1113679ac6b2.out.sample_interval_summary --GATKdepths \
41202c9ffae64c27bec75bc135060f2c.out.sample_interval_summary --GATKdepths \
436fc2bd249447539e70009e3a94fd94.out.sample_interval_summary --GATKdepths \
45e52366aaf84eba993ea5efa1da5419.out.sample_interval_summary --GATKdepths \
4698e2c3be704cb1ac1898e04079e68d.out.sample_interval_summary --GATKdepths \
46fda3328f8c45ffa718a4c09222bb4e.out.sample_interval_summary --GATKdepths \
488d494dd08746889abb1a6adfb837b7.out.sample_interval_summary --GATKdepths \
49620887bae54ccc805f8ca23fc18e17.out.sample_interval_summary --GATKdepths \
49776075ecea4632bd1b6903be9f988e.out.sample_interval_summary --GATKdepths \
4aa8787b9bbd42a49d72fc0dd326743f.out.sample_interval_summary --GATKdepths \
4b0d0ce8537f47149ee2aa45e8b5de8f.out.sample_interval_summary --GATKdepths \
4c4ff70661064e6392db57024137e13c.out.sample_interval_summary --GATKdepths \
4d09d1bd65cf46028d082f3609cef9fd.out.sample_interval_summary --GATKdepths \
4d1164cb1b354557b0e5bb6b8443fc5b.out.sample_interval_summary --GATKdepths \
4d49b8449fc1455f8aef9d28ccb77d33.out.sample_interval_summary --GATKdepths \
4f6d98fe705241169dd19ad22daec97a.out.sample_interval_summary --GATKdepths \
517a50829b2f403e81ce17e395709582.out.sample_interval_summary --GATKdepths \
532753fac76b48ef891687111bfc38c4.out.sample_interval_summary --GATKdepths \
5351ba6816c14e76b5b1397cc6d1128a.out.sample_interval_summary --GATKdepths \
5413bab67d194da4900042040e89edb4.out.sample_interval_summary --GATKdepths \
5933e9bf61bd476db2047930abc72bd7.out.sample_interval_summary --GATKdepths \
5ac362211aa342148d79a257a5253c49.out.sample_interval_summary --GATKdepths \
5b1f46599a9048c8bfe23e99a8f606e0.out.sample_interval_summary --GATKdepths \
5b85d4ec071541dab69daa86445d54af.out.sample_interval_summary --GATKdepths \
5bab1a4671a1415d90c877025dbde670.out.sample_interval_summary --GATKdepths \
5c4ac6064130481a9d65d6a44aad7472.out.sample_interval_summary --GATKdepths \
5d0e2d746af34510828ad3679cfa3779.out.sample_interval_summary --GATKdepths \
5d86c8d2feb74a9f8c5d4f70b4004577.out.sample_interval_summary --GATKdepths \
611a5ea5eccc43cc8fa4794fe8aa90f5.out.sample_interval_summary --GATKdepths \
615ec322d4f64713a2b317c5e2422f75.out.sample_interval_summary --GATKdepths \
653bae74d6324f71b389bdee65b4539b.out.sample_interval_summary --GATKdepths \
664c20d2816944b3a8ae3b4a06dce192.out.sample_interval_summary --GATKdepths \
66acdf4cb80a44d69067e6ad0f04875a.out.sample_interval_summary --GATKdepths \
6718e37dcd814810bcbdb3738e009ce6.out.sample_interval_summary --GATKdepths \
671edb779d954200911753cd83d16f54.out.sample_interval_summary --GATKdepths \
67442567cf4e47ca846ffb8c3c156a31.out.sample_interval_summary --GATKdepths \
688d50d219f44e02813bca1736e41c5d.out.sample_interval_summary --GATKdepths \
6a62bdf40b4449ac9b4ce6b931790d66.out.sample_interval_summary --GATKdepths \
6f4fd016e4e54fcf81c91d2326ce20d7.out.sample_interval_summary --GATKdepths \
717efbb27506499c818e7967028423d8.out.sample_interval_summary --GATKdepths \
72d3ed11943e4686b1c6de97842b7d98.out.sample_interval_summary --GATKdepths \
72fe851ffef84e62bc5fb59c4c89c27e.out.sample_interval_summary --GATKdepths \
738eb06132bc4c978d23196ef1ef401f.out.sample_interval_summary --GATKdepths \
740d3cad2b234fa89223f42dcfd40d75.out.sample_interval_summary --GATKdepths \
744ab5b5e7e64a8ba5cbde55b952c2fa.out.sample_interval_summary --GATKdepths \
75fdcefe1913449a96d9ae574fb0f42e.out.sample_interval_summary --GATKdepths \
765cf2923d5f46be8ec7ff1a890ab02d.out.sample_interval_summary --GATKdepths \
767724b6362a46248cb23e59155eb086.out.sample_interval_summary --GATKdepths \
7a806bb079c5499da411690c36c4d151.out.sample_interval_summary --GATKdepths \
7bb03b4a626247b3b85c3136e1a7b9b2.out.sample_interval_summary --GATKdepths \
7c33477fe1de4d32884b1dee3f183895.out.sample_interval_summary --GATKdepths \
80129930aad84c65bafd49514115a438.out.sample_interval_summary --GATKdepths \
804fa40a866c4d699bed6bd025d41e6e.out.sample_interval_summary --GATKdepths \
816dd4c0ac484aaa80139225ad00f6f7.out.sample_interval_summary --GATKdepths \
8263308997554653a90cb0c41c5122ce.out.sample_interval_summary --GATKdepths \
82b5d2becc294ab8be872771343ed984.out.sample_interval_summary --GATKdepths \
82e64415f9e645d6810b153fd5abbe0c.out.sample_interval_summary --GATKdepths \
8490491bfec54e928a01bf5e163df577.out.sample_interval_summary --GATKdepths \
87a5487c71e44247b366ba2ea05988ce.out.sample_interval_summary --GATKdepths \
87dade8d2d5a4a7cac1f721cf65f894c.out.sample_interval_summary --GATKdepths \
87dcb87262d94172aaf02500fea72a81.out.sample_interval_summary --GATKdepths \
8b5146a13ec642ae8724587f229ab334.out.sample_interval_summary --GATKdepths \
8d51212e280d411ea603883477d6de9b.out.sample_interval_summary --GATKdepths \
8ff6737568a346dd9c28588c61c44b2c.out.sample_interval_summary --GATKdepths \
90ab17d813004ea98b2828261b2b18a3.out.sample_interval_summary --GATKdepths \
90e5d1f0a55446f2a86665185974a39e.out.sample_interval_summary --GATKdepths \
94016e0caa3344f19f78bdf9b8f71cd9.out.sample_interval_summary --GATKdepths \
9470ced9ecfe4859ab06ca24912d16d5.out.sample_interval_summary --GATKdepths \
94a09d17365d4f1cb05bd0a50b10f4e1.out.sample_interval_summary --GATKdepths \
94f2d3fe9c72491c89e270da09464ad3.out.sample_interval_summary --GATKdepths \
957c32109df04925b94a01771b50298e.out.sample_interval_summary --GATKdepths \
96dc42fe480842d1b18a5da35e26edd0.out.sample_interval_summary --GATKdepths \
970e53020ad44f198756d75277920a0f.out.sample_interval_summary --GATKdepths \
97441881beaf438dbe33065b79dbc316.out.sample_interval_summary --GATKdepths \
98990ce1761749d39ead8f16646b132c.out.sample_interval_summary --GATKdepths \
9bc94d55c78b4076bd7d130bafed1def.out.sample_interval_summary --GATKdepths \
9df412d8714646bf80835cdc49478a32.out.sample_interval_summary --GATKdepths \
9dfb5dd2dd314b4e979b5b18d5ea33d3.out.sample_interval_summary --GATKdepths \
9f687341e9c34057a2663ce1c9e52305.out.sample_interval_summary --GATKdepths \
a2bcce144cc04110bbacab3cdedbe51a.out.sample_interval_summary --GATKdepths \
a622a9c0bf214dea82ed098ce6a914c5.out.sample_interval_summary --GATKdepths \
a65b7e96235c490d9f915e95ba7927ff.out.sample_interval_summary --GATKdepths \
a6aff3d2625a425698d5c397cef6a743.out.sample_interval_summary --GATKdepths \
a7b5ab9dd6a040d7b6f2878706b42abb.out.sample_interval_summary --GATKdepths \
a8cc04ab9bb54763a4756e780e12164d.out.sample_interval_summary --GATKdepths \
a9d234dbd3fb4eb3a6b9f53176f8e283.out.sample_interval_summary --GATKdepths \
ac1434fdc57342b9b6e386ad296da120.out.sample_interval_summary --GATKdepths \
ac7a8cf46931495ca5e7b92498e9411a.out.sample_interval_summary --GATKdepths \
ae1d2502f0bb4c9d8aa40d3ec2294816.out.sample_interval_summary --GATKdepths \
aec4d8ed2bd445aa85d6c5b02bb44ccf.out.sample_interval_summary --GATKdepths \
af94eaeab94d4e81808fa26277a93ff2.out.sample_interval_summary --GATKdepths \
b04e8cd4045d4305873e2364f3ffff13.out.sample_interval_summary --GATKdepths \
b2984a895a0a41feb6c18cdf81f78a88.out.sample_interval_summary --GATKdepths \
b35c1edf17fd4484a34fe305541c0954.out.sample_interval_summary --GATKdepths \
b4bc96509d1e462596b41e6f4619aa3b.out.sample_interval_summary --GATKdepths \
b5a9bdf0ba684f96a590180083e67e31.out.sample_interval_summary --GATKdepths \
b5c3a242beba426c8f59b78b624921e3.out.sample_interval_summary --GATKdepths \
bc139a83fb4c484b8220e9fb6f19ccce.out.sample_interval_summary --GATKdepths \
bc17c4ed11cc4e9195ada709d06549f9.out.sample_interval_summary --GATKdepths \
bd058a2cc56b4d1aa87a05e298dd3f26.out.sample_interval_summary --GATKdepths \
bdb0dfc0dcb04ea0ad1173a5dd082b8f.out.sample_interval_summary --GATKdepths \
c100042f24ac475793389b0ccde96b1c.out.sample_interval_summary --GATKdepths \
c1464d540cf247e0a5948d93d08a0fd7.out.sample_interval_summary --GATKdepths \
c15fca736d6844378621f8ef2847b234.out.sample_interval_summary --GATKdepths \
c1d72d1af97043c097e5fab31c160457.out.sample_interval_summary --GATKdepths \
c1eef49a1ca24eb1b7a1c66b0978fbd6.out.sample_interval_summary --GATKdepths \
c21b53ac24f341aeb96dfdc2975ad69c.out.sample_interval_summary --GATKdepths \
c26476f89fd54000a001778b692833b1.out.sample_interval_summary --GATKdepths \
c4ad21fc38db437ea9cab1613007353a.out.sample_interval_summary --GATKdepths \
c500977639d14f3dbd4b01efe5941340.out.sample_interval_summary --GATKdepths \
c732e17244464a1db49e3d80e2466453.out.sample_interval_summary --GATKdepths \
c7a60094dd654909822dc00e2114360a.out.sample_interval_summary --GATKdepths \
c85a201fc4114f89b02b71d43d978870.out.sample_interval_summary --GATKdepths \
cbe662c45cfd4d078d784227887c392a.out.sample_interval_summary --GATKdepths \
ccc6479c7f6e47e7b4276344d73f8496.out.sample_interval_summary --GATKdepths \
ce05bae364ac431c8c5a127f19522032.out.sample_interval_summary --GATKdepths \
ce0fb7a32f0b4e41a583b6456781d6d0.out.sample_interval_summary --GATKdepths \
cf78af5a7a8d4ff39d4258681c112fb2.out.sample_interval_summary --GATKdepths \
d1db4337aea24860a74988b6da92d976.out.sample_interval_summary --GATKdepths \
d3bd126325104429a04a7017662fe0e8.out.sample_interval_summary --GATKdepths \
d4fef7e1313345329844b22dfdd4c80a.out.sample_interval_summary --GATKdepths \
d5f73ad0c0f648ee919a1b8e608c34f5.out.sample_interval_summary --GATKdepths \
d6d05d07791e4e03b530b3426df6978b.out.sample_interval_summary --GATKdepths \
d83d8d361f714519bb1678b176f051b1.out.sample_interval_summary --GATKdepths \
d8acfad45265496f9184345f98bb66bc.out.sample_interval_summary --GATKdepths \
d952095815ae4fc98b27f09c3b627a54.out.sample_interval_summary --GATKdepths \
dc1f904f7f1e45a28457592c2ae6b5ce.out.sample_interval_summary --GATKdepths \
deaf65ce81d641c1b1d5dc81c0c38b54.out.sample_interval_summary --GATKdepths \
deded465e0bc444d90d0a9f09b0eb35d.out.sample_interval_summary --GATKdepths \
df45c423226c496e8aa2b8478680e9f1.out.sample_interval_summary --GATKdepths \
e02a84fe5c30494ba1891aeafc3c9db5.out.sample_interval_summary --GATKdepths \
e08a033597f5460ea1d5db11dc5d7293.out.sample_interval_summary --GATKdepths \
e2b78536be7144a5b32c6880e4de32a6.out.sample_interval_summary --GATKdepths \
e53d404ae4994769a577a75aaf8224c6.out.sample_interval_summary --GATKdepths \
e58733e543bb4e9bbbce2f0045f533ed.out.sample_interval_summary --GATKdepths \
e88499c396f742b489bbdb56495bfd24.out.sample_interval_summary --GATKdepths \
e9fa374d789c40fe8be9f0ae43fdb195.out.sample_interval_summary --GATKdepths \
eba96eba8f47451dbaeccf7d9877e4b5.out.sample_interval_summary --GATKdepths \
ecae2846efe1462288be010deddc04fe.out.sample_interval_summary --GATKdepths \
ecdf786c0cb845e89d779a274fd5905c.out.sample_interval_summary --GATKdepths \
ed3ebba3a65848d5b580efe47df566de.out.sample_interval_summary --GATKdepths \
edf9ef14b7d6446d988b0fd34d3ff956.out.sample_interval_summary --GATKdepths \
ef3a6e5b6dd34d17a8a848618ecd3a19.out.sample_interval_summary --GATKdepths \
ef49d9ba5b624bcc8be9676e43c4c432.out.sample_interval_summary --GATKdepths \
f0f59a513b10464080cce332356c5c16.out.sample_interval_summary --GATKdepths \
f448d0186af84cfc8620e5fee7c269d1.out.sample_interval_summary --GATKdepths \
f509450ad56949e59793661ff8b9bb82.out.sample_interval_summary --GATKdepths \
f7525fc4985d4ae9ae5f31978703c11c.out.sample_interval_summary --GATKdepths \
f97acccfff594d22b152affb789885e7.out.sample_interval_summary --GATKdepths \
fa0800d7891c4adf95e556340ad8ebb7.out.sample_interval_summary --GATKdepths \
fc05d60228e44ae6bd46324830871f17.out.sample_interval_summary --GATKdepths \
fdc852d7b18a4f3a83e449891c232823.out.sample_interval_summary

#############################################################################################33
Skipped (7/23/18) because I got "permission denied" message
# run PLINK/Seq to calculate the fraction of repeat-masked bases in each target and create a list of those to filter out:

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/sources/scripts/interval_list_to_pseq_reg /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed > /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/EXOME.targets.reg

#####run from: /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files

#Create LOCDB just like SEQDB, but first create gtf
/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/plinkseq-0.10/pseq . loc-load --file /home/BIO/johnw/GELCC_WES_RAW_Data/b37GTF.gtf --group refseq --locdb locdb




/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/plinkseq-0.10/pseq . loc-load --locdb ./locdb --file ./EXOME.targets.reg --group targets --out ./EXOME.targets.LOCDB.loc-load

#to get the following step to work, seqdb was necessary: http://atgu.mgh.harvard.edu/plinkseq/resources.shtml
/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/plinkseq-0.10/pseq . seq-load --file /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta --seqdb seqdb --name b37 --description from-UCSC-20-dec-2010 --format build=hg18 repeat-mode=lower

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/plinkseq-0.10/pseq . seq-summary --seqdb seqdb

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/plinkseq-0.10/pseq . loc-stats --locdb ./EXOME.targets.LOCDB --group targets --seqdb /home/BIO/johnw/GELCC_WES_RAW_Data/2_GELCC_bam_files/seqdb | awk '{if (NR > 1) print $_}' | sort -k1 -g | awk '{print $10}' | paste /home/BIO/johnw/GELCC_WES_RAW_Data/Agilent_SureSelect_v5UTRs_edited.bed - | awk '{print $1"\t"$2}' > ./DATA.locus_complexity.txt

cat ./DATA.locus_complexity.txt | awk '{if ($2 > 0.25) print $1}' > ./low_complexity_targets.txt

#########################################################################################3
#Filters samples and targets and then mean-centers the targets:
 #!!!!!!!!!!! run on 7/23/18 did not include: "--excludeTargets ./low_complexity_targets.txt"
#run on 7/25/18 included: "--excludeTargets ./low_complexity_targets.txt"

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --matrix -r ./DATA.RD.txt --centerData --centerType target \
-o ./DATA.filtered_centered.RD.txt \
--outputExcludedTargets ./DATA.filtered_centered.RD.txt.filtered_targets.txt \
--outputExcludedSamples ./DATA.filtered_centered.RD.txt.filtered_samples.txt \
--excludeTargets ./low_complexity_targets.txt \
--excludeTargets ./extreme_gc_targets.txt \
--minTargetSize 10 --maxTargetSize 10000 \
--minMeanTargetRD 10 --maxMeanTargetRD 500 \
--minMeanSampleRD 25 --maxMeanSampleRD 200 \
--maxSdSampleRD 150

 ###### Runs PCA on mean-centered data:

 /home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --PCA -r ./DATA.filtered_centered.RD.txt --PCAfiles ./DATA.RD_PCA

 ########### Normalizes mean-centered data using PCA information:
/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --normalize -r ./DATA.filtered_centered.RD.txt --PCAfiles ./DATA.RD_PCA \
 --normalizeOutput ./DATA.PCA_normalized.txt \
--PCnormalizeMethod PVE_mean --PVE_mean_factor 0.7

############### Filters and z-score centers (by sample) the PCA-normalized data:
/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --matrix -r ./DATA.PCA_normalized.txt --centerData --centerType sample --zScoreData \
-o ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt \
--outputExcludedTargets ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt.filtered_targets.txt \
--outputExcludedSamples ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt.filtered_samples.txt \
--maxSdTargetRD 30

 ############# Filters original read-depth data to be the same as filtered, normalized data:

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --matrix -r ./DATA.RD.txt \
--excludeTargets ./DATA.filtered_centered.RD.txt.filtered_targets.txt \
--excludeTargets ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt.filtered_targets.txt \
--excludeSamples ./DATA.filtered_centered.RD.txt.filtered_samples.txt \
--excludeSamples ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt.filtered_samples.txt \
-o ./DATA.same_filtered.RD.txt

 ############# Discovers CNVs in normalized data:
/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --discover -p /home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/params.txt \
-r ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt -R ./DATA.same_filtered.RD.txt \
-c ./DATA.xcnv -a ./DATA.aux_xcnv -s ./DATA

#######Genotypes discovered CNVs in all samples:

/home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/xhmm --genotype -p /home/BIO/johnw/GELCC_WES_RAW_Data/GATK3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/params.txt \
-r ./DATA.PCA_normalized.filtered.sample_zscores.RD.txt -R ./DATA.same_filtered.RD.txt \
-g ./DATA.xcnv -F /home/BIO/johnw/GELCC_WES_RAW_Data/human_g1k_v37.fasta \
-v ./DATA.vcf





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
