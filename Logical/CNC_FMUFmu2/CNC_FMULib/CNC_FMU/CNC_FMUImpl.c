/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************

 ********************************************************************
 * Basic fmu/fub implementation
 ********************************************************************/


#include <bur/plctypes.h>
#include <sys_lib.h>
#include <fmi2Functions.h>

#ifdef __cplusplus
	extern "C"
	{
#endif
#include "CNC_FMULib.h"
#ifdef __cplusplus
	};
#endif

/**********************************************************************/
/* FUB interface declarations */
#define  FMU_Enable 			fubInstance->Enable

#define  FMU_Instance 			fubInstance->Internal.Fmi2.Instance
#define  FMU_Enabled 			fubInstance->Internal.Fmi2.Enabled
#define  FMU_Error 			fubInstance->Internal.Fmi2.Error
#define  FMU_EndTime    		fubInstance->Internal.Fmi2.EndTime
#define  FMU_StartTime    		fubInstance->Internal.Fmi2.StartTime
#define  FMU_CurrentTime   		fubInstance->Internal.Fmi2.CurrentTime
#define  FMU_StepSize    		fubInstance->Internal.Fmi2.StepSize
#define  FMU_Callbacks   		fubInstance->Internal.Fmi2.Callbacks


/**********************************************************************/
/* Method delcarations */
void CNC_FMU_fmuLogger(fmi2Component c, fmi2String instanceName, fmi2Status status, fmi2String category, fmi2String message, ...);
void* CNC_FMU_AllocateMemory(UDINT numElements, UDINT elementSize);
void CNC_FMU_FreeMemory(void* pMemory);


void CNC_FMU_initFMU(struct CNC_FMU* fubInstance);

void CNC_FMU_initFMUCallbacks(struct CNC_FMU* fubInstance);
void CNC_FMU_initFMUCoSimParameters(struct CNC_FMU* fubInstance);

void CNC_FMU_stepFMU(struct CNC_FMU* fubInstance);
void CNC_FMU_resetFMU (struct CNC_FMU* fubInstance);

void CNC_FMU_copyOutputsFromFmu(struct CNC_FMU* fubInstance);
void CNC_FMU_copyInputsToFmu(struct CNC_FMU* fubInstance);
void CNC_FMU_clearFmuOutputs(struct CNC_FMU* fubInstance);


/**********************************************************************/
/* FUB implementation */
void CNC_FMU(struct CNC_FMU* fubInstance)
{
	CNC_FMU_ProcessFmuState(fubInstance);	
}

/* Processes the fmu states */
void  CNC_FMU_ProcessFmuState(struct CNC_FMU* fubInstance)
{
	if (FMU_Enable)
	{
		if (!FMU_Enabled)
		{
			CNC_FMU_initFMU(fubInstance);
			FMU_Enabled = fmi2True;
		}

		if(FMU_Error == 0)
		{
			CNC_FMU_stepFMU(fubInstance);
		}			
	}else
	{
		if (FMU_Enabled)
		{
			CNC_FMU_resetFMU(fubInstance);
			FMU_Enabled = fmi2False;
		}		
	}
	fubInstance->InstRef = &(fubInstance->Internal);
}

/* Initialises the FMU */
void CNC_FMU_initFMU(struct CNC_FMU* fubInstance)
{	
	fmi2Status retStatus = fmi2OK;
	FMU_Error = 0;
	
	CNC_FMU_initFMUCoSimParameters(fubInstance);
	
	CNC_FMU_initFMUCallbacks(fubInstance);

	FMU_Instance = CNC_FMU_fmi2Instantiate("CNC_FMU",fmi2CoSimulation,"{0f3398f8-206d-0d3a-c8cf-c7c7b11e43f1}",NULL,&FMU_Callbacks,fmi2False,fmi2False);
	
	if (!FMU_Instance)
	{
		FMU_Error = fmi2True;
	}else
	{
		retStatus = CNC_FMU_fmi2SetupExperiment(FMU_Instance,0 ,0.0, FMU_StartTime, 0, FMU_EndTime);

		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}

		retStatus = CNC_FMU_fmi2EnterInitializationMode(FMU_Instance);
		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}

		retStatus = CNC_FMU_fmi2ExitInitializationMode(FMU_Instance);
		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}
		
		CNC_FMU_copyOutputsFromFmu(fubInstance);
	}	
}

/* Initialize CoSimulation parmeters */
void CNC_FMU_initFMUCoSimParameters(struct CNC_FMU* fubInstance)
{
	FMU_StartTime = 0.00000000000000000e+00;
	FMU_EndTime = 0.0;
	FMU_StepSize = 1.00000000000000000e-04;
	
	FMU_CurrentTime = 0.0;	
}

/* Initialize FMU callbacks */
void  CNC_FMU_initFMUCallbacks(struct CNC_FMU* fubInstance)
{
	FMU_Callbacks.Logger = CNC_FMU_fmuLogger;
	FMU_Callbacks.AllocateMemory = CNC_FMU_AllocateMemory;
	FMU_Callbacks.FreeMemory = CNC_FMU_FreeMemory;	
	FMU_Callbacks.StepFinished = NULL;
	FMU_Callbacks.ComponentEnvironment = NULL;
}

/* Execute FMU steps */
void CNC_FMU_stepFMU(struct CNC_FMU* fubInstance)
{
	
	if (FMU_Error == 0)
	{		
		CNC_FMU_copyInputsToFmu(fubInstance);
		
		fmi2Status retStatus = CNC_FMU_fmi2DoStep(FMU_Instance, FMU_CurrentTime, FMU_StepSize, fmi2True);

		if(retStatus <= fmi2Warning)
		{
			CNC_FMU_copyOutputsFromFmu(fubInstance);
		
			FMU_CurrentTime += FMU_StepSize;
		}else
		{
			FMU_Error = fmi2True;
		}	
	}
}


/* Reset the FMU */
void CNC_FMU_resetFMU (struct CNC_FMU* fubInstance)
{
	fmi2Status retStatus = CNC_FMU_fmi2Reset(FMU_Instance);

	if(retStatus <= fmi2Warning)
	{
		CNC_FMU_clearFmuOutputs(fubInstance);
		FMU_CurrentTime = 0;
	}else
	{
		FMU_Error = fmi2True;
	}
}

/* Log FMU calls */
void CNC_FMU_fmuLogger(void *componentEnvironment, fmi2String instanceName, fmi2Status status, fmi2String category, fmi2String message, ...) 
{
	
}

/* Allocate memory */
void* CNC_FMU_AllocateMemory(UDINT numElements, UDINT elementSize)
{
	void* address;
	UDINT status = 0;
	
	status = TMP_alloc(numElements * elementSize, &address);
	
	
	if (status == 0)
	{
		return address;
	}
	else
	{
		return NULL;
	}
}

/* Free allocated memory */
void CNC_FMU_FreeMemory(void* pMemory)
{
	free(pMemory);
}

/* Clear the output values of the FMU */
void CNC_FMU_clearFmuOutputs(struct CNC_FMU* fubInstance)
{
	/*Clear fmu output PositionX*/
	fubInstance->PositionX = 0.0;
	/*Clear fmu output PositionY*/
	fubInstance->PositionY = 0.0;
	/*Clear fmu output SpeedX*/
	fubInstance->SpeedX = 0.0;
	/*Clear fmu output SpeedY*/
	fubInstance->SpeedY = 0.0;
	/*Clear fmu output TorqueX*/
	fubInstance->TorqueX = 0.0;
	/*Clear fmu output TorqueY*/
	fubInstance->TorqueY = 0.0;
	
}


/* Copy output values from the FMU */
void CNC_FMU_copyOutputsFromFmu(struct CNC_FMU* fubInstance)
{
	fmi2ValueReference valueReference;
	fmi2Status retStatus = fmi2OK;

	/*Copy fmu output PositionX to PositionX */
	valueReference = 25;
	fmi2Real PositionX;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &PositionX);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->PositionX = PositionX;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output PositionY to PositionY */
	valueReference = 26;
	fmi2Real PositionY;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &PositionY);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->PositionY = PositionY;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output SpeedX to SpeedX */
	valueReference = 2;
	fmi2Real SpeedX;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &SpeedX);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->SpeedX = SpeedX;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output SpeedY to SpeedY */
	valueReference = 4;
	fmi2Real SpeedY;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &SpeedY);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->SpeedY = SpeedY;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output TorqueX to TorqueX */
	valueReference = 27;
	fmi2Real TorqueX;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &TorqueX);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->TorqueX = TorqueX;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output TorqueY to TorqueY */
	valueReference = 28;
	fmi2Real TorqueY;
	retStatus = CNC_FMU_fmi2GetReal(FMU_Instance, &valueReference, 1, &TorqueY);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->TorqueY = TorqueY;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}	
}

/* Copy input values to the FMU */
void CNC_FMU_copyInputsToFmu(struct CNC_FMU* fubInstance)
{
	fmi2ValueReference valueReference;
	fmi2Status retStatus = fmi2OK;

	/*Copy fmu input X to X */
	valueReference = 31;
	fmi2Real X;
	X = fubInstance->X;
	retStatus = CNC_FMU_fmi2SetReal(FMU_Instance, &valueReference, 1, &X);
	if(retStatus > fmi2Warning)
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu input Y to Y */
	valueReference = 32;
	fmi2Real Y;
	Y = fubInstance->Y;
	retStatus = CNC_FMU_fmi2SetReal(FMU_Instance, &valueReference, 1, &Y);
	if(retStatus > fmi2Warning)
	{
		FMU_Error = fmi2True;
		return;
	}	
}



