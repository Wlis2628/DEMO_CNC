
TYPE
	EnableType : 	STRUCT 
		ButtonStart : BOOL;
		ButtonResetErrors : BOOL;
		ButtonTurnOff : {REDUND_UNREPLICABLE} BOOL;
		ButtonActivateTool : BOOL;
		ButtonConvert : BOOL;
		ButonOpenExplorer : BOOL;
		ButtonSaveGcode : BOOL;
		ButtonSaveGcodeAs : BOOL;
		ButtonLoad : BOOL;
		ButtonSave : BOOL;
		ButtonRefresh : BOOL;
		SetXPos : BOOL;
		SetYPos : BOOL;
		SetAcc : BOOL;
		SetDec : BOOL;
		SetXVelocity : BOOL;
		SetYVelocity : BOOL;
		SetVelocityLimit : BOOL;
		ButtonAcknowledge : BOOL;
		ButtonAcknowledgeAll : BOOL;
		ButtonDelete : BOOL;
		ButtonCreate : BOOL;
		TextInputCreate : BOOL;
	END_STRUCT;
END_TYPE
