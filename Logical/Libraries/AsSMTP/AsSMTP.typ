                                                                      
TYPE
    smtpATTACHMENT_typ	: STRUCT		(*attachments*)
		type			: UDINT;		(*type of attachment (file, module or memory area)*)
		pData			: UDINT;		(*pointer to the data (depends on attachment type: filename, modulename or memory address)*)
		length			: UDINT;		(*length of memory (only for memory attachments)*)
		pName			: UDINT;		(*name of attachment (optional, default: filename, modulename or mematt_<# of attachment>)*)
	END_STRUCT;
END_TYPE
