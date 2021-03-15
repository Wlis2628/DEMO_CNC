
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	// wejscie - predkosc w danej osi
	MSpltr1.Enable:=TRUE;
	MSpltrView_0.Enable:=TRUE;
	
	
	MSpltr1.InputX := MpAxisBasicX.Velocity*19;
	MSpltr1.InputY := MpAxisBasicY.Velocity*19;	
	
	MSpltr1();
	
	MSpltrView_0.InstRef := MSpltr1.InstRef;
	
	MSpltrView_0();

	gPozycjaX := MSpltr1.PositionX*10;	
	gPozycjaY := MSpltr1.PositionY*10;
	
	//wyjscie-momenty 
	gTorqueX := MSpltr1.TorqueX*0.15;
	gTorqueY := MSpltr1.TorqueY*(-0.1);
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

