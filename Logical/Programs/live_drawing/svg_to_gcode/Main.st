PROGRAM _INIT
	(* Insert code here *)
	strDevice:= 'CNC_PrgDir';
	strFile:= 'obrazek.cnc';
	bOK := FALSE;
	byStep := 1;
	byErrorLevel := 0;
	
	memset(ADR(cncString), 0, SIZEOF(cncString));
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	
	IF cmdConvert THEN
		
		cmdConvert:=FALSE;
		IF gSvgStringArray[0]<>'' THEN
		
			memset(ADR(cncString), 0, SIZEOF(cncString));
			strHelp:='%001$n';
			strcat(ADR(cncString),ADR(strHelp));
			FOR i:=0 TO (gSvgStringArrayIndex-1) DO

				svgString:=gSvgStringArray[i];
				labelString:=LEFT(svgString,4);
				Xstr:='';
				Ystr:='';
				Rstr:='';
				IF labelString='<pol' THEN
					j:=19;
					flag1:=TRUE;
					firstMove:=TRUE;
					WHILE flag1 DO
						buff:=MID(svgString,1,j);
				
				
						IF buff=',' THEN
							xory:=TRUE;
			
				
						ELSIF buff=' ' OR buff='"' THEN
							xory:=FALSE;
						
							Xscale:=STRING_TO_REAL(Xstr)/1.5;
							Xstr:=REAL_TO_STRING(Xscale);
							Yscale:=STRING_TO_REAL(Ystr)/1.5;
							Ystr:=REAL_TO_STRING(Yscale);
						
						
							IF firstMove THEN
								IF prevXstr<>Xstr OR prevYstr<>Ystr THEN
									strHelp:='M50$n';    //podniesienie
							
									strcat(ADR(cncString),ADR(strHelp));
						
									strHelp:='G01 X';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Xstr));
									strHelp:=' Z';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Ystr));
									strHelp:=' F';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Fstr));
									strHelp:='$n';
									strcat(ADR(cncString),ADR(strHelp));
						
						
									strHelp:='M60$n';    //opuszczenie
							
									strcat(ADR(cncString),ADR(strHelp));
								END_IF
								firstMove:=FALSE;
							ELSE
								strHelp:='G01 X';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Xstr));
								strHelp:=' Z';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Ystr));
								strHelp:=' F';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Fstr));
								strHelp:='$n';
								strcat(ADR(cncString),ADR(strHelp));
							END_IF
					
						
							prevXstr:=Xstr;
							prevYstr:=Ystr;
						
						
							Xstr:='';
							Ystr:='';
						
						
							IF buff='"' THEN
								flag1:=FALSE;
							END_IF
			
							
						ELSE
							IF xory THEN 
								strcat(ADR(Ystr),ADR(buff));
							ELSE
					
								strcat(ADR(Xstr),ADR(buff));
							END_IF	
						END_IF
						j:=j+1;
					END_WHILE;
			
			
			
			
			
			
			
			
			
			
			
				ELSIF labelString='<cir' THEN
					j:=12;
					flag1:=TRUE;
					k:=0;
					WHILE flag1 DO
						buff:=MID(svgString,1,j);
				
				
						IF buff='"' THEN
					
							k:=k+1;
						ELSE
			
							CASE k OF
								1:
						
									strcat(ADR(Xstr),ADR(buff));
								3:
									strcat(ADR(Ystr),ADR(buff));
								5:
									strcat(ADR(Rstr),ADR(buff));
								6:	flag1:=FALSE;
									strHelp:='M50$n';    //podniesienie
									Xscale:=STRING_TO_REAL(Xstr)/1.5;
									Xstr:=REAL_TO_STRING(Xscale);
									Yscale:=STRING_TO_REAL(Ystr)/1.5;
									Ystr:=REAL_TO_STRING(Yscale);
									Rscale:=STRING_TO_REAL(Rstr)/1.5;
									Rstr:=REAL_TO_STRING(Rscale);
								
								
									Xstr:=REAL_TO_STRING(STRING_TO_REAL(Xstr)-STRING_TO_REAL(Rstr));
								
								
									strcat(ADR(cncString),ADR(strHelp));
									strHelp:='G01 X';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Xstr));
									strHelp:=' Z';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Ystr));
									strHelp:=' F';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Fstr));
									strHelp:='$n';
									strcat(ADR(cncString),ADR(strHelp));
									strHelp:='M60$n';    //opuszczenie
									strcat(ADR(cncString),ADR(strHelp));
									strHelp:='G02 I';
									strcat(ADR(cncString),ADR(strHelp));
									strcat(ADR(cncString),ADR(Rstr));
									strHelp:=' H360$n';
									strcat(ADR(cncString),ADR(strHelp));
									Xstr:='';
									Ystr:='';
									Rstr:='';

							END_CASE;
						END_IF
						
				
						j:=j+1;
					END_WHILE;
			
				

				ELSIF labelString='<pat' THEN
					j:=11;
					flag1:=TRUE;
					k:=0;
					WHILE flag1 DO
						buff:=MID(svgString,1,j);
				
				
						IF buff=' ' THEN
					
							k:=k+1;
						
						ELSIF buff='"' THEN
							flag1:=FALSE;
							Xscale:=STRING_TO_REAL(Xstr)/1.5;
							Xstr:=REAL_TO_STRING(Xscale);
							Yscale:=STRING_TO_REAL(Ystr)/1.5;
							Ystr:=REAL_TO_STRING(Yscale);
						
							X2scale:=STRING_TO_REAL(Xstr2)/1.5;
							Xstr2:=REAL_TO_STRING(X2scale);
							Y2scale:=STRING_TO_REAL(Ystr2)/1.5;
							Ystr2:=REAL_TO_STRING(Y2scale);
						
							Rscale:=STRING_TO_REAL(Rstr)/1.5;
							Rstr:=REAL_TO_STRING(Rscale);
							IF prevXstr<>Xstr OR prevYstr<>Ystr THEN
								strHelp:='M50$n';    //podniesienie
							
								strcat(ADR(cncString),ADR(strHelp));
								strHelp:='G01 X';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Xstr));
								strHelp:=' Z';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Ystr));
								strHelp:=' F';
								strcat(ADR(cncString),ADR(strHelp));
								strcat(ADR(cncString),ADR(Fstr));
								strHelp:='$n';	
								strcat(ADR(cncString),ADR(strHelp));
								strHelp:='M60$n';    //opuszczenie
								strcat(ADR(cncString),ADR(strHelp));
									
							END_IF	
									
							strHelp:='G03 X';
							strcat(ADR(cncString),ADR(strHelp));
							strcat(ADR(cncString),ADR(Xstr2));
							strHelp:=' Z';
							strcat(ADR(cncString),ADR(strHelp));
							strcat(ADR(cncString),ADR(Ystr2));
							strHelp:=' R=';
							strcat(ADR(cncString),ADR(strHelp));
							strcat(ADR(cncString),ADR(Rstr));
							strHelp:='$n';
							strcat(ADR(cncString),ADR(strHelp));
							prevXstr:=Xstr2;
							prevYstr:=Ystr2;
								
							Xstr:='';
							Ystr:='';
							Rstr:='';
							Xstr2:='';
							Ystr2:='';
						
						ELSE
			
							CASE k OF
								1:
						
									strcat(ADR(Xstr),ADR(buff));
								2:
									strcat(ADR(Ystr),ADR(buff));
								4:
									strcat(ADR(Rstr),ADR(buff));
								9:	strcat(ADR(Xstr2),ADR(buff));
							
								10:	strcat(ADR(Ystr2),ADR(buff));
								
						
							END_CASE;
						END_IF
						
				
						j:=j+1;
					END_WHILE;
				END_IF;
	

	
			END_FOR;
			strHelp:='M30';
			strcat(ADR(cncString),ADR(strHelp));
			cmdFile:=TRUE;
		END_IF;
	END_IF
	
	
	
	
	IF cmdFile THEN
	
		CASE byStep OF      
			0: (**** Error step ****)                bOK := FALSE;
			1: (**** Try to open existing file ****)
				(* Initialize file open structrue *)
				FOpen.enable    := 1;
				FOpen.pDevice   := ADR(strDevice);
				FOpen.pFile     := ADR(strFile);
				FOpen.mode      := FILE_RW;  (* Read and write access *)
				(* Call FBK *)                FOpen();
				(* Get FBK output information *)
				dwIdent := FOpen.ident;                wStatus := FOpen.status;
				(* Verify status (20708 -> File doesn't exist) *)
				IF (wStatus = 20708) THEN                     
					byStep := 2;
					fileFlag:=FALSE;
				ELSE                        IF (wStatus = 0) THEN
						byStep := 5;
						fileFlag:=TRUE;
					ELSE
						IF (wStatus <> 65535) THEN
							byErrorLevel := 1;
							byStep := 0;
							IF (wStatus = 20799) THEN
								wError := FileIoGetSysError();
							END_IF
					END_IF                        END_IF
				END_IF    
			2: (**** Create file ****)
				(* Initialize file create structure *)
				FCreate.enable  := 1;
				FCreate.pDevice := ADR(strDevice);
				FCreate.pFile   := ADR(strFile);                (* Call FBK *)
				FCreate();                (* Get FBK output information *)
				dwIdent := FCreate.ident;
				wStatus := FCreate.status;                (* Verify status *)
				IF (wStatus = 0) THEN                        byStep := 3;
				ELSE                        IF (wStatus <> 65535) THEN
						byErrorLevel := 2;
						byStep := 0;
						IF (wStatus = 20799) THEN
							wError := FileIoGetSysError();
					END_IF                        END_IF
				END_IF     
			3: (**** Write data to file ****)
				(* Initialize file write structure *)
				FWrite.enable   := 1;               FWrite.ident    := dwIdent;
				FWrite.offset   := 0;
				FWrite.pSrc     := ADR(cncString);
				FWrite.len      := LEN(cncString);
				(* Call FBK *)                FWrite();
			
				(* Get status *)                wStatus := FWrite.status;
				(* Verify status *)                IF (wStatus = 0) THEN
				byStep := 5;                ELSE
					IF (wStatus <> 65535) THEN
						byErrorLevel := 3;
						byStep := 0;
						IF (wStatus = 20799) THEN
							wError := FileIoGetSysError();
					END_IF                        END_IF
				END_IF      
				//		4: (**** Read data from file ****)
				//			(* Initialize file read structure *)
				//			FRead.enable    := 1;                FRead.ident     := dwIdent;
				//			FRead.offset    := 0;
				//			FRead.pDest     := ADR(byReadData[0]);
				//			FRead.len       := SIZEOF(byReadData);
				//			(* Call FBK *)                FRead();
				//			(* Get status *)                wStatus := FRead.status;
				//			(* Verify status *)                IF (wStatus = 0) THEN
				//			byStep := 5;                ELSE
				//				IF (wStatus <> 65535) THEN
				//					byErrorLevel := 4;
				//					byStep := 0;
				//					IF (wStatus = 20799) THEN
				//						wError := FileIoGetSysError();
				//				END_IF                        END_IF
				//			END_IF     
			5: (**** Close file ****)
				(* Initialize file close structure *)
				FClose.enable   := 1;                FClose.ident    := dwIdent;
				(* Call FBK *)                FClose();
				(* Get status *)                wStatus := FClose.status;
				(* Verify status *)           
				IF (wStatus = 0) THEN
					
					IF fileFlag THEN
					
					
					ELSE
						
						cmdFile:=FALSE;
						memset(ADR(cncString), 0, SIZEOF(cncString));
					END_IF
					byStep := 1; 
					fileIndex:=fileIndex+1;
					strNum:=INT_TO_STRING(fileIndex);
					strFile:='obrazek.cnc';
					strFile := INSERT(strFile, strNum, 7);

				ELSE
					IF (wStatus <> 65535) THEN
						byErrorLevel := 5;
						byStep := 0;
					
						IF (wStatus = 20799) THEN
							wError := FileIoGetSysError();
					END_IF                        END_IF
				END_IF     
			//		6: (**** Delete file ****)
			//			(* Initialize file delete structure *)
			//			FDelete.enable  := 1;
			//			FDelete.pDevice := ADR(strDevice);
			//			FDelete.pName   := ADR(strFile);                (* Call FBK *)
			//			FDelete();                (* Get status *)
			//			wStatus := FDelete.status;                (* Verify status *)
			//			IF (wStatus = 0) THEN                        bOK     := TRUE;
			//			byStep := 7;                ELSE
			//				IF (wStatus <> 65535) THEN
			//					byErrorLevel := 6;
			//					byStep := 0;
			//					IF (wStatus = 20799) THEN
			//						wError := FileIoGetSysError();
			//					END_IF                  
			//				END_IF
			//			END_IF
		END_CASE
		
	END_IF
	

	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM


