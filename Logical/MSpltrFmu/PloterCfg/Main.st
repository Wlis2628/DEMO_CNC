
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MSpltr1.Enable:=TRUE;
	MSpltrView_0.Enable:=TRUE;
	
	// input- velocity
	MSpltr1.InputX := MpAxisBasicX.Velocity*19;
	MSpltr1.InputY := -MpAxisBasicY.Velocity*19;	
	
	MSpltr1();
	
	MSpltrView_0.InstRef := MSpltr1.InstRef;
	
	MSpltrView_0();

	gPozycjaX := MSpltr1.PositionX*10;	
	gPozycjaY := MSpltr1.PositionY*10-420;
	
	// output- torque
	gTorqueX := MSpltr1.TorqueX*0.15;
	gTorqueY := MSpltr1.TorqueY*(-0.1);
	
	// offset
	brsmemcpy(ADR(NewObjPos), ADR(MSpltrView_0.ObjPos), SIZEOF(MSpltrView_0.ObjPos));
	NewObjPos[6] := MSpltrView_0.ObjPos[6]+439.53; 
	// NewObjPos[] is used in Scene Viewer (PVI) 
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

