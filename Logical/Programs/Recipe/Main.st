
PROGRAM _INIT
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	// basic settings for recipes
	MpRecipeXml_0(MpLink:= ADR(gRecipeXml), Enable := TRUE, DeviceName := ADR('CF'), FileName := ADR('recipe') );
	 
	MpRecipeRegPar_0(MpLink:= ADR(gRecipeXml), Enable := TRUE, PVName := ADR('gParameter') );
	
	MpRecipeUI_0(MpLink:= ADR(gRecipeXml), Enable := TRUE, UISetup := UISetup, UIConnect := ADR(UIConnect));

	UIConnect.Recipe.Filter:='*.xml';

	
	ConnectWords;
	MaxNumOfRecipes;

END_PROGRAM


PROGRAM _EXIT

	MpRecipeXml_0.Save:= TRUE;
	MpRecipeXml_0.Enable:=FALSE;
	MpRecipeXml_0();
	
	MpRecipeRegPar_0.Enable:=FALSE;
	MpRecipeRegPar_0();
	
END_PROGRAM

