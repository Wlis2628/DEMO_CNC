(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Icmp_Ping
 * File: Icmp_Ping.st
 * Author: Bernecker + Rainer
 * Created: April 21, 2009
 ********************************************************************
 * Implementation of program Icmp_Ping
 ********************************************************************)

PROGRAM _INIT
	
	strcpy(ADR(Ping.Host),ADR('216.58.215.110'));
	
END_PROGRAM

PROGRAM _CYCLIC

	CASE Ping.step OF
		
		1:	(*Ping station*)
			Ping.IcmpPing_0.enable := 1;  (*Enables the FBK*)
			Ping.IcmpPing_0.pHost := ADR(Ping.Host);  (*IP address or name (SG4 only) of the station (host) that should be pinged*)
			Ping.IcmpPing_0.timeout := 5;  (*Response timeout. Specified in 10ms steps (1 = 10ms, 2 = 20ms, etc.). If 0 is specified, the default timeout (10ms) is used.*)
			
			Ping.IcmpPing_0;  (*Call FBK*)
			
			IF Ping.IcmpPing_0.status = 0 THEN  (*FBK finished, go to "wait" step*)
				Ping.step := 2;
			ELSIF Ping.IcmpPing_0.status = ERR_FUB_BUSY THEN  (*FBK still busy, call again*)	
				Ping.step := 1;
			ELSE  (*Go to error step*)
				Ping.step := 10;
			END_IF
			
		2:	(*Wait step*)
			Ping.step := 2;
						
		10:	(*Here some error handling has to be implemented*)

	END_CASE

END_PROGRAM
