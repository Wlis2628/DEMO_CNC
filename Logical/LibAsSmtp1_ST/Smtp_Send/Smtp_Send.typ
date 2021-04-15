(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Smtp_Send
 * File: Smtp_Send.typ
 * Author: Bernecker + Rainer
 * Created: April 17, 2009
 ********************************************************************
 * Local data types of program Smtp_Send
 ********************************************************************)

TYPE
	Smtp_typ : 	STRUCT 
		step : UINT; (*Step variable*)
		SmtpSend_0 : SmtpSend; (*Function block SmtpSend*)
		SmtpAttachment : smtpATTACHMENT_typ; (*Attachment variable*)
		Parameter : Parameter_typ; (*Parameter variable*)
	END_STRUCT;
	Parameter_typ : 	STRUCT  (*Parameter structure*)
		Host : STRING[80]; (*Host name*)
		Sender : STRING[80]; (*Name of the sender*)
		Receiver : STRING[80]; (*Name of the receiver*)
		Subject : STRING[80]; (*Subject name*)
		Text : STRING[200]; (*Text in email*)
	END_STRUCT;
END_TYPE
