sr=8000
kr=8000
ksmps = 1
nchnls = 1

instr 6; simple output
   acar soundin "nato.small.wav"
   
   out acar
endin

instr 1 ; 5 band vocoder - geometric bands
	idur       = p3
	igain      = p4
	ilow        = p5 ; the lowest frequency for the vocoder
	ihigh       = p6 ; the highest frequency for the vocoder
	itablec		= p7 ; which waveform to use for the oscillators
	ibandadj    = p8 ; an adjustment factor to make smaller-width bands
	
	acar soundin "nato.small.wav"
	
	; determine the frequency bands
	
	icoef pow ( ihigh / ilow ), ( 1. / 5. )
    ib0=ilow;

	ib1 = ib0 * icoef
	ib2 = ib1 * icoef
	ib3 = ib2 * icoef
	ib4 = ib3 * icoef
	ib5 = ib4 * icoef
    
    ;create a bunch of oscillators with which to recreate the input signal
    
	ar0 oscil 1,ib0,itablec
	ar1 oscil 1,ib1,itablec
	ar2 oscil 1,ib2,itablec
	ar3 oscil 1,ib3,itablec
	ar4 oscil 1,ib4,itablec
	
	
	amod=ar0+ar1+ar2+ar3+ar4

	; measure frequency band content of input 
	
	abpc0 butterbp acar, ib0, ib0*(icoef-1.0)*ibandadj
	abpc1 butterbp acar, ib1, ib1*(icoef-1.0)*ibandadj
	abpc2 butterbp acar, ib2, ib2*(icoef-1.0)*ibandadj
	abpc3 butterbp acar, ib3, ib3*(icoef-1.0)*ibandadj
	abpc4 butterbp acar, ib4, ib4*(icoef-1.0)*ibandadj

	;recreate the input signal using an oscillator for each frequency band
	
	av0 balance ar0, abpc0
	av1 balance ar1, abpc1
	av2 balance ar2, abpc2
	av3 balance ar3, abpc3
	av4 balance ar4, abpc4
	
	; Mix and output
	
	aenv linseg 0, 0.01, 1, idur - 0.02, 1, 0.01, 0
	
	amixl = 0.9*( av0 + av1 + av2 + av3 + av4) 
	amixl = amixl * aenv * igain 
	
	out p4*amixl
	
endin

