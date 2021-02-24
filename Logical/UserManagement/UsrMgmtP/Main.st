
PROGRAM _INIT
	
	MpUserXLogin_0.Enable := 1;
	MpUserXLogin_0.MpLink := ADR(gUserXLogin);
	
	MpUserXManagerUI_0.Enable := 1;
	MpUserXManagerUI_0.MpLink := ADR(gUserXLogin);
	MpUserXManagerUI_0.UIConnect := ADR(MpUserXMgrUIConnect_0);
	MpUserXManagerUI_0.UISetup := MpUserXMgrUISetup_0;
	
	MpUserXLoginUI_0.Enable := 1;
	MpUserXLoginUI_0.MpLink := ADR(gUserXLogin);
	MpUserXLoginUI_0.UIConnect := ADR(MpUserXLoginUIConnect0);
	
	EditButtonEnabled := 1;
	RemoveButtonEnabled := 1;
	LoginButtonEnabled := 1;
	LoginButtonEnabled := 1;
	NewUserButtonEnabled := 1;
	DialogNewUserConfirmEnabled := 0;

	DialogEditUserConfirmEnabled := 0;
 	
	DateFirstLoginVisible := 1;
	LabelFirstLoginVisible := 0;

END_PROGRAM

PROGRAM _CYCLIC
	
	//DISPLAY SELECTED USER
	SelectedUser := MpUserXMgrUIConnect_0.User.List.UserNames[MpUserXMgrUIConnect_0.User.List.SelectedIndex];
	
	
	//DEFAULT DISPLAY ANONYMOUS
	IF MpUserXLoginUIConnect0.CurrentUser = "" THEN
		LoggedAs := "Anonymous";
	ELSE
		LoggedAs := MpUserXLoginUIConnect0.CurrentUser;
	END_IF;
	
	//ENABLING BUTTONS USER MENU
	IF MpUserXLoginUIConnect0.UserLevel = 100 THEN
		IF SelectedUser = "Administrator" OR SelectedUser = "Anonymous" OR SelectedUser = "Operator" THEN
			RemoveButtonEnabled := 0;
			EditButtonEnabled := 0;
			NewUserButtonEnabled := 1;
		ELSE
			EditButtonEnabled := 1;
			RemoveButtonEnabled := 1;
			NewUserButtonEnabled := 1;
		END_IF;
		
	ELSIF MpUserXLoginUIConnect0.UserLevel = 50 THEN 
		EditButtonEnabled := 0;
		RemoveButtonEnabled := 0;
		NewUserButtonEnabled := 1;
	ELSE
		EditButtonEnabled := 0;
		RemoveButtonEnabled := 0;
		NewUserButtonEnabled := 0;
	END_IF;
	
	
	//ENABLING BUTTONS MOREEE
	IF MpUserXLoginUIConnect0.UserLevel = 100 THEN
		Enable.ButonOpenExplorer := 1;
		Enable.ButtonAcknowledge := 1;
		Enable.ButtonAcknowledgeAll := 1;
		Enable.ButtonActivateTool := 1;
		Enable.ButtonConvert := 1;
		Enable.ButtonLoad := 1;
		Enable.ButtonRefresh := 1;
		Enable.ButtonResetErrors := 1;
		Enable.ButtonSave := 1;
		Enable.ButtonSaveGcode := 1;
		Enable.ButtonSaveGcodeAs := 1;
		Enable.ButtonStart := 1;
		Enable.ButtonTurnOff := 1;
		Enable.SetAcc := 1;
		Enable.SetDec := 1;
		Enable.SetVelocityLimit := 1;
		Enable.SetXPos := 1;
		Enable.SetXVelocity := 1;
		Enable.SetYPos := 1;
		Enable.SetYVelocity := 1;
		Enable.ButtonCreate := 1;
		Enable.TextInputCreate := 1;
		Enable.ButtonDelete := 1;

	ELSIF MpUserXLoginUIConnect0.UserLevel = 50 THEN 
		Enable.ButonOpenExplorer := 1;
		Enable.ButtonAcknowledge := 1;
		Enable.ButtonAcknowledgeAll := 1;
		Enable.ButtonActivateTool := 1;
		Enable.ButtonConvert := 1;
		Enable.ButtonLoad := 1;
		Enable.ButtonRefresh := 1;
		Enable.ButtonResetErrors := 1;
		Enable.ButtonSave := 1;
		Enable.ButtonSaveGcode := 1;
		Enable.ButtonSaveGcodeAs := 1;
		Enable.ButtonStart := 1;
		Enable.ButtonTurnOff := 1;
		Enable.SetAcc := 1;
		Enable.SetDec := 1;
		Enable.SetVelocityLimit := 0;
		Enable.SetXPos := 0;
		Enable.SetXVelocity := 1;
		Enable.SetYPos := 0;
		Enable.SetYVelocity := 1;
		Enable.ButtonCreate := 1;
		Enable.TextInputCreate := 1;
		Enable.ButtonDelete := 1;
	ELSE
		Enable.ButonOpenExplorer := 0;
		Enable.ButtonAcknowledge := 0;
		Enable.ButtonAcknowledgeAll := 0;
		Enable.ButtonActivateTool := 0;
		Enable.ButtonConvert := 0;
		Enable.ButtonLoad := 0;
		Enable.ButtonRefresh := 0;
		Enable.ButtonResetErrors := 0;
		Enable.ButtonSave := 0;
		Enable.ButtonSaveGcode := 0;
		Enable.ButtonSaveGcodeAs := 0;
		Enable.ButtonStart := 0;
		Enable.ButtonTurnOff := 0;
		Enable.SetAcc := 0;
		Enable.SetDec := 0;
		Enable.SetVelocityLimit := 0;
		Enable.SetXPos := 0;
		Enable.SetXVelocity := 0;
		Enable.SetYPos := 0;
		Enable.SetYVelocity := 0;
		Enable.ButtonCreate := 0;
		Enable.TextInputCreate := 0;
		Enable.ButtonDelete := 0;
	END_IF;

	//DISPALYING FIRST LOGIN DATE OR NO FIRST LOGIN LABEL
	IF MpUserXMgrUIConnect_0.User.Info.FirstLogin = DT#1970-01-01-00:00:00 THEN
		LabelFirstLoginVisible := 1;
		DateFirstLoginVisible := 0;
	ELSE
		LabelFirstLoginVisible := 0;
		DateFirstLoginVisible := 1;
	END_IF;
	
	
	//ENABLING LOGIN BUTTON 
	IF MpUserXLoginUIConnect0.Login.UserName = "" OR MpUserXLoginUIConnect0.Login.Password = "" THEN
		LoginButtonEnabled := 0;
	ELSE
		LoginButtonEnabled := 1;
	END_IF;
	
	//DISABLING LOGOUT BUTTON IF NOT LOGGED IN
	IF MpUserXLoginUIConnect0.LoggedIn = 0 THEN
		LogoutButtonEnabled := 0;
	ELSE 
		LogoutButtonEnabled := 1;
	END_IF;
	

	//NEW USER DIALOG ENABLING CONFIRM BUTTON
	IF (MpUserXMgrUIConnect_0.User.Create.Dialog.ConfirmPasswordOk = 1 AND MpUserXMgrUIConnect_0.User.Create.Dialog.UserNameOk = 1) THEN
		DialogNewUserConfirmEnabled := 1;
	ELSE
		DialogNewUserConfirmEnabled := 0;
	END_IF;
	
	//EDIT USER DIALOG ENABLING CONFIRM BUTTON
	IF (MpUserXMgrUIConnect_0.User.Edit.Dialog.ConfirmPasswordOk = 1 ) THEN
		DialogEditUserConfirmEnabled := 1;
	ELSE
		DialogEditUserConfirmEnabled := 0;
	END_IF;
	
	
	
	//DIALOG NEW USER DISPALY PASSWORD HINT
	IF MpUserXMgrUIConnect_0.User.Create.Dialog.CriteriaNotMet = mpUSERX_PASSWORD_CRIT_NONE THEN
		NewUserPasswordHint := "Password ok";
	ELSIF MpUserXMgrUIConnect_0.User.Create.Dialog.CriteriaNotMet = mpUSERX_PASSWORD_CRIT_LENGTH THEN
		NewUserPasswordHint := "Password too short";
	END_IF;
	
	//DIALOG NEW USER DISPLAY PASSWORDS MATCH INFO 
	IF MpUserXMgrUIConnect_0.User.Create.Dialog.NewPasswordOk = 1 AND MpUserXMgrUIConnect_0.User.Create.Dialog.ConfirmPasswordOk = 1 THEN
		NewUserPasswordOk := "Passwords match";
	ELSE
		NewUserPasswordOk := "Passwords do not match";
	END_IF;
	
	
	//USER GROUPS DISPLAY
	CASE MpUserXMgrUIConnect_0.User.Info.Roles[0] OF
		1:
			SelectedUserGroup := "Administrator";	
		2:
			SelectedUserGroup := "Anonymous";
		3:
			SelectedUserGroup := "Operator";
	END_CASE;
	
	//NEW USER ROLE
	MpUserXMgrUIConnect_0.User.Create.Dialog.Roles[0] := NewUserRoleIndex + 2;
	
	//EDITING USER ROLE
	MpUserXMgrUIConnect_0.User.Edit.Dialog.Roles[0] := EditUserRoleIndex + 2;
	
	//DIALOG EDIT USER DISPLAY PASSWORD HINT
	IF MpUserXMgrUIConnect_0.User.Edit.Dialog.CriteriaNotMet = mpUSERX_PASSWORD_CRIT_NONE THEN
		EditUserPasswordHint := "Password ok";
	ELSIF MpUserXMgrUIConnect_0.User.Edit.Dialog.CriteriaNotMet = mpUSERX_PASSWORD_CRIT_LENGTH THEN
		EditUserPasswordHint := "Password too short";
	END_IF;
	
	//DIALOG EDIT USER DISPLAY PASSWORDS MATCH INFO
	IF MpUserXMgrUIConnect_0.User.Edit.Dialog.NewPasswordOk = 1 AND MpUserXMgrUIConnect_0.User.Edit.Dialog.ConfirmPasswordOk = 1 THEN
		EditUserPasswordOk := "Passwords match";
	ELSE
		EditUserPasswordOk := "Passwords do not match";
	END_IF;
	
	//ERRORS 
	IF MpUserXLoginUIConnect0.MessageBox.ErrorNumber = 28673 THEN
		StringError := "User does not exist.";
	ELSIF MpUserXLoginUIConnect0.MessageBox.ErrorNumber = 28672 THEN
		StringError := "Password incorrect.";
	ELSE
		StringError := "No errors?";
	END_IF;
	
	//FUNCTION CALL
	MpUserXLogin_0();
	MpUserXLoginUI_0();
	MpUserXManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	
	MpUserXLogin_0.Enable := 0;
	MpUserXLogin_0();
	
	MpUserXLoginUI_0.Enable := 0;
	MpUserXLoginUI_0();
	
	MpUserXManagerUI_0.Enable := 0;
	MpUserXManagerUI_0();
	 
END_PROGRAM

