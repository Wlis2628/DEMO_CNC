
TYPE
	MpTweetCoreParType : 	STRUCT  (*Parameter structure*)
		Message : MpTweetSendMessageType; (*Definition of message contant and receiver for Send command*)
		PingTimeout : TIME := T#10s; (*Timeout for ping command*)
	END_STRUCT;
	MpTweetSendMessageType : 	STRUCT  (*Message structure for sending messages from the core*)
		Receiver : STRING[100]; (*Receiver of this message; (Receiver-ID or telephon-number)*)
		Message : STRING[255]; (*Message to be send can be MessageID or message text*)
	END_STRUCT;
	MpTweetReceivedMessageType : 	STRUCT  (*Message structure for receiving messages to the core*)
		Sender : STRING[100]; (*Sender of this message;(Receiver-ID or telephon-number)*)
		Message : STRING[255]; (*Received message content*)
		TimeStamp : DATE_AND_TIME; (*Time stamp when the message was received*)
	END_STRUCT;
	MpTweetCoreInfoType : 	STRUCT  (*Components main info structure type*)
		SentMessages : UDINT; (*Number of send messages*)
		ReceivedMessages : UDINT; (*Number of received messages*)
		PendingRequests : USINT; (*Number of pending request*)
		Messages : MpTweetInfoMessageType; (*Messages / Requests / Responses pending*)
		Diag : MpTweetDiagType; (*Diagnostic structure for the function block*)
		TimeUntilNextReceive : TIME; (*Remaining Time to the next request for received messages*)
	END_STRUCT;
	MpTweetPendingConfirmationType : 	STRUCT  (*Pending confirmation structure*)
		Sender : STRING[100]; (*Sender of the pending confirmation (e.g. MpAlarmX)*)
		Timeout : BOOL; (*The response has timed out and the message has been send to the next receiver*)
		Receiver : STRING[100]; (*Receiver of the message with confirmation*)
		SentTimeStamp : DATE_AND_TIME; (*Time stamp of when the message was sent first*)
	END_STRUCT;
	MpTweetPendingRequestType : 	STRUCT  (*Requests structure*)
		RequestID : STRING[320]; (*Active RequestID*)
		RequestMessage : STRING[320]; (*Message that was requested from the outside*)
		ReturnMessage : STRING[320]; (*Message that will be sent to the requestor*)
		ReceivedTimeStamp : DATE_AND_TIME; (*Time stamp when the message was received*)
		Sender : STRING[100]; (*Sender of this request;(Receiver-ID or telephon-number)*)
	END_STRUCT;
	MpTweetInfoMessageType : 	STRUCT  (*Messages / Requests / Responses pending*)
		PendingRequests : ARRAY[0..9]OF MpTweetPendingRequestType; (*Array of pending request*)
		Received : ARRAY[0..9]OF MpTweetReceivedMessageType; (*FIFO buffer of received messages*)
		PendingConfirmationReceipts : ARRAY[0..9]OF MpTweetPendingConfirmationType; (*Array of pending confirmation (e.g. Alarm confirmation reciept)*)
	END_STRUCT;
	MpTweetDiagType : 	STRUCT  (*Diagostic of the MpTweet*)
		StatusID : MpTweetStatusIDType; (*StatusID diagnostic structure *)
		Internal : MpTweetInternalType; (*Internal error diagnostic structure*)
	END_STRUCT;
	MpTweetStatusIDType : 	STRUCT  (*Status of the MpTweet*)
		ID : MpTweetErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpTweetInternalType : 	STRUCT  (*Internal error diagnostic structure*)
		ID : DINT; (*Internal Status ID*)
		Severity : MpComSeveritiesEnum; (*Severity status: The level of severity of the information received (warning, error, etc.)*)
		Facility : MpComFacilitiesEnum; (*Origin status (e.g. infrastructure, mechatronics, industry, etc.).*)
		Code : UINT; (*Decoded error number*)
	END_STRUCT;
END_TYPE

(*Structures for MpTweetCoreUI new - Receiver*)

TYPE
	MpTweetCommandRequestEnum : 
		( (*Enumerator listing possible command request done Return Types*)
		mpTWEET_CMD_REQUEST_SUCCESS := 0 (*Command request success done*)
		);
	MpTweetCoreUISetupType : 	STRUCT  (*Setup UI list*)
		ReceiverListSize : UINT := 20; (*Number of receivers to be displayed on one page of the list in the HMI application*)
		ReceiverListScrollWindow : USINT := 1; (*Determines how many entries from the list are displayed in advance when scrolling up and down*)
		Confirmation : MpTweetUISetupConfirmType; (*Setup show UI message box when a reciver is create, delete or edit*)
	END_STRUCT;
	MpTweetUIReceiverType : 	STRUCT  (*Defines the list of potential receivers*)
		List : MpTweetUIReceiverListType; (*List of all users, as well as the navigation of the list*)
		Info : MpTweetUIReceiverInfoType; (*Contains detailed information about users*)
		Create : MpTweetUIReceiverCreateType; (*Contains the data necessary to create a receiver*)
		Edit : MpTweetUIReceiverCreateType; (*Contains the data necessary to edit a receiver*)
		Delete : BOOL; (*Deletes the selected receiver*)
	END_STRUCT;
	MpTweetUIReceiverListType : 	STRUCT  (*List of all available receivers*)
		ReceiverNames : ARRAY[0..19]OF STRING[100]; (*List of all available receivers*)
		MaxSelection : UINT; (*Index of the last entry in the list*)
		SelectedIndex : UINT; (*Index of the entry currently selected in the list*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time*)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time*)
		StepUp : BOOL; (* Selects the previous entry in the list*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed-Start [%]*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed-End[%]*)
	END_STRUCT;
	MpTweetUIReceiverInfoType : 	STRUCT  (*Details of potential receivers*)
		Name : STRING[100]; (*Unique Identifier of the potential receiver (tweet core, mapp component).*)
		PhoneNumber : STRING[20]; (*Phone number the receiver can be reached by*)
		Language : STRING[20]; (*Defines the language of which the receiver will receive his messages*)
	END_STRUCT;
	MpTweetUIReceiverCreateType : 	STRUCT  (*Dialog box for editing/creating receivers*)
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Dialog : MpTweetUIReceiverCreateDlgType; (*Dialog box for creating a receivers*)
	END_STRUCT;
	MpTweetUIReceiverCreateDlgType : 	STRUCT  (*Dialog for  editing/creating receivers*)
		LayerStatus : UINT; (*Visibility of the dialog box*)
		Details : MpTweetUIReceiverInfoType; (*Details of potential receivers*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpTweetUIMessageBoxType : 	STRUCT  (*UI message box*)
		LayerStatus : UINT; (*Visibility of the dialog box *)
		Type : MpTweetUIMessageEnum; (*Type of dialog box*)
		StatusID : DINT; (*Current status identifier to be displayed *)
		ErrorNumber : UINT; (*Current error number to be displayed *)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpTweetUIMessageEnum : 
		( (*UI message enum*)
		mpTWEET_UI_MSG_NONE := 0, (*No dialog box*)
		mpTWEET_UI_MSG_ERROR := 1, (*Dialog box: Errors*)
		mpTWEET_UI_MSG_CONFIRM_DELETE := 2, (*Dialog box: Confirmation of reseiver deletion*)
		mpTWEET_UI_MSG_CONFIRM_CREATE := 3, (*Dialog box: Confirming the creation of a new receiver*)
		mpTWEET_UI_MSG_CONFIRM_EDIT := 4 (*Dialog box: Confirmation of receiver edit*)
		);
END_TYPE

(*Structures for MpTweetCoreUI new - Subscription*)

TYPE
	MpTweetUISubscriptionType : 	STRUCT  (*List defining subscribers and the order of how message and alarm notification are being send to subscribers*)
		Alarm : MpTweetUISubscriptionAlarmType; (*List of all receivers, as well as the navigation of the list*)
	END_STRUCT;
	MpTweetUISubscriptionAlarmType : 	STRUCT  (*List of all available receivers*)
		Subscriber : ARRAY[0..19]OF MpTweetUISubscriberType; (*List of all available receivers*)
		EditCompletion : BOOL; (*Completion command for every input field*)
	END_STRUCT;
	MpTweetUISubscriberType : 	STRUCT  (*Subscription info*)
		Name : STRING[100]; (*Unique Identifier of the potential receiver (tweet core, mapp component).*)
		Type : MpTweetUISubscriberTypeEnum; (*Receive only / Confirmation of Receipt*)
		Confirmation : MpTweetUIReceiptConfirmationType; (*List defining subscribers and the order of how message and alarm notification are being send to subscribers*)
	END_STRUCT;
	MpTweetUISubscriberTypeEnum : 
		( (*Receiver type enum*)
		mpTWEET_RECEIVE_ONLY := 0, (*Receive only*)
		mpTWEET_CONIFIRMATION_OF_RECEIPT := 1 (*Confirmation of receipt*)
		);
	MpTweetUIReceiptConfirmationType : 	STRUCT  (*List defining subscribers and the order of how message and alarm notification are being send to subscribers*)
		ExpectedResponse : STRING[20]; (*Subscribers will receive a notification and the system expects a confirmation that the notification was received is expected*)
		ResponseTimeout : USINT; (*Time (minutes) the system waits to receive a response or send the notification to the next person*)
		Attempts : USINT; (*Attempts to reach the subscribers before sending the notification to the next person*)
		Lock : BOOL; (*Lock confirmation for only receive*)
	END_STRUCT;
	MpTweetCoreUIConnectType : 	STRUCT  (*UI connect structure*)
		Status : MpTweetUIStatusEnum; (*Current operation*)
		Receiver : MpTweetUIReceiverType; (*Defines the list of potential receivers*)
		SubscriptionsAndHierarchy : MpTweetUISubscriptionType; (*List defining subscribers and the order of how message and alarm notification are being send to subscribers*)
		MessageBox : MpTweetUIMessageBoxType; (*Controls dialog boxes*)
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page where the receiver management system is being displayed*)
	END_STRUCT;
	MpTweetInfoType : 	STRUCT  (*Components main info structure type*)
		Diag : MpTweetDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpTweetUISetupConfirmType : 	STRUCT  (*Setup show UI message box when a reciver is create, delete or edit*)
		ReceiverCreate : BOOL := FALSE; (*Show UI message box, when a new receiver should create*)
		ReceiverDelete : BOOL := TRUE; (*Show UI message box, when a receiver should delete*)
		ReceiverEdit : BOOL := FALSE; (*Show UI message box, when a receiver should store after editing *)
	END_STRUCT;
	MpTweetUIStatusEnum : 
		( (*Current operation*)
		mpTWEET_CORE_UI_IDLE := 0, (*Indicates that no process is currently active*)
		mpTWEET_CORE_UI_ACTIVE := 1, (*Process is currently active*)
		mpTWEET_CORE_UI_ERROR := 99 (*The last operation generated an error*)
		);
END_TYPE
