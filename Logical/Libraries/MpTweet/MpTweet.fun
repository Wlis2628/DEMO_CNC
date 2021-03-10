
FUNCTION_BLOCK MpTweetCoreUI (*UI function block for configuring messages on HMI*) (* $GROUP=mapp Services,$CAT=Messaging Services,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpTweet.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets  function block errors*) (* *) (*#PAR#;*)
		UISetup : MpTweetCoreUISetupType; (*Used to configure the elements connected to the HMI application*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpTweetCoreUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly *) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block *) (* *) (*#PAR#; *)
		Info : MpTweetInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpTweetCore (*This mapp component MpTweetCore provides the basic functionality and services to send and receive messages. MpTweetCore manages to connection to the configured modem and allows the user and other mapp components the use the provided services.*) (* $GROUP=mapp Services,$CAT=Messaging Services,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpTweet.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets  function block errors*) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpTweetCoreParType; (*Function block parameters*) (* *) (*#PAR#; *)
		Update : BOOL; (*Applies changed parameters*) (* *) (*#PAR#; *)
		Send : BOOL; (*Send the message as defined in parameters*) (* *) (*#CMD#;*)
		Ping : BOOL; (*Optional: Command to ping the modem*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly *) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block *) (* *) (*#PAR#; *)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Optional: Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		PingDone : BOOL; (*Optional: Ping command was successful.*) (* *) (*#CMD#OPT#;*)
		MessageSent : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#; *)
		Info : MpTweetCoreInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpTweetSendMessage : DINT (*This function of MpTweet provides a user function to send messages based on a custom condition. Returns StatusID of a Send Message operation.*) (* $GROUP=mapp Services,$CAT=Messaging Services,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpTweet.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Message : STRING[255]; (*Preconfigured MessageID or message text to be send*) (* *) (*#PAR#;*)
		Receiver : STRING[100]; (*Preconfigured receiver or telephon-number*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpTweetCommandRequestDone : DINT (*This function of MpTweet provides a user function to send a confirmation message when a reuqest was done. Returns StatusID of a Command Request Done operation.*) (* $GROUP=mapp Services,$CAT=Messaging Services,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpTweet.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		RequestID : STRING[255]; (*RequestID of the request to be defined as done*) (* *) (*#PAR#;*)
		ReturnType : MpTweetCommandRequestEnum; (*Return type, defining type of done. At the moment only success supported*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpTweetCommandRequestCheck : BOOL (*This function of MpTweet provides a user function to check for configured request messages. Return value with information if CommandReuqest was triggered through a message.*) (* $GROUP=mapp Services,$CAT=Messaging Services,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpTweet.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		RequestID : STRING[255]; (*RequestID of the request to be checked*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION
