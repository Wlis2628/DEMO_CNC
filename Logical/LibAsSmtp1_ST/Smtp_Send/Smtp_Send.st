(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Smtp_Send
 * File: Smtp_Send.st
 * Author: Bernecker + Rainer
 * Created: April 17, 2009
 ********************************************************************
 * Implementation of program Smtp_Send
 ********************************************************************)

PROGRAM _INIT
	
	strcpy(ADR(Smtp.Parameter.Host),ADR('127.0.0.1'));
	strcpy(ADR(Smtp.Parameter.Sender),ADR('lis.weronika.m@gmail.com'));
	strcpy(ADR(Smtp.Parameter.Receiver),ADR('lis.weronika.m@gmail.com'));	strcpy(ADR(Smtp.Parameter.Subject),ADR('Example mail'));
	strcpy(ADR(Smtp.Parameter.Text),ADR('This text is sent in an email using the AsSmtp library.    Attachment:  '));
	
END_PROGRAM

PROGRAM _CYCLIC

	CASE Smtp.step OF
		
		1:	(*Send mail*)
			Smtp.SmtpSend_0.enable := 1;  (*Enables the FBK.*)
			Smtp.SmtpSend_0.pHost := ADR(Smtp.Parameter.Host);  (*IP adress of the SMTP server.*)	
			
			Smtp.SmtpSend_0.pUser := 0;  (*User name, optional. If 0 is specified, authentication does not take place.*)
			Smtp.SmtpSend_0.pPassword := 0;  (*Password,  optional. If 0 is specified, authentication does not take place.*)
			
			Smtp.SmtpSend_0.pSender := ADR(Smtp.Parameter.Sender);  (*Sender name*)
			Smtp.SmtpSend_0.pReceiver := ADR(Smtp.Parameter.Receiver);  (*Receiver string, can also contain several recipients that are separated by ',' or a space.*)
			Smtp.SmtpSend_0.pSubject := ADR(Smtp.Parameter.Subject);  (*Subject string*)							
			Smtp.SmtpSend_0.pText := ADR(Smtp.Parameter.Text);  (*Text string*)
			
			Smtp.SmtpSend_0.pDomain := 0;  (*Sender domain name, optional, If 0 is specified, "[127.0.0.1]" is entered as the sender domain name.*)
			
			(*Attachment structure*)
			Smtp.SmtpAttachment.type := smtpATT_TYPE_DATMOD;  (*Type of attachment.*)
			Smtp.SmtpAttachment.pData := ADR('DatObj');  (*Data source of attachment.*)
			Smtp.SmtpAttachment.pName := 0;  (*Name of attachment, optional.*)
			Smtp.SmtpAttachment.length := 0;  (*Length of attachment.*)			
			
			(*Attachment*)
			Smtp.SmtpSend_0.pAttachment := ADR(Smtp.SmtpAttachment);  (*Pointer to attachment structure.*)  
			Smtp.SmtpSend_0.attcnt := 1;  (*Number of attachments.*)
						
			Smtp.SmtpSend_0.timeout := 0;  (*Server response timeout, optional. If 0 is specified, the default timeout of 120s is used.*)
			Smtp.SmtpSend_0.port := 0;  (*Server port number, optional. If 0 is specified, the default port is used (SMTP: 25).*)
			
			Smtp.SmtpSend_0;  (*Call FBK*)
			
			IF Smtp.SmtpSend_0.status = 0 THEN  (*FBK finished, go to wait step.*)
				Smtp.step := 2;
			ELSIF Smtp.SmtpSend_0.status = ERR_FUB_BUSY THEN  (*FBK still busy, call again.*)	
				Smtp.step := 1;
			ELSE  (*Go to error step.*)
				Smtp.step := 10;
			END_IF
		
		2:	(*Wait step*)
			Smtp.step := 2;
						
		10:	(*Here some error handling has to be implemented.*)

	END_CASE

END_PROGRAM
