play:	cool.wav
	mplayer cool.wav

cool.wav: vc1.orc vc1.sco
	csound -o cool.wav vc1.orc vc1.sco
cool.ogg: cool.wav
	oggenc cool.wav
