
PROGRAM _INIT

	
	gStartValueChanging;
	MpCnc2Axis_0;
	CncParameters;
	gActiveTool;
	
	gMoveAbsoluteX:=TRUE;
	gMoveAbsoluteY:=TRUE;



END_PROGRAM

PROGRAM _CYCLIC

	IF gManualContr OR ButtonEnable=FALSE THEN
		gAutomaticContr:=FALSE;
	ELSE
		gAutomaticContr:=TRUE;
	END_IF;
	
	
	IF MpCnc2Axis_0.MoveProgram THEN
	  gManualContr:=FALSE;
	END_IF;
	
	(*When activating manual control*)
	IF EDGEPOS(gManualContr) THEN
	MpBasicParametersX.Position:=MpCnc2Axis_0.X;
	MpBasicParametersY.Position:=MpCnc2Axis_0.Y;
	END_IF

	(*Manual control operating mode switched on with a button in Visu*)
	IF gManualContr THEN
		
		(*Movement controlled by sliders and text input in visualization*)

		PosX:=LREAL_TO_INT(MpBasicParametersX.Position);
		PosY:=LREAL_TO_INT(MpBasicParametersY.Position);
		
		
		IF MpBasicParametersX.Position=INT_TO_LREAL(CncPosX) THEN
			gMoveAbsoluteX:=FALSE;
		END_IF;
		
		IF MpBasicParametersY.Position=INT_TO_LREAL(CncPosY) THEN
			gMoveAbsoluteY:=FALSE;
		END_IF;
		
		
		(*Movement in X (MOVE ABSOLUTE) *)
		IF gMoveAbsoluteX THEN
			MpAxisBasicX.MoveAbsolute:=TRUE;
		END_IF;
		
		IF MpAxisBasicX.MoveDone=TRUE THEN
			MpAxisBasicX.MoveAbsolute:=FALSE;
			gMoveAbsoluteX:=FALSE;			
		END_IF;
		
		IF EDGENEG(gMoveAbsoluteX) AND CncPosX<>PosX THEN
			gMoveAbsoluteX:=TRUE;	
		END_IF;
		

		
		(*Movement in Y  (MOVE ABSOLUTE) *)
		
		IF gMoveAbsoluteY THEN
			MpAxisBasicY.MoveAbsolute:=TRUE;
		END_IF;
		
		IF MpAxisBasicY.MoveDone=TRUE THEN
			MpAxisBasicY.MoveAbsolute:=FALSE;
			gMoveAbsoluteY:=FALSE;
		END_IF;
		
		IF EDGENEG(gMoveAbsoluteY) AND CncPosY<>PosY THEN
			gMoveAbsoluteY:=TRUE;
		END_IF;
 
		
	ELSIF gManualContr=FALSE THEN
		MpAxisBasicX.MoveAbsolute:=FALSE;
		MpAxisBasicY.MoveAbsolute:=FALSE;
	END_IF;
	
		
	
	
	(*Movement control with ARROWS in visualization*)
	
	(*Arrows parameters*)
	
	MpBasicParametersX.Jog.Velocity:=gParameter.set_X_vel;
	MpBasicParametersY.Jog.Velocity:=gParameter.set_Z_vel;
	MpBasicParametersX.Jog.Acceleration:=gParameter.limit_acc;
	MpBasicParametersY.Jog.Acceleration:=gParameter.limit_acc;
	MpBasicParametersX.Jog.Deceleration:=gParameter.limit_dec;
	MpBasicParametersY.Jog.Deceleration:=gParameter.limit_dec;
	
	MpBasicParametersX.Jog.LimitPosition.FirstPosition:=0;
	MpBasicParametersX.Jog.LimitPosition.LastPosition:=520;
	MpBasicParametersY.Jog.LimitPosition.FirstPosition:=0;
	MpBasicParametersY.Jog.LimitPosition.LastPosition:=420;
	
	
	(*JOG MOVEMENT - NEGATIVE AND POSITIVE*)
	IF MpCnc2Axis_0.MoveActive AND (EDGENEG(MpAxisBasicX.JogNegative) OR EDGENEG(MpAxisBasicY.JogNegative) OR EDGENEG(MpAxisBasicX.JogPositive) OR EDGENEG(MpAxisBasicY.JogPositive)) THEN
	GetThere:=TRUE;
	END_IF;
	
	IF GetThere THEN
		MpBasicParametersY.Position:=MpCnc2Axis_0.Y;
		MpBasicParametersX.Position:=MpCnc2Axis_0.X;
	END_IF;
	
	IF MpCnc2Axis_0.MoveActive=FALSE THEN
		GetThere:=FALSE;
	END_IF
	
	
	(*Go Up, GoDown, GoLeft and GoRight are variables connected to the arrows in visu*)
	(*UP*)
	IF GoUp=TRUE THEN
		//	MpBasicParametersY.Position:=INT_TO_LREAL(CncPosY);
		MpBasicParametersY.Position:=MpCnc2Axis_0.Y;
		MpAxisBasicY.MoveAbsolute:=FALSE;
		MpAxisBasicY.JogNegative:=TRUE;
						
	ELSIF GoUp=FALSE THEN
		MpAxisBasicY.JogNegative:=FALSE;
	END_IF;	
		
	
	(*DOWN*)
	IF GoDown THEN
		MpBasicParametersY.Position:=INT_TO_LREAL(CncPosY);
		MpAxisBasicY.MoveAbsolute:=FALSE;
		MpAxisBasicY.JogPositive:=TRUE;
					
	ELSIF GoDown=FALSE THEN
		MpAxisBasicY.JogPositive:=FALSE;
	END_IF;
	
	
	
	(*LEFT*)
	IF GoLeft  THEN
		MpBasicParametersX.Position:=INT_TO_LREAL(CncPosX);
		MpAxisBasicX.MoveAbsolute:=FALSE;
		MpAxisBasicX.JogNegative:=TRUE;
		
		
	ELSIF GoLeft=FALSE THEN
		MpAxisBasicX.JogNegative:=FALSE;
	END_IF;	
	
	
		(*RIGHT*)
	IF GoRight THEN
		MpBasicParametersX.Position:=INT_TO_LREAL(CncPosX);
		MpAxisBasicX.MoveAbsolute:=FALSE;
		MpAxisBasicX.JogPositive:=TRUE;
		
	ELSIF GoRight=FALSE THEN
		MpAxisBasicX.JogPositive:=FALSE;
	END_IF;	
	
	
			
	(*Limits for movement in both directions (x,y) *)
	
	IF MpBasicParametersY.Position>=420 THEN
		MpBasicParametersY.Position:=420;
		
	ELSIF MpBasicParametersY.Position<=0 THEN
		MpBasicParametersY.Position:=0;
	END_IF;
	
			
	IF MpBasicParametersX.Position>=520 THEN
		MpBasicParametersX.Position:=520;
			
	ELSIF MpBasicParametersX.Position<=0 THEN
		MpBasicParametersX.Position:=0;
	END_IF;
			
			

		
	(* A dot showing the position of the tool*)
	pointString:='<circle cx="';
	
	pointStrX:=REAL_TO_STRING(CncPosX*1.2);
	pointStrY:=REAL_TO_STRING(CncPosY*1.2);
	
	strHelp:='" cy="';
	strcat(ADR(pointString),ADR(pointStrX));
	strcat(ADR(pointString),ADR(strHelp));
	strcat(ADR(pointString),ADR(pointStrY));
	strHelp:='" r="5" stroke="black" stroke-width="3" fill="red" />';
	strcat(ADR(pointString),ADR(strHelp));
		
	 
	MpAxisBasicX();
	MpAxisBasicY();
	
	
	IF MpAxisBasicX.Velocity=0 THEN
		gCurrentX:=0;
	ELSIF MpAxisBasicX.Velocity<0 THEN
		gCurrentX:=-MpAxisBasicX.Velocity*0.01+0.48;
	ELSIF MpAxisBasicX.Velocity>0 THEN
		gCurrentX:=MpAxisBasicX.Velocity*0.01+0.48;
		END_IF;
		
	
		IF MpAxisBasicY.Velocity=0 THEN
		gCurrentY:=0;
	ELSIF MpAxisBasicY.Velocity<0 THEN
		gCurrentY:=-MpAxisBasicY.Velocity*0.01+0.48;
	ELSIF MpAxisBasicY.Velocity>0 THEN
		gCurrentY:=MpAxisBasicY.Velocity*0.01+0.48;
		END_IF;

	
END_PROGRAM

PROGRAM _EXIT
	
	 
END_PROGRAM



