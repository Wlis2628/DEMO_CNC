
PROGRAM _INIT
	gParameter;
	UISetup.RecipeListSize	:= 20;
	i; // selected index
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	// basic settings for recipes
	MpRecipeXml_0(MpLink := ADR(gRecipeXml), Enable := TRUE, DeviceName := ADR('CF'), FileName := ADR('recipe') );
	 
	MpRecipeRegPar_0(MpLink := ADR(gRecipeXml), Enable := TRUE, PVName := ADR('gParameter') );
	
	MpRecipeUI_0(MpLink := ADR(gRecipeXml), Enable := TRUE, UISetup := UISetup, UIConnect := ADR(UIConnect));

	UIConnect.Recipe.Filter:='*.xml';
	
	FOR k:=0 TO 4 DO
		memset(ADR(TempLine[k]),0,SIZEOF(TempLine[k]));
		memset(ADR(DataProvider0[k]),0, SIZEOF(DataProvider0[k]));
	END_FOR;
	
	
	FOR i:=0 TO 4 DO
		TempLine[0]:='{"value":"';	
		TempLine[1]:=INT_TO_STRING(i);
		TempLine[2]:='","text":"';
		TempLine[3]:=UIConnect.Recipe.List.Names[i];
		TempLine[4]:='"}';
		
		nextAddr:=strcat(ADR(DataProvider0[i]), ADR(TempLine[0]));
		
		FOR j:=1 TO 4 DO
			strcat(nextAddr,ADR(TempLine[j]));	
		END_FOR;
		
	END_FOR;

	// Messagebox informs that the maximum number of recipes has been reached

	
	IF UIConnect.Recipe.List.MaxSelection>=5 AND CreatingRecipe  THEN
		gMsgBox4:=TRUE;
		CreatingRecipe := FALSE;
	END_IF;
	

	
	
	
	
		END_PROGRAM


PROGRAM _EXIT

	MpRecipeXml_0.Save					:= TRUE;
	MpRecipeXml_0.Enable				:=FALSE;
	MpRecipeXml_0();
	
	MpRecipeRegPar_0.Enable				:=FALSE;
	MpRecipeRegPar_0();
	 
		END_PROGRAM

