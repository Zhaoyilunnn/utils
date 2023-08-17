#!/usr/local/bin/gnuplot -persist
set terminal svg size 600,400 dynamic enhanced font 'arial,10' mousing name "boxclusters_1" butt dashlength 1.0
set output 'boxclusters.1.svg'
unset border
set boxwidth 1 absolute
set style fill   solid 1.00 border lt -1
set grid nopolar
set grid noxtics nomxtics ytics nomytics noztics nomztics nortics nomrtics \
 nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500
unset key
set style textbox  opaque margins  1.0,  1.0 fc  bgnd noborder linewidth  1.0
set style data lines
set xtics border in scale 0,0 mirror norotate  autojustify
set xtics  norangelimit
set xtics   ("Yan" 5.00000, "Tan" 20.0000, "Tethera" 35.0000, "Methera" 50.0000)
set ytics border in scale 0,0 nomirror norotate  autojustify
set title "Clustered bar graph with individual colors\nspecified via plotstyle 'boxes'"
set title  offset character 0, -3, 0 font ",15" textcolor lt -1 norotate boxed
set xrange [ -2.00000 : 60.0000 ] noreverse nowriteback
set x2range [ * : * ] noreverse writeback
set yrange [ 0.00000 : 7.00000 ] noreverse nowriteback
set y2range [ * : * ] noreverse writeback
set zrange [ * : * ] noreverse writeback
set cbrange [ * : * ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set bmargin at screen 0.2
set tmargin at screen 0.9
set palette cubehelix start 0.5 cycles -1.5 saturation 1
set colorbox user
set colorbox horizontal origin screen 0.05, 0.05 size screen 0.9, 0.05 front  noinvert bdefault
xcoord(i) =  i*ClusterSize + column(1)
color(i)  = rand(0)
NO_ANIMATION = 1
ClusterSize = 15
category = "Yan Tan Tethera Methera Pimp"
## Last datafile plotted: "candlesticks.dat"
plot for [i=0:3] 'candlesticks.dat'      using (xcoord(i)):(column(i+2)):(color(i)) with boxes lc palette z
