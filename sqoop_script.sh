#!/bin/bash
set -x
src="sqoop_import_files"
dest="hdfs://sandbox-hdp.hortonworks.com:8020/raw_zone"
NOW=$(date +"%m-%d-%Y-%H-%M-%S")

if [ -e "$src" ];
then
    {
      while read line
      do
        {
        	sqoop import --connect "jdbc:mysql://ip_address:port/db?zeroDateTimeBehavior=round" \
                --username user --password password \
                --table $line --target-dir $dest/$line -m 1
                
		if [ $? -eq 0 ]; then
			echo " $line the data copied to hdfs location $dest/$line"
        	fi
	}

        done< $src
    }
else
    {
      echo "File not exists"
    }
fi
