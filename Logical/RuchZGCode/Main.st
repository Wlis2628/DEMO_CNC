
PROGRAM _INIT
	(* Insert code here *)
	CncName := '';
	CncNameCopy := '';
	toolDown;
	toolUp;
	MC_BR_MFunction_0(AxesGroup :=ADR(gCncXZ) , Enable :=TRUE , MFunction :=50);
	MC_BR_MFunction_1(AxesGroup :=ADR(gCncXZ) , Enable :=TRUE , MFunction :=60);
END_PROGRAM

PROGRAM _CYCLIC
	
	//Transfering name of the opened file in MotionPad to the initialization of CNC
	
	IF MpCnc2Axis_0.PowerOn AND MpCnc2Axis_0.IsHomed AND MoveMachine = 1 THEN
		
	CncNameCopy := DELETE(CncName, 12, 0);
		CncParameters.ProgramName := CncNameCopy;
		MoveMachine := 2;
		IF  strcmp(ADR(CncNameCopy),ADR('')) <> 0 THEN
			MpCnc2Axis_0.MoveProgram := TRUE;
		END_IF
	
	ELSIF MpCnc2Axis_0.MoveDone THEN
		CncName := '';
		CncNameCopy := '';
		MpCnc2Axis_0.MoveProgram := FALSE;
	END_IF
	
	
	//Error control, showing the Error Dialog and reseting errors
	IF MpCnc2Axis_0.Error THEN
		DialogErrorVisible := TRUE;
		MpCnc2Axis_0.Stop := TRUE;
		MpCnc2Axis_0.MoveProgram := FALSE;
	END_IF
	

	IF MpCnc2Axis_0.Error = FALSE THEN
		MpCnc2Axis_0.ErrorReset := FALSE;
	END_IF


	
	MC_BR_MFunction_0();
	MC_BR_MFunction_1();
	IF EDGEPOS(toolUp) THEN
		gActiveTool:=FALSE;
		MC_BR_MFunction_0.Reset:=TRUE;
	ELSE
		MC_BR_MFunction_0.Reset:=FALSE;
	END_IF
	
	IF EDGEPOS(toolDown) THEN
		gActiveTool:=TRUE;
		MC_BR_MFunction_1.Reset:=TRUE;
	ELSE
		MC_BR_MFunction_1.Reset:=FALSE;
	END_IF
	
		

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

