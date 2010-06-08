play:	cool.wav
	mplayer cool.wav

cool.wav: vc1.orc vc1.sco
	csound -o cool.wav vc1.orc vc1.sco
cool.ogg: cool.wav
	oggenc cool.wav

#convert input.wav to an appropriate.wav
resampled.wav: input.wav
	sox input.wav -r 8k -u -b 8 -c 1 resampled.wav
