
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif


void _CYCLIC ProgramCyclic(void)
{
	CNC_FMU(&CNC_FMU1);
	
	CNC_FMUView_0 .InstRef = CNC_FMU1.InstRef;
	
	CNC_FMUView(&CNC_FMUView_0 );
}
