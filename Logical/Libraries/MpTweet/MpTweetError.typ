
TYPE
    MpTweetErrorEnum : 
        ( (* Error numbers of library MpTweet *)
        mpTWEET_NO_ERROR := 0, (* No error *)
        mpTWEET_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpTWEET_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpTWEET_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpTWEET_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpTWEET_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpTWEET_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpTWEET_ERR_PAR_NULL := -1064239097, (* Parameters structure is a null pointer [Error: 7, 0xc0910007] *)
        mpTWEET_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpTWEET_ERR_RECEIVER_INVALID := -1064128512, (* The defined receiver {2:ReceiverName} is invalid. [Error: 45056, 0xc092b000] *)
        mpTWEET_ERR_REQUEST_INVALID := -1064128511, (* The defined request {2:RequestName} is invalid. [Error: 45057, 0xc092b001] *)
        mpTWEET_INF_WAIT_FOR_SERVER := 1083355138, (* Waiting for the server. [Informational: 45058, 0x4092b002] *)
        mpTWEET_ERR_MESSAGE_SEND_FAIL := -1064128509, (* Failed to send message to receiver: {2:ReceiverName}. [Error: 45059, 0xc092b003] *)
        mpTWEET_ERR_PING_TIMEOUT := -1064128508, (* Ping command timeout with out response. [Error: 45060, 0xc092b004] *)
        mpTWEET_ERR_COMMUNICATION_FAIL := -1064128507, (* Communication to modem failed. Error cause {1:ErrorCause} [Error: 45061, 0xc092b005] *)
        mpTWEET_ERR_MISSING_UICONNECT := -1064128506, (* Missing value on UIConnect [Error: 45062, 0xc092b006] *)
        mpTWEET_INF_WAIT_CORE_FB := 1083355143 (* Waiting for parent component [Informational: 45063, 0x4092b007] *)
        );
END_TYPE
