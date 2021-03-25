(*********************************************************************************
 * Copyright:	Bernecker+Rainer
 * Author:		pawlikb
 * Created:		April 23, 2019/9:41 AM 
 * Description:	
 *			What:	Action prepares text for the email
 *			How:	Checks if alarm was set, if yes then it appends appropriate message
 *			Limits:	
 *********************************************************************************)

ACTION actText: 

	(* Header *)
	//Smtp.Parameters.Text	:=	HEADER;
	
	(* Check and append main text *)
	
	(* Footer *)
//	brsstrcat(ADR(Smtp.Parameters.Text),ADR(FOOTER));
	
END_ACTION
