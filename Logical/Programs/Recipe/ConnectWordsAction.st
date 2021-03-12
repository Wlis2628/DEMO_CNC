
ACTION ConnectWords: 
	
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
	
END_ACTION
