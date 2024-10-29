library(data.table)
library(dplyr)
#library(parallel)
x = unique(gsub("_1.fq.gz", "", gsub("_2.fq.gz", "", list.files("/mnt/wspolny/sbaluszek/pitnet/fastq"))))

cmd = c(
  "STAR",
  "--runThreadN 48",
  "--runMode alignReads",
  "--readFilesCommand zcat",
  "--genomeDir /mnt/wspolny/sbaluszek/genomes/mouseSTAR",
  "--readFilesIn /mnt/wspolny/sbaluszek/pitnet/fastq/%s_1.fq.gz /mnt/wspolny/sbaluszek/pitnet/fastq/%s_2.fq.gz",
  "--outFileNamePrefix /mnt/wspolny/sbaluszek/pitnet/aligned/%s/%s_",
  "--outSAMtype BAM SortedByCoordinate",
  "--chimSegmentMin 20",
  "--chimOutType Junctions",
  "--quantMode GeneCounts"
)
cmd = paste(cmd, collapse = " ")

for(ex in x){
  targetDir = sprintf("/mnt/wspolny/sbaluszek/aligned/%s", ex)
tm = Sys.time()
    system(sprintf("mkdir %s", targetDir))
    system(sprintf(cmd, ex, ex, ex, ex))
    print(sprintf("%s done in %s!", ex, Sys.time() - tm))

}
