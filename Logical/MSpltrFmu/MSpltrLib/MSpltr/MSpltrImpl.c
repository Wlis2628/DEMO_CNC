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
#include "MSpltrLib.h"
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
void MSpltr_fmuLogger(fmi2Component c, fmi2String instanceName, fmi2Status status, fmi2String category, fmi2String message, ...);
void* MSpltr_AllocateMemory(UDINT numElements, UDINT elementSize);
void MSpltr_FreeMemory(void* pMemory);


void MSpltr_initFMU(struct MSpltr* fubInstance);

void MSpltr_initFMUCallbacks(struct MSpltr* fubInstance);
void MSpltr_initFMUCoSimParameters(struct MSpltr* fubInstance);

void MSpltr_stepFMU(struct MSpltr* fubInstance);
void MSpltr_resetFMU (struct MSpltr* fubInstance);

void MSpltr_copyOutputsFromFmu(struct MSpltr* fubInstance);
void MSpltr_copyInputsToFmu(struct MSpltr* fubInstance);
void MSpltr_clearFmuOutputs(struct MSpltr* fubInstance);


/**********************************************************************/
/* FUB implementation */
void MSpltr(struct MSpltr* fubInstance)
{
	MSpltr_ProcessFmuState(fubInstance);	
}

/* Processes the fmu states */
void  MSpltr_ProcessFmuState(struct MSpltr* fubInstance)
{
	if (FMU_Enable)
	{
		if (!FMU_Enabled)
		{
			MSpltr_initFMU(fubInstance);
			FMU_Enabled = fmi2True;
		}

		if(FMU_Error == 0)
		{
			MSpltr_stepFMU(fubInstance);
		}			
	}else
	{
		if (FMU_Enabled)
		{
			MSpltr_resetFMU(fubInstance);
			FMU_Enabled = fmi2False;
		}		
	}
	fubInstance->InstRef = &(fubInstance->Internal);
}

/* Initialises the FMU */
void MSpltr_initFMU(struct MSpltr* fubInstance)
{	
	fmi2Status retStatus = fmi2OK;
	FMU_Error = 0;
	
	MSpltr_initFMUCoSimParameters(fubInstance);
	
	MSpltr_initFMUCallbacks(fubInstance);

	FMU_Instance = MSpltr_fmi2Instantiate("MSpltr",fmi2CoSimulation,"{d25602c7-833a-5e8d-e356-ec0e85f22cec}",NULL,&FMU_Callbacks,fmi2False,fmi2False);
	
	if (!FMU_Instance)
	{
		FMU_Error = fmi2True;
	}else
	{
		retStatus = MSpltr_fmi2SetupExperiment(FMU_Instance,0 ,0.0, FMU_StartTime, 0, FMU_EndTime);

		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}

		retStatus = MSpltr_fmi2EnterInitializationMode(FMU_Instance);
		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}

		retStatus = MSpltr_fmi2ExitInitializationMode(FMU_Instance);
		if (retStatus > fmi2Warning) 
		{
			FMU_Error = fmi2True;
			return;
		}
		
		MSpltr_copyOutputsFromFmu(fubInstance);
	}	
}

/* Initialize CoSimulation parmeters */
void MSpltr_initFMUCoSimParameters(struct MSpltr* fubInstance)
{
	FMU_StartTime = 0.00000000000000000e+00;
	FMU_EndTime = 0.0;
	FMU_StepSize = 1.00000000000000000e-03;
	
	FMU_CurrentTime = 0.0;	
}

/* Initialize FMU callbacks */
void  MSpltr_initFMUCallbacks(struct MSpltr* fubInstance)
{
	FMU_Callbacks.Logger = MSpltr_fmuLogger;
	FMU_Callbacks.AllocateMemory = MSpltr_AllocateMemory;
	FMU_Callbacks.FreeMemory = MSpltr_FreeMemory;	
	FMU_Callbacks.StepFinished = NULL;
	FMU_Callbacks.ComponentEnvironment = NULL;
}

/* Execute FMU steps */
void MSpltr_stepFMU(struct MSpltr* fubInstance)
{
	
	if (FMU_Error == 0)
	{		
		MSpltr_copyInputsToFmu(fubInstance);
		
		fmi2Status retStatus = MSpltr_fmi2DoStep(FMU_Instance, FMU_CurrentTime, FMU_StepSize, fmi2True);

		if(retStatus <= fmi2Warning)
		{
			MSpltr_copyOutputsFromFmu(fubInstance);
		
			FMU_CurrentTime += FMU_StepSize;
		}else
		{
			FMU_Error = fmi2True;
		}	
	}
}


/* Reset the FMU */
void MSpltr_resetFMU (struct MSpltr* fubInstance)
{
	fmi2Status retStatus = MSpltr_fmi2Reset(FMU_Instance);

	if(retStatus <= fmi2Warning)
	{
		MSpltr_clearFmuOutputs(fubInstance);
		FMU_CurrentTime = 0;
	}else
	{
		FMU_Error = fmi2True;
	}
}

/* Log FMU calls */
void MSpltr_fmuLogger(void *componentEnvironment, fmi2String instanceName, fmi2Status status, fmi2String category, fmi2String message, ...) 
{
	
}

/* Allocate memory */
void* MSpltr_AllocateMemory(UDINT numElements, UDINT elementSize)
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
void MSpltr_FreeMemory(void* pMemory)
{
	free(pMemory);
}

/* Clear the output values of the FMU */
void MSpltr_clearFmuOutputs(struct MSpltr* fubInstance)
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
void MSpltr_copyOutputsFromFmu(struct MSpltr* fubInstance)
{
	fmi2ValueReference valueReference;
	fmi2Status retStatus = fmi2OK;

	/*Copy fmu output PositionX to PositionX */
	valueReference = 67;
	fmi2Real PositionX;
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &PositionX);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->PositionX = PositionX;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output PositionY to PositionY */
	valueReference = 68;
	fmi2Real PositionY;
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &PositionY);

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
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &SpeedX);

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
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &SpeedY);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->SpeedY = SpeedY;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output TorqueX to TorqueX */
	valueReference = 69;
	fmi2Real TorqueX;
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &TorqueX);

	if(retStatus <= fmi2Warning)
	{
		fubInstance->TorqueX = TorqueX;
	}else
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu output TorqueY to TorqueY */
	valueReference = 70;
	fmi2Real TorqueY;
	retStatus = MSpltr_fmi2GetReal(FMU_Instance, &valueReference, 1, &TorqueY);

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
void MSpltr_copyInputsToFmu(struct MSpltr* fubInstance)
{
	fmi2ValueReference valueReference;
	fmi2Status retStatus = fmi2OK;

	/*Copy fmu input InputX to InputX */
	valueReference = 73;
	fmi2Real InputX;
	InputX = fubInstance->InputX;
	retStatus = MSpltr_fmi2SetReal(FMU_Instance, &valueReference, 1, &InputX);
	if(retStatus > fmi2Warning)
	{
		FMU_Error = fmi2True;
		return;
	}
	/*Copy fmu input InputY to InputY */
	valueReference = 74;
	fmi2Real InputY;
	InputY = fubInstance->InputY;
	retStatus = MSpltr_fmi2SetReal(FMU_Instance, &valueReference, 1, &InputY);
	if(retStatus > fmi2Warning)
	{
		FMU_Error = fmi2True;
		return;
	}	
}



