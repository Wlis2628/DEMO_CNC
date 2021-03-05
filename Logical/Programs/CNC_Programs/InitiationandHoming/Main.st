PROGRAM _INIT
    (*MpCnc2Axis config*)
	MpCnc2Axis_0.MpLink := ADR(gCncXZ);
	MpCnc2Axis_0.Enable := FALSE;
	MpCnc2Axis_0.Parameters := ADR(CncParameters);
    
	MpCnc2Axis_0.Override := 100.0;
	CncParameters.ProgramName := CncNameCopy;

	
	
	(*MpAxisBasic X and Y config*)
	MpAxisBasicX.MpLink:=ADR(gAxisQX);
	MpAxisBasicY.MpLink:=ADR(gAxisQZ);
	
	MpAxisBasicX.Parameters:=ADR(MpBasicParametersX);
	MpAxisBasicY.Parameters:=ADR(MpBasicParametersY);
	
	(*--------------------------*)
	
	MoveMachine := FALSE;

	
END_PROGRAM

PROGRAM _CYCLIC

	
	(*Cnc param*)
	CncParameters.Jog.PathLimits.Acceleration	:= gParameter.limit_acc;
	CncParameters.Jog.PathLimits.Deceleration	:= gParameter.limit_dec;
	CncParameters.Jog.PathLimits.Velocity		:= gParameter.limit_vel;
	CncParameters.Jog.Velocity[0]				:= gParameter.set_X_vel;
	CncParameters.Jog.Velocity[1]				:= gParameter.set_Z_vel;
	
	(*MpAxisBasic param*)
	MpBasicParametersX.Acceleration	:= gParameter.limit_acc;
	MpBasicParametersX.Deceleration	:= gParameter.limit_dec;
	MpBasicParametersX.Velocity		:= gParameter.set_X_vel;
	
	MpBasicParametersY.Acceleration	:= gParameter.limit_acc;
	MpBasicParametersY.Deceleration	:= gParameter.limit_dec;
	MpBasicParametersY.Velocity		:= gParameter.set_X_vel;

	
	//Displaying point on manual control screen
	CncPosX:=LREAL_TO_INT(MpCnc2Axis_0.X);
	CncPosY:=LREAL_TO_INT(MpCnc2Axis_0.Y);

	//Start button
	IF ButtonEnable THEN
		MpCnc2Axis_0.Enable := TRUE;
		IF MpCnc2Axis_0.Info.ReadyToPowerOn THEN
			MpCnc2Axis_0.Power := TRUE;
		END_IF;
		IF MpCnc2Axis_0.PowerOn THEN
			MpCnc2Axis_0.Home := TRUE;
		END_IF;
	ELSIF ButtonEnable = FALSE THEN 
		gManualContr:=FALSE;
		MpCnc2Axis_0.Enable := FALSE;
		MpCnc2Axis_0.Power := FALSE;
		
	END_IF;	
	
//Axis enabled after homing and initiation
	IF MpCnc2Axis_0.IsHomed THEN
		MpCnc2Axis_0.Home := FALSE;
		MpAxisBasicX.Enable:=TRUE;
		MpAxisBasicY.Enable:=TRUE;
		MpAxisBasicX.Power:=TRUE;
		MpAxisBasicY.Power:=TRUE;
		
	END_IF;


//Forcing functions
	MpCnc2Axis_0();
	MpAxisBasicX();
	MpAxisBasicY();

END_PROGRAM

PROGRAM _EXIT
	
    (*MpCnc2Axis*)
	
	MpCnc2Axis_0.Power  := FALSE;
	MpCnc2Axis_0.Home   := FALSE;
	MpCnc2Axis_0.Enable := FALSE;
	MpCnc2Axis_0();
	
	(*MpAxisBasic*)
	
	MpAxisBasicX.Power  := FALSE;
	MpAxisBasicX.Home   := FALSE;
	MpAxisBasicX.MoveAbsolute := FALSE;
	MpAxisBasicX.MoveAdditive := FALSE;
	MpAxisBasicX.MoveVelocity := FALSE;
	MpAxisBasicX.Stop         := FALSE;
	MpAxisBasicX.ErrorReset   := FALSE;
	MpAxisBasicX();

	MpAxisBasicX.Enable := FALSE;
	MpAxisBasicX();
	
	MpAxisBasicY.Power  := FALSE;
	MpAxisBasicY.Home   := FALSE;
	MpAxisBasicY.Enable := FALSE;
	MpAxisBasicY.MoveAbsolute := FALSE;
	MpAxisBasicY.MoveAdditive := FALSE;
	MpAxisBasicY.MoveVelocity := FALSE;
	MpAxisBasicY.Stop         := FALSE;
	MpAxisBasicY.ErrorReset   := FALSE;
	MpAxisBasicY();

	MpAxisBasicY.Enable := FALSE;
	MpAxisBasicY();

	

	

END_PROGRAM

