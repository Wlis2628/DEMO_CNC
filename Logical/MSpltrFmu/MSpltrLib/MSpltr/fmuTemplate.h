/*****************************************************************************/
/* FILE fmi2Functions.h */
/*****************************************************************************/

#include <stdio.h>
#include <string.h>
#include <assert.h>

#include "fmi2Functions.h"

#define compEnv comp->functions.componentEnvironment
#define compLog comp->functions.logger

#define not_modelError (modelInstantiated | modelInitialized | modelTerminated)
/* According to the chart on pg. 85 of the spec, 'Get's are not allowed
	until after we enter initialization mode, so use validGet instead */
#define validGet (modelInitialized | modelTerminated)

typedef enum {
	modelInstantiated = 1<<0,
	modelInitialized  = 1<<1,
	modelTerminated   = 1<<2,
	modelError        = 1<<3
} ModelState;

typedef struct {
	SolverStruct			S;
	fmi2Boolean				*b;
	fmi2String				*s;
	fmi2String				instanceName;
	fmi2String				GUID;
	fmi2Type					fmuType;
	fmi2CallbackFunctions	functions;
	fmi2Boolean				loggingOn;
	fmi2Boolean				synced;
	fmi2Boolean				jsynced;
	ModelState				state;
	fmi2Real				*Jacobian;
	fmi2Real				*initRes;
	fmi2Real				*initJacobian;

	fmi2Real				tolerance;
	fmi2Real				startTime;
	fmi2Boolean				stopTimeDefined;
	fmi2Real				stopTime;
	fmi2Real				lastStepSize;

	fmi2Real				lastEventTime;
	fmi2Real				lastSuccessfulTime;

	fmi2Boolean				initializeMode;
	FILE					*fptr;
	fmi2String				fstr;
	fmi2Integer				numpts;
	fmi2Real				lastsampletime;
	fmi2Real				minSampleStep;

	fmi2Integer				vidsts; /* -1 = error, 0 = no data, 1 = init, 2 = int */
	fmi2Char				viderror[MAXERRSTRLENGTH+1];
	fmi2Real				vidlasttime;
} ModelInstance;

