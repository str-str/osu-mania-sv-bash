#!/bin/bash
rm -f t0.osu sv_output.osu
# uncomment to pick the values you want
#v_10_00=-10				#10.00x
#...
#v_04_00=-25				#4.00x
#v_03_00=-33.33333333333333		#3.00x
#v_02_00=-50				#2.00x
#v_01_90=-52.63157894736842		#1.90x
#v_01_80=-55.55555555555556		#1.80x
#v_01_70=-58.82352941176471		#1.70x
v_01_60=-62.5				#1.60x
#v_01_50=-66.66666666666667		#1.50x
#v_01_40=-71.42857142857142		#1.40x
#v_01_30=-76.92307692307692		#1.30x
#v_01_20=-83.33333333333333		#1.20x
#v_01_10=-90.90909090909091		#1.10x
#v_01_00=-100				#1.00x
#v_00_90=-111.11111111111111		#0.90x
#v_00_80=-125				#0.80x
#v_00_70=-142.85714285714283		#0.70x
#v_00_60=-166.66666666666667		#0.60x
#v_00_50=-200				#0.50x
v_00_40=-250				#0.40x
#v_00_30=-333.33333333333333		#0.30x
#v_00_20=-500				#0.20x
#v_00_10=-1000				#0.10x
# seems like values lower than 0.10x would not be available for lazer now
other_parts="4,1,0,100,0,0"
echo ""
echo "Warning:"
echo "sound of hitobjects would be set to 'hitnormal-100' if you didn't edit the varirable 'other_parts'"
echo ""
#
read -p "enter start time of sv:(milisecond)" start_time
i=0 # loop count, for debugging usage
tail -n +2 "t.osu" > t0.osu
tail -n +2 "types.osu" > types0.osu
while read -r line_t && read -r line_types <&3;
do
	end_time=${line_t}
	echo "at ${line_t} ..."
	if [[ "${whether_sv}" == "0" ]]; then
		v_01_00_result="${start_time},${v_01_00},${other_parts}"
		printf '%s\n' "${v_01_00_result}" >> sv_output.osu
		start_time=${line_t}
		let i++
		echo "loop $i be normal since it simply has LN tail(s)"
		whether_sv=1
		continue
	fi
	if [[ "${line_types}" == "2" ]]; then # there is only a LN tail here
		whether_sv=0
	fi
	# calculate and get the time we need
	key_time_1=$(bc <<< "scale=14; (${end_time}+${start_time})/2")
	# Default: an easiest type of reverse bump, using only one key_time
	v_01_60_result="${start_time},${v_01_60},${other_parts}"
	v_00_40_result="${key_time_1},${v_00_40},${other_parts}"
	printf '%s\n' "${v_01_60_result}" >> sv_output.osu
	printf '%s\n' "${v_00_40_result}" >> sv_output.osu
	start_time=${line_t}
	let i++
	echo loop $i done
done < t0.osu 3< types0.osu
echo "Done, take a look at sv_output.osu"
