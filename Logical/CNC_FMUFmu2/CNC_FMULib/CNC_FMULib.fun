
FUNCTION_BLOCK CNC_FMUView
	VAR_INPUT
		Enable : BOOL;
		InstRef : REFERENCE TO CNC_FMUInternalType;
	END_VAR
	VAR_OUTPUT
		ObjPos : ARRAY[0..18] OF REAL;
	END_VAR
	VAR
		vInternal : ARRAY[0..18] OF LREAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK CNC_FMU (**) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*) (*Fmu.Type="CNC_FMU",Fmu.ModelName="CNC_FMU",Fmu.GUID="{0f3398f8-206d-0d3a-c8cf-c7c7b11e43f1}",Fmu.LocalPath="C:\Users\VOSTRO 5000 Series\Desktop\CNC_FMU.fmu",Fmu.Updated="2021-01-25 13:39:10"*)
	VAR_INPUT
		Enable : BOOL;
	END_VAR
	VAR_OUTPUT
		InstRef : UDINT;
	END_VAR
	VAR
		Internal : CNC_FMUInternalType;
	END_VAR
	VAR_INPUT
		X : LREAL; (*X*)
		Y : LREAL; (*Y*)
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
