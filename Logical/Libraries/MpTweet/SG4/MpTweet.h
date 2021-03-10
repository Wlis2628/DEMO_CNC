/* Automation Studio generated header file */
/* Do not edit ! */
/* MpTweet 5.12.2 */

#ifndef _MPTWEET_
#define _MPTWEET_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpTweet_VERSION
#define _MpTweet_VERSION 5.12.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpTweetCommandRequestEnum
{	mpTWEET_CMD_REQUEST_SUCCESS = 0
} MpTweetCommandRequestEnum;

typedef enum MpTweetUIMessageEnum
{	mpTWEET_UI_MSG_NONE = 0,
	mpTWEET_UI_MSG_ERROR = 1,
	mpTWEET_UI_MSG_CONFIRM_DELETE = 2,
	mpTWEET_UI_MSG_CONFIRM_CREATE = 3,
	mpTWEET_UI_MSG_CONFIRM_EDIT = 4
} MpTweetUIMessageEnum;

typedef enum MpTweetUISubscriberTypeEnum
{	mpTWEET_RECEIVE_ONLY = 0,
	mpTWEET_CONIFIRMATION_OF_RECEIPT = 1
} MpTweetUISubscriberTypeEnum;

typedef enum MpTweetUIStatusEnum
{	mpTWEET_CORE_UI_IDLE = 0,
	mpTWEET_CORE_UI_ACTIVE = 1,
	mpTWEET_CORE_UI_ERROR = 99
} MpTweetUIStatusEnum;

typedef enum MpTweetErrorEnum
{	mpTWEET_NO_ERROR = 0,
	mpTWEET_ERR_ACTIVATION = -1064239103,
	mpTWEET_ERR_MPLINK_NULL = -1064239102,
	mpTWEET_ERR_MPLINK_INVALID = -1064239101,
	mpTWEET_ERR_MPLINK_CHANGED = -1064239100,
	mpTWEET_ERR_MPLINK_CORRUPT = -1064239099,
	mpTWEET_ERR_MPLINK_IN_USE = -1064239098,
	mpTWEET_ERR_PAR_NULL = -1064239097,
	mpTWEET_ERR_CONFIG_INVALID = -1064239091,
	mpTWEET_ERR_RECEIVER_INVALID = -1064128512,
	mpTWEET_ERR_REQUEST_INVALID = -1064128511,
	mpTWEET_INF_WAIT_FOR_SERVER = 1083355138,
	mpTWEET_ERR_MESSAGE_SEND_FAIL = -1064128509,
	mpTWEET_ERR_PING_TIMEOUT = -1064128508,
	mpTWEET_ERR_COMMUNICATION_FAIL = -1064128507,
	mpTWEET_ERR_MISSING_UICONNECT = -1064128506,
	mpTWEET_INF_WAIT_CORE_FB = 1083355143
} MpTweetErrorEnum;

typedef enum MpTweetAlarmEnum
{	mpTWEET_ALM_MESSAGE_SEND_FAIL = 0,
	mpTWEET_ALM_PING_TIMEOUT = 1
} MpTweetAlarmEnum;

typedef struct MpTweetSendMessageType
{	plcstring Receiver[101];
	plcstring Message[256];
} MpTweetSendMessageType;

typedef struct MpTweetCoreParType
{	struct MpTweetSendMessageType Message;
	plctime PingTimeout;
} MpTweetCoreParType;

typedef struct MpTweetReceivedMessageType
{	plcstring Sender[101];
	plcstring Message[256];
	plcdt TimeStamp;
} MpTweetReceivedMessageType;

typedef struct MpTweetPendingRequestType
{	plcstring RequestID[321];
	plcstring RequestMessage[321];
	plcstring ReturnMessage[321];
	plcdt ReceivedTimeStamp;
	plcstring Sender[101];
} MpTweetPendingRequestType;

typedef struct MpTweetPendingConfirmationType
{	plcstring Sender[101];
	plcbit Timeout;
	plcstring Receiver[101];
	plcdt SentTimeStamp;
} MpTweetPendingConfirmationType;

typedef struct MpTweetInfoMessageType
{	struct MpTweetPendingRequestType PendingRequests[10];
	struct MpTweetReceivedMessageType Received[10];
	struct MpTweetPendingConfirmationType PendingConfirmationReceipts[10];
} MpTweetInfoMessageType;

typedef struct MpTweetStatusIDType
{	enum MpTweetErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpTweetStatusIDType;

typedef struct MpTweetInternalType
{	signed long ID;
	MpComSeveritiesEnum Severity;
	MpComFacilitiesEnum Facility;
	unsigned short Code;
} MpTweetInternalType;

typedef struct MpTweetDiagType
{	struct MpTweetStatusIDType StatusID;
	struct MpTweetInternalType Internal;
} MpTweetDiagType;

typedef struct MpTweetCoreInfoType
{	unsigned long SentMessages;
	unsigned long ReceivedMessages;
	unsigned char PendingRequests;
	struct MpTweetInfoMessageType Messages;
	struct MpTweetDiagType Diag;
	plctime TimeUntilNextReceive;
} MpTweetCoreInfoType;

typedef struct MpTweetUISetupConfirmType
{	plcbit ReceiverCreate;
	plcbit ReceiverDelete;
	plcbit ReceiverEdit;
} MpTweetUISetupConfirmType;

typedef struct MpTweetCoreUISetupType
{	unsigned short ReceiverListSize;
	unsigned char ReceiverListScrollWindow;
	struct MpTweetUISetupConfirmType Confirmation;
} MpTweetCoreUISetupType;

typedef struct MpTweetUIReceiverListType
{	plcstring ReceiverNames[20][101];
	unsigned short MaxSelection;
	unsigned short SelectedIndex;
	plcbit PageUp;
	plcbit PageDown;
	plcbit StepUp;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpTweetUIReceiverListType;

typedef struct MpTweetUIReceiverInfoType
{	plcstring Name[101];
	plcstring PhoneNumber[21];
	plcstring Language[21];
} MpTweetUIReceiverInfoType;

typedef struct MpTweetUIReceiverCreateDlgType
{	unsigned short LayerStatus;
	struct MpTweetUIReceiverInfoType Details;
	plcbit Confirm;
	plcbit Cancel;
} MpTweetUIReceiverCreateDlgType;

typedef struct MpTweetUIReceiverCreateType
{	plcbit ShowDialog;
	struct MpTweetUIReceiverCreateDlgType Dialog;
} MpTweetUIReceiverCreateType;

typedef struct MpTweetUIReceiverType
{	struct MpTweetUIReceiverListType List;
	struct MpTweetUIReceiverInfoType Info;
	struct MpTweetUIReceiverCreateType Create;
	struct MpTweetUIReceiverCreateType Edit;
	plcbit Delete;
} MpTweetUIReceiverType;

typedef struct MpTweetUIMessageBoxType
{	unsigned short LayerStatus;
	enum MpTweetUIMessageEnum Type;
	signed long StatusID;
	unsigned short ErrorNumber;
	plcbit Confirm;
	plcbit Cancel;
} MpTweetUIMessageBoxType;

typedef struct MpTweetUIReceiptConfirmationType
{	plcstring ExpectedResponse[21];
	unsigned char ResponseTimeout;
	unsigned char Attempts;
	plcbit Lock;
} MpTweetUIReceiptConfirmationType;

typedef struct MpTweetUISubscriberType
{	plcstring Name[101];
	enum MpTweetUISubscriberTypeEnum Type;
	struct MpTweetUIReceiptConfirmationType Confirmation;
} MpTweetUISubscriberType;

typedef struct MpTweetUISubscriptionAlarmType
{	struct MpTweetUISubscriberType Subscriber[20];
	plcbit EditCompletion;
} MpTweetUISubscriptionAlarmType;

typedef struct MpTweetUISubscriptionType
{	struct MpTweetUISubscriptionAlarmType Alarm;
} MpTweetUISubscriptionType;

typedef struct MpTweetCoreUIConnectType
{	enum MpTweetUIStatusEnum Status;
	struct MpTweetUIReceiverType Receiver;
	struct MpTweetUISubscriptionType SubscriptionsAndHierarchy;
	struct MpTweetUIMessageBoxType MessageBox;
	unsigned short DefaultLayerStatus;
} MpTweetCoreUIConnectType;

typedef struct MpTweetInfoType
{	struct MpTweetDiagType Diag;
} MpTweetInfoType;

typedef struct MpTweetCoreUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpTweetCoreUISetupType UISetup;
	struct MpTweetCoreUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpTweetInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpTweetCoreUI_typ;

typedef struct MpTweetCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpTweetCoreParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpTweetCoreInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Send;
	plcbit Ping;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit PingDone;
	plcbit MessageSent;
} MpTweetCore_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpTweetCoreUI(struct MpTweetCoreUI* inst);
_BUR_PUBLIC void MpTweetCore(struct MpTweetCore* inst);
_BUR_PUBLIC signed long MpTweetSendMessage(struct MpComIdentType* MpLink, plcstring* Message, plcstring* Receiver);
_BUR_PUBLIC signed long MpTweetCommandRequestDone(struct MpComIdentType* MpLink, plcstring* RequestID, enum MpTweetCommandRequestEnum ReturnType);
_BUR_PUBLIC plcbit MpTweetCommandRequestCheck(struct MpComIdentType* MpLink, plcstring* RequestID);


#ifdef __cplusplus
};
#endif
#endif /* _MPTWEET_ */

