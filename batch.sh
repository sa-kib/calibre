#!/bin/bash

counter=1
for LWN_ISSUE in `cat ~/lwn.issues`; do
	fname=./out/lwn_$(printf "%.3d0" $counter).epub
	if [ -f $fname ]; then
		((counter++));
		continue
	fi
	echo process $LWN_ISSUE, file $fname "($counter)";
	export OVERRIDE_LWN_ISSUE=$LWN_ISSUE
	ebook-convert ./recipes/lwn_weekly.recipe $fname ;
	if [ $? != 0 ]; then
		echo "processing issue $LWN_ISSUE $counter failed"
		exit
	fi
	((counter++));
	timeout=$(($RANDOM % 90))
	echo -n sleep for $timeout seconds...
	sleep $timeout
	echo done
done
