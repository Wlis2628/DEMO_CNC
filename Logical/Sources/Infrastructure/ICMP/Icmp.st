(*********************************************************************************
 * Copyright:	Bernecker+Rainer 
 * Author:		pawlikb 
 * Created:		January 8, 2020/3:17 PM 
 * Description:	
 *			What:	Ping
 *			How:	AsICMP
 *			Limits:	
 *********************************************************************************)
PROGRAM _INIT	
	(* Default values *)
	Icmp.Parameter.Timeout	:=	DEFAULT_TIMEOUT;	

END_PROGRAM

PROGRAM _CYCLIC
	
	(* State machine *)
	CASE Icmp.Status.State OF
		
		STATE_ICMP_WAIT:
			(* Command Ping *)
			IF Icmp.Cmd.Ping THEN
				Icmp.Cmd.Ping				:=	FALSE;
				Icmp.FB.IcmpPing.timeout	:=	Icmp.Parameter.Timeout/10;
				Icmp.Status.State			:=	STATE_ICMP_PING;
			END_IF;
			
		STATE_ICMP_PING:
			(* Configure function block *)
			Icmp.FB.IcmpPing.enable	:=	TRUE;
			Icmp.FB.IcmpPing.pHost	:=	ADR(Icmp.Parameter.Host);
			
			(* Call function block *)
			Icmp.FB.IcmpPing();
		
			(* Jump conditions *)
			IF Icmp.FB.IcmpPing.status = ERR_OK THEN
				Icmp.Status.Result			:=	Icmp.FB.IcmpPing.timeout *10;	//1 = 10ms
				Icmp.FB.IcmpPing.timeout	:=	Icmp.FB.IcmpPing.timeout -1;	//Decrease timeout
				Icmp.FB.IcmpPing.enable		:=	FALSE;
				Icmp.Status.State			:=	STATE_ICMP_PING;
				
				(* Response time < 10ms. If zero is specified default timeout is used = 10ms *)
				IF Icmp.FB.IcmpPing.timeout > Icmp.Parameter.Timeout THEN
					Icmp.Status.Result	:=	10;
					Icmp.Status.State	:=	STATE_ICMP_WAIT;
				END_IF;
				
			ELSIF Icmp.FB.IcmpPing.status = ERR_FUB_BUSY THEN
				(* BUSY *)
				
			ELSIF Icmp.FB.IcmpPing.status = icmpERR_NO_RESPONSE THEN
				Icmp.FB.IcmpPing.enable		:=	FALSE;
				Icmp.Status.State			:=	STATE_ICMP_WAIT;
				
			ELSE
				Icmp.FB.IcmpPing.enable		:=	FALSE;
				Icmp.Status.State			:=	STATE_ICMP_WAIT;		
			END_IF;
	END_CASE;
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

