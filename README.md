####Intro

>mainly for reducing duplication of effort in making SV for osu! mania, very basic for now

>Support Keymodes: all keymodes

>now implemented greenlines-only (velocity values) for basic usage

>redlines (bpm values) would also be easy

>the scale of 14 digits was for v128 osu file format, used by [osu! lazer](https://github.com/ppy/osu), instead of v14 osu file format used by [osu! stable](https://osu.ppy.sh/home/download)

####Dependencies

>morden linux environments

####Usage

- store the lines of [Hitobjects](https://osu.ppy.sh/wiki/en/Client/File_formats/Osu_(file_format)\#hit-objects) at where you need SV in a file named `hitobjects.osu`

- execute the script `get_time_and_types_from_hitobjects.sh`

- execute the script `generate_greenlines.sh`

- the `sv_output.osu` should be what you want

####Reference

>LNs
>[Hold syntax: x,y,time,type,hitSound,endTime:hitSample](https://osu.ppy.sh/wiki/en/Client/File_formats/Osu_%28file_format%29#holds-(osu!mania-only))

####similar projects for osu! mania

###SV

>C++ [osuSVtool](https://github.com/longnguyen2004/osuSVTool)

>web [SV change tools](http://zardoru.github.io/sv-tools/) and source [blackhole-studio (TypeScript)](https://github.com/zardoru/blackhole-studio)

###General

>C++ [reamber](https://github.com/Eve-ning/reamber)

>Python [reamberPy](https://github.com/Eve-ning/reamberPy)
