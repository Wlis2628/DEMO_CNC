
TYPE
	IcmpType : 	STRUCT 
		Parameter : IcmpParameterType;
		Cmd : IcmpCmdType;
		Status : IcmpStatusType;
		FB : IcmpFBType;
	END_STRUCT;
	IcmpParameterType : 	STRUCT 
		Host : STRING[80];
		Timeout : UINT; (*1 = 10ms*)
	END_STRUCT;
	IcmpCmdType : 	STRUCT 
		Ping : BOOL;
	END_STRUCT;
	IcmpStatusType : 	STRUCT 
		State : IcmpStatusStateEnum;
		Result : UINT;
	END_STRUCT;
	IcmpStatusStateEnum : 
		(
		STATE_ICMP_WAIT,
		STATE_ICMP_PING
		);
	IcmpFBType : 	STRUCT 
		IcmpPing : IcmpPing;
	END_STRUCT;
END_TYPE
