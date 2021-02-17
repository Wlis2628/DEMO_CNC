
TYPE
	CNC_FMULibFmi2CbType : 	STRUCT 
		Logger : UDINT;
		AllocateMemory : UDINT;
		FreeMemory : UDINT;
		StepFinished : UDINT;
		ComponentEnvironment : UDINT;
	END_STRUCT;
	CNC_FMULibFmi2IfType : 	STRUCT 
		Enabled : BOOL;
		StartTime : LREAL;
		EndTime : LREAL;
		CurrentTime : LREAL;
		StepSize : LREAL;
		Error : DINT;
		Instance : UDINT;
		Callbacks : CNC_FMULibFmi2CbType;
	END_STRUCT;
	CNC_FMUInternalType : 	STRUCT 
		Fmi2 : CNC_FMULibFmi2IfType;
	END_STRUCT;
END_TYPE
