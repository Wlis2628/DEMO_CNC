(**** SMTP ****)

TYPE
	SmtpType : 	STRUCT 
		Parameters : SmtpParametersType;
		Status : SmtpStatusType;
		Cmd : SmtpCmdType;
		FB : SmtpFBType;
	END_STRUCT;
	SmtpParametersType : 	STRUCT 
		Host : STRING[80];
		User : STRING[80];
		Password : STRING[80];
		Sender : STRING[80];
		Receiver : STRING[80];
		Text : STRING[255];
		Subject : STRING[80];
		Attachment : smtpATTACHMENT_typ;
		AttachmentCnt : USINT;
		Domain : STRING[80];
		Timeout : UDINT;
		Port : UINT;
	END_STRUCT;
	SmtpStatusType : 	STRUCT 
		State : SmtpStatusStateEnum;
		Timer : UDINT;
		AlarmActive : BOOL;
	END_STRUCT;
	SmtpStatusStateEnum : 
		(
		STATE_SMTP_WAIT,
		STATE_SMTP_SEND,
		STATE_SMTP_SEND_SSL,
		STATE_SMTP_ERROR
		);
	SmtpCmdType : 	STRUCT 
		SendSSL : BOOL;
		Send : BOOL;
		ErrorReset : BOOL;
	END_STRUCT;
	SmtpFBType : 	STRUCT 
		SmtpSend : SmtpSend;
		SmtpsSend : SmtpsSend;
		RTInfo : RTInfo;
	END_STRUCT;
END_TYPE
