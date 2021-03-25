/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASSMTP_
#define _ASSMTP_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <runtime.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define smtpATT_TYPE_MEMORY 3U
 #define smtpATT_TYPE_DATMOD 2U
 #define smtpATT_TYPE_FILE 1U
 #define smtpERR_SYSTEM 32749U
 #define smtpERR_ATTACHMENT_INVALID 32707U
 #define smtpERR_AUTHENTICATION_FAILED 32706U
 #define smtpERR_AUTHENTICATION_METHOD 32705U
 #define smtpERR_RESPONSE_UNEXPECTED 32704U
 #define smtpERR_RESPONSE_TIMEOUT 32703U
 #define smtpERR_SOCKET_CONNECT 32702U
 #define smtpERR_SOCKET_CREATE 32701U
 #define smtpERR_PARAMETER 32700U
#else
 _IEC_CONST unsigned char smtpATT_TYPE_MEMORY = 3U;
 _IEC_CONST unsigned char smtpATT_TYPE_DATMOD = 2U;
 _IEC_CONST unsigned char smtpATT_TYPE_FILE = 1U;
 _IEC_CONST unsigned short smtpERR_SYSTEM = 32749U;
 _IEC_CONST unsigned short smtpERR_ATTACHMENT_INVALID = 32707U;
 _IEC_CONST unsigned short smtpERR_AUTHENTICATION_FAILED = 32706U;
 _IEC_CONST unsigned short smtpERR_AUTHENTICATION_METHOD = 32705U;
 _IEC_CONST unsigned short smtpERR_RESPONSE_UNEXPECTED = 32704U;
 _IEC_CONST unsigned short smtpERR_RESPONSE_TIMEOUT = 32703U;
 _IEC_CONST unsigned short smtpERR_SOCKET_CONNECT = 32702U;
 _IEC_CONST unsigned short smtpERR_SOCKET_CREATE = 32701U;
 _IEC_CONST unsigned short smtpERR_PARAMETER = 32700U;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct smtpATTACHMENT_typ
{	unsigned long type;
	unsigned long pData;
	unsigned long length;
	unsigned long pName;
} smtpATTACHMENT_typ;

typedef struct SmtpSend
{
	/* VAR_INPUT (analog) */
	unsigned long pHost;
	unsigned long pUser;
	unsigned long pPassword;
	unsigned long pSender;
	unsigned long pReceiver;
	unsigned long pSubject;
	unsigned long pText;
	unsigned long pDomain;
	unsigned long pAttachment;
	unsigned long pSecurity;
	unsigned long timeout;
	unsigned short port;
	unsigned char attcnt;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} SmtpSend_typ;



/* Prototyping of functions and function blocks */
void SmtpSend(struct SmtpSend* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASSMTP_ */

                                                           
