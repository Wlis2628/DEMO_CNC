(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Icmp_Ping
 * File: Icmp_Ping.typ
 * Author: Bernecker + Rainer
 * Created: April 21, 2009
 ********************************************************************
 * Local data types of program Icmp_Ping
 ********************************************************************)

TYPE
	Ping_typ : 	STRUCT 
		step : UINT; (*Step variable*)
		IcmpPing_0 : IcmpPing; (*Function block IcmpPing*)
		Host : STRING[80]; (*Host name*)
	END_STRUCT;
END_TYPE
