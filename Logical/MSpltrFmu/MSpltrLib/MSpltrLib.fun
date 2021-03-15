
FUNCTION_BLOCK MSpltrView
	VAR_INPUT
		Enable : BOOL;
		InstRef : REFERENCE TO MSpltrInternalType;
	END_VAR
	VAR_OUTPUT
		ObjPos : ARRAY[0..18] OF REAL;
	END_VAR
	VAR
		vInternal : ARRAY[0..18] OF LREAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MSpltr (**) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*) (*Fmu.Type="MSpltr",Fmu.ModelName="MSpltr",Fmu.GUID="{d25602c7-833a-5e8d-e356-ec0e85f22cec}",Fmu.LocalPath="C:\projects\MS_FMU\MSpltr.fmu",Fmu.Updated="2019-09-27 13:58:32"*)
	VAR_INPUT
		Enable : BOOL;
	END_VAR
	VAR_OUTPUT
		InstRef : UDINT;
	END_VAR
	VAR
		Internal : MSpltrInternalType;
	END_VAR
	VAR_INPUT
		InputX : LREAL; (*InputX*)
		InputY : LREAL; (*InputY*)
	END_VAR
	VAR_OUTPUT
		PositionX : LREAL; (*PositionX*)
		PositionY : LREAL; (*PositionY*)
		SpeedX : LREAL; (*der(P1.s)*)
		SpeedY : LREAL; (*der(P2.s)*)
		TorqueX : LREAL; (*TorqueX*)
		TorqueY : LREAL; (*TorqueY*)
	END_VAR
END_FUNCTION_BLOCK
