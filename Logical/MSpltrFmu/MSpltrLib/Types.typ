
TYPE
	MSpltrLibFmi2CbType : 	STRUCT 
		Logger : UDINT;
		AllocateMemory : UDINT;
		FreeMemory : UDINT;
		StepFinished : UDINT;
		ComponentEnvironment : UDINT;
	END_STRUCT;
	MSpltrLibFmi2IfType : 	STRUCT 
		Enabled : BOOL;
		StartTime : LREAL;
		EndTime : LREAL;
		CurrentTime : LREAL;
		StepSize : LREAL;
		Error : DINT;
		Instance : UDINT;
		Callbacks : MSpltrLibFmi2CbType;
	END_STRUCT;
	MSpltrInternalType : 	STRUCT 
		Fmi2 : MSpltrLibFmi2IfType;
	END_STRUCT;
END_TYPE
