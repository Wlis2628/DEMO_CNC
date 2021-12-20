
PROGRAM _INIT
	
	MpAlarmXCoreGeneral.Enable := TRUE;
	MpAlarmXCoreGeneral.MpLink := ADR(gAlarmXGeneral);
	
	MpAlarmXCoreFile.Enable := TRUE;
	MpAlarmXCoreFile.MpLink := ADR(gAlarmXFile);
	
	MpAlarmXCoreCnc.Enable := TRUE;
	MpAlarmXCoreCnc.MpLink := ADR(gAlarmXCnc);
	
	MpAlarmXCoreGlobal.Enable := TRUE;
	MpAlarmXCoreGlobal.MpLink := ADR(gAlarmXCoreGlobal);
	
	MpAlarmXHistoryGlobal.Enable := TRUE;
	MpAlarmXHistoryGlobal.MpLink := ADR(gAlarmXHistory);
END_PROGRAM

PROGRAM _CYCLIC
	
	
	IF MpAlarmXCoreGlobal.ActiveAlarms>0 OR MpAlarmXCoreGlobal.PendingAlarms>0  THEN
		gAlarmActive:=TRUE;
	ELSE
		gAlarmActive:=FALSE;
	END_IF;
	
	MpAlarmXCoreGeneral();
	MpAlarmXCoreFile();
	MpAlarmXCoreCnc();
	MpAlarmXCoreGlobal();
	MpAlarmXHistoryGlobal(); 
	

END_PROGRAM

PROGRAM _EXIT

	MpAlarmXCoreGlobal.Enable := FALSE;

	MpAlarmXCoreFile.Enable := FALSE;
	MpAlarmXCoreCnc.Enable := FALSE;
	MpAlarmXCoreGeneral.Enable := FALSE;

	MpAlarmXHistoryGlobal.Enable := FALSE;

	MpAlarmXCoreGeneral();
	MpAlarmXCoreFile();
	MpAlarmXCoreCnc();
	MpAlarmXCoreGlobal();
	MpAlarmXHistoryGlobal(); 
	
END_PROGRAM

