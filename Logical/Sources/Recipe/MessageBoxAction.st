
ACTION MaxNumOfRecipes: 
	
	// Messagebox informs that the maximum number of recipes has been reached
	IF UIConnect.Recipe.List.MaxSelection>=5 AND CreatingRecipe  THEN
		gMsgBox4:=TRUE;
		CreatingRecipe := FALSE;
	END_IF;
	
END_ACTION
