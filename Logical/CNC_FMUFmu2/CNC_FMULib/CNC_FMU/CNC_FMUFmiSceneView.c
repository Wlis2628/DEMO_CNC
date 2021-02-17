#include <bur/plctypes.h>
#include <sys_lib.h>
#include "CNC_FMULib.h"

#include <fmi2Functions.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

void CNC_FMUView(struct CNC_FMUView* fubInstance)
{
	if (fubInstance->Enable == 1) {
				
		if (fubInstance->InstRef->Fmi2.Enabled) {
			CNC_FMU_getMapleSimAuxiliaryData(fubInstance->InstRef->Fmi2.Instance, &(fubInstance->vInternal));
		}		
		
		
		int i;
		for (i=0; i <= 18; i++) {
			fubInstance->ObjPos[i] = (float)fubInstance->vInternal[i];
		}
		
		} else {

	}

}