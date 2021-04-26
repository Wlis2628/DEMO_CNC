(*********************************************************************************
 * Copyright:	Bernecker+Rainer
 * Author:		pawlikb
 * Created:		April 23, 2019/8:53 AM 
 * Description:	
 *			What:	Task handles e-mail notfications about active alarms.
 *			How:	Timer is counting up to INTERVAL_TIME. During this time active
					alarms are registered and then the e-mail with combined information is sent
					and the timer is reset.
 *			Limits:	It is necessary to provide Internet access for the PLC.
					When used with SiteManager the default gateway must be set to DEV IP of the SiteManager,
					and Routing (Scada) Agent must be configured. Please see attached documentation.
					
 *********************************************************************************)

PROGRAM _INIT
	(* Smtp default configuration *)
	Smtp.Parameters.Host		:=	HOST;
	Smtp.Parameters.User		:=	USER;
	Smtp.Parameters.Password	:=	PASSWORD;
	Smtp.Parameters.Sender		:=	SENDER;
	Smtp.Parameters.Receiver	:=	RECEIVER;
	Smtp.Parameters.Subject		:=	SUBJECT;
	Smtp.Parameters.Text		:=	HEADER;
	Smtp.Parameters.Domain		:=	DOMAIN;				//Usually domain name is not needed
	Smtp.Parameters.Timeout		:=	0;					//If 0 specified then default 120s is used
	Smtp.Parameters.Port		:=	PORT;				//If 0 specified then default port for SMTP (25) is used
	
	(* Attachment *)
	Smtp.Parameters.AttachmentCnt		:=	0;
	Smtp.Parameters.Attachment.type		:=	smtpATT_TYPE_DATMOD; 
	Smtp.Parameters.Attachment.pData	:=	ADR('DatObj');
	
	(* Timer configuration - get task class cycle time *)
	Smtp.FB.RTInfo.enable	:=	TRUE;
	Smtp.FB.RTInfo();
	
END_PROGRAM

PROGRAM _CYCLIC
	
//	(* Increment timer *)
//	Smtp.Status.Timer	:=	Smtp.Status.Timer + Smtp.FB.RTInfo.cycle_time/1000;
//	
//	(* Reset timer and send e-mail *)
//	IF Smtp.Status.Timer >= (INTERVAL_TIME * 60) THEN
//		Smtp.Status.Timer	:=	0;
//		
//		(* Send email if any alarm was set *)
//		IF Smtp.Status.AlarmActive THEN
////			Smtp.Cmd.Send		:=	TRUE;
////			Smtp.Cmd.SendSSL	:=	TRUE;
//		END_IF;
//	END_IF;
//	
//	(* Check for active alarms *)
//	Smtp.Status.AlarmActive	:=	FALSE;
//	FOR i:=0 TO 10 DO
////		Smtp.Status.AlarmActive	:=	Smtp.Status.AlarmActive	OR	[i];
//		
//	END_FOR;
	
	
	(* Disable function blocks - will be enabled in a state machine *)
	Smtp.FB.SmtpSend.enable		:=	FALSE;
	Smtp.FB.SmtpsSend.enable	:=	FALSE;
	
	(* State machine *)
	CASE Smtp.Status.State OF
		
		STATE_SMTP_WAIT:
			(* Command send via SMTP *)
			IF Smtp.Cmd.Send THEN
				(* Prepare message *)
				actText;
				(* Send *)
				Smtp.Status.State	:=	STATE_SMTP_SEND;
			END_IF;
			
			(* Command send via SMTP with encryption *)
			IF Smtp.Cmd.SendSSL THEN
				(* Prepare message *)
				actText;
				(* Send *)
				Smtp.Status.State	:=	STATE_SMTP_SEND_SSL;
			END_IF;
			
		STATE_SMTP_SEND:
			(* Enable function block *)
			Smtp.FB.SmtpSend.enable	:=	TRUE;
			
			(* Assign Mail Parameters *)
			Smtp.FB.SmtpSend.pHost			:=	ADR(Smtp.Parameters.Host);
			Smtp.FB.SmtpSend.pUser			:=	0;	//ADR(Smtp.Parameters.User);
			Smtp.FB.SmtpSend.pPassword		:=	0;	//ADR(Smtp.Parameters.Password);
			Smtp.FB.SmtpSend.pSender		:=	ADR(Smtp.Parameters.Sender);
			Smtp.FB.SmtpSend.pReceiver		:=	ADR(Smtp.Parameters.Receiver);
			Smtp.FB.SmtpSend.pSubject		:=	ADR(Smtp.Parameters.Subject);
			Smtp.FB.SmtpSend.pText			:=	ADR(Smtp.Parameters.Text);
			Smtp.FB.SmtpSend.pDomain		:=	0;	//ADR(Smtp.Parameters.Domain);
			Smtp.FB.SmtpSend.pAttachment	:=	ADR(Smtp.Parameters.Attachment);
			Smtp.FB.SmtpSend.attcnt			:=	Smtp.Parameters.AttachmentCnt;
			Smtp.FB.SmtpSend.timeout		:=	Smtp.Parameters.Timeout;
			Smtp.FB.SmtpSend.port			:=	Smtp.Parameters.Port;
			
			(* Jump Conditions *)
			IF Smtp.FB.SmtpSend.status = ERR_OK THEN
				Smtp.FB.SmtpSend.enable	:=	FALSE;
				Smtp.Status.State		:=	STATE_SMTP_WAIT;
			ELSIF Smtp.FB.SmtpSend.status = ERR_FUB_BUSY THEN
				(* BUSY *)
			ELSE
				Smtp.Status.State	:=	STATE_SMTP_ERROR;
			END_IF;
			
		STATE_SMTP_SEND_SSL:
			(* Enable function block *)
			Smtp.FB.SmtpsSend.enable	:=	TRUE;
			
			(* Assign Mail Parameters *)
			Smtp.FB.SmtpsSend.pHost			:=	ADR(Smtp.Parameters.Host);
			Smtp.FB.SmtpsSend.pUser			:=	ADR(Smtp.Parameters.User);
			Smtp.FB.SmtpsSend.pPassword		:=	ADR(Smtp.Parameters.Password);
			Smtp.FB.SmtpsSend.pSender		:=	ADR(Smtp.Parameters.Sender);
			Smtp.FB.SmtpsSend.pReceiver		:=	ADR(Smtp.Parameters.Receiver);
			Smtp.FB.SmtpsSend.pSubject		:=	ADR(Smtp.Parameters.Subject);
			Smtp.FB.SmtpsSend.pText			:=	ADR(Smtp.Parameters.Text);
			Smtp.FB.SmtpsSend.pDomain		:=	ADR(Smtp.Parameters.Domain);
			Smtp.FB.SmtpsSend.pAttachment	:=	ADR(Smtp.Parameters.Attachment);
			Smtp.FB.SmtpsSend.attcnt		:=	Smtp.Parameters.AttachmentCnt;
			Smtp.FB.SmtpsSend.timeout		:=	Smtp.Parameters.Timeout;
			Smtp.FB.SmtpsSend.port			:=	Smtp.Parameters.Port;
			Smtp.FB.SmtpsSend.sslCfgIdent	:=	0;	//Default SSL Configuration
			
			(* Jump Conditions *)
			IF Smtp.FB.SmtpsSend.status	= ERR_OK THEN
				Smtp.FB.SmtpsSend.enable	:=	FALSE;
				Smtp.Status.State	:=	STATE_SMTP_WAIT;
			ELSIF Smtp.FB.SmtpsSend.status	=	ERR_FUB_BUSY THEN
				(* BUSY *)
			ELSE
				Smtp.Status.State	:=	STATE_SMTP_ERROR;
			END_IF;
			
			
		STATE_SMTP_ERROR:			
			(* Auto reset *)
			Smtp.Cmd.ErrorReset	:=	TRUE;
			
			(* Command error reset *)
			IF Smtp.Cmd.ErrorReset THEN
				Smtp.Status.State	:=	STATE_SMTP_WAIT;
			END_IF;

	END_CASE;
	
	(* Call Function Blocks *)
	Smtp.FB.SmtpSend();
	Smtp.FB.SmtpsSend();
	
	(* Reset Commands *)
	IF Smtp.Cmd.Send AND Smtp.Status.State = STATE_SMTP_SEND THEN
		Smtp.Cmd.Send		:=	FALSE;
	END_IF;
	
	IF Smtp.Cmd.SendSSL AND Smtp.Status.State = STATE_SMTP_SEND_SSL THEN
		Smtp.Cmd.SendSSL	:=	FALSE;
	END_IF;
	
	IF Smtp.Cmd.ErrorReset AND Smtp.Status.State = STATE_SMTP_WAIT THEN
		Smtp.Cmd.ErrorReset	:=	FALSE;
	END_IF;	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Disable function blocks *)
	Smtp.FB.SmtpSend	(enable	:=	FALSE);
	Smtp.FB.SmtpsSend	(enable	:=	FALSE);
	 
END_PROGRAM

