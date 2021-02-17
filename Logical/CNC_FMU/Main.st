
PROGRAM _INIT

	MC_BR_WrLoadSimPosition_AcpAx_0.Axis:=ADR(gAxisQX);
	MC_BR_WrLoadSimPosition_AcpAx_1.Axis:=ADR(gAxisQZ);
	
	MC_ReadActualTorque_0.Axis:=ADR(gAxisQX);
	MC_ReadActualTorque_1.Axis:=ADR(gAxisQZ);
	
	MC_ReadActualTorque_0.Enable:=TRUE;
	MC_ReadActualTorque_1.Enable:=TRUE;
	
	CNC_FMU1.Enable:=TRUE;
	CNC_FMUView_0.Enable:=TRUE;
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MC_BR_WrLoadSimPosition_AcpAx_0.Enable:=MpAxisBasicX.Info.ReadyToPowerOn;
	MC_BR_WrLoadSimPosition_AcpAx_1.Enable:=MpAxisBasicY.Info.ReadyToPowerOn;

	MC_ReadActualTorque_0();
	MC_ReadActualTorque_1();
	
	CNC_FMU1.X:=MC_ReadActualTorque_0.Torque;
	CNC_FMU1.Y:=MC_ReadActualTorque_1.Torque;
	
	CNC_FMU1();
	
	MC_BR_WrLoadSimPosition_AcpAx_0.Position:=CNC_FMU1.PositionX;
	MC_BR_WrLoadSimPosition_AcpAx_1.Position:=CNC_FMU1.PositionY;
		
		
	MC_BR_WrLoadSimPosition_AcpAx_0();
	MC_BR_WrLoadSimPosition_AcpAx_1();
	
	CNC_FMUView_0.InstRef:=CNC_FMU1.InstRef;
	
	
	CNC_FMUView_0();
	


	



	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

