#!/bin/bash

counter=99
for LWN_ISSUE in `cat ~/lwn.issues`; do
	if [ -f ./out/lwn_$counter.epub ]; then
		((counter--));
		continue
	fi
	echo process $LWN_ISSUE $counter;
	export LWN_ISSUE
	ebook-convert ./lwn_weekly.recipe ./out/lwn_$counter.epub ;
	if [ $? != 0 ]; then
		echo "processing issue $LWN_ISSUE $counter failed"
		exit
	fi
	((counter--));
done
