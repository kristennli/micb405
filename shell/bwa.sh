mkdir project1
mkdir bam
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam

cp $DIRECTORY/ref_genome.fasta $HOME
bwa index $HOME/ref_genome.fasta
REFERENCE=$HOME/ref_genome.fasta
mkdir sorted
SORTED=/home/$USER/sorted

cd $HOME

    for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
        echo $prefix;
        bwa mem -t 40 $HOME/ref_genome.fasta $DIRECTORY/$prefix\_1.fastq.gz $DIRECTORY/$prefix\_2.fastq.gz | samtools view -b > $BAM/$prefix.bam;
        samtools sort -@30 $BAM/$prefix.bam -o $SORTED/$prefix.sorted.bam;

    done
