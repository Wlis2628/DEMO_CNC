
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

END_PROGRAM

PROGRAM _CYCLIC
	
	//DISPLAY SELECTED USER
	SelectedUser := MpUserXMgrUIConnect_0.User.List.UserNames[MpUserXMgrUIConnect_0.User.List.SelectedIndex];
	
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

