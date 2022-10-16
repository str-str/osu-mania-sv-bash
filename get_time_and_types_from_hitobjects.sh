#!/bin/bash
echo "this script generates three useful files: t.osu, types.osu"
rm -f t.osu types.osu
echo "now generating..."
###process and form
# 1: note(s)
# 2: LN tail(s)
#
# read timing values from hitobjects
while read -r line ;
do
	time_string_1=${line#*,}
	time_string_2=${time_string_1#*,}
	time=${time_string_2%%,*}
	printf '%s\n' "${time} 1" >> all_time.osu
	empty_string="0:0:0:0:"
	LN_tail_time_string=${line##*,}
	if [[ "${LN_tail_time_string}" != "${empty_string}" ]] ; then # it's a LN, now getting the time of its tail
		LN_tail_time=${LN_tail_time_string%%:*}
		printf '%s\n' "${LN_tail_time} 2" >> all_time.osu
	fi
done < hitobjects.osu # should be exactly all the hitobjects at where i want sv
#
# when `type 1` and `type 2` appear simultaneously, keep `type 1` and remove `type 2`
#
sort --unique all_time.osu > time_orig.osu
#
# remove the dulplicated `type 2` when a LN tail was at the same time with a normal note:
while read -r line ;
do
	time=$(echo ${line} | cut -d ' ' -f 1)
	types=$(echo ${line} | cut -d ' ' -f 2)
	if [[ "${time}" == "${temp}" ]] ; then # now the "types" should be "2", should skip this line
		continue
	fi
	temp=${time} # "temp" is "the last 'time'" in the next loop
	printf '%s\n' "${time} ${types}" >> both.osu
done < time_orig.osu # should be exactly all the hitobjects at where you want sv
#
cat "both.osu" | cut -d ' ' -f 1 > t.osu
cat "both.osu" | cut -d ' ' -f 2 > types.osu
rm -f all_time.osu time_orig.osu both.osu
echo "Done"
