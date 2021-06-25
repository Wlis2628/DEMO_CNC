
PROGRAM _INIT
	
	readX;
	readY;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	
	(*Warning*)
	IF InfoString='Shape outside drawing field!' THEN
		gMsgBox:=TRUE;
	ELSE
		gMsgBox:=FALSE;
	END_IF;
	
	IF InfoString='Radius can not be equal to 0!' THEN
		gMsgBox2:=TRUE;
	ELSE
		gMsgBox2:=FALSE;
	END_IF;
	
	IF InfoString='Distance can not be equal to 0!' THEN
		gMsgBox3:=TRUE;
	ELSE
		gMsgBox3:=FALSE;
	END_IF;
	
	(*HelpLines*)
	IF HelpLines THEN
		
		IF (readX-inXlinePosX)<=20 AND (readY-inYlinePosY)<=20 AND (readY-inYlinePosY)>=-20 AND (readX-inXlinePosX)>=-20 THEN
			readX:=REAL_TO_UINT(inXlinePosX);
			readY:=REAL_TO_UINT(inYlinePosY);
		END_IF;
		
	END_IF;
	
	
	
	CASE curShape OF
		
		circle:
			
			CurrentShape:='circle';
			(*-circle drawing-*)
			CASE stage OF  
				0:
			InfoString:='Point centre of the circle';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						RotationAngle:=0;
						strRot:=REAL_TO_STRING(RotationAngle);
						shapeString:='<circle cx="';
						prevReadX:=readX;
						prevReadY:=readY;
						strX:=UINT_TO_STRING(readX);
						strY:=UINT_TO_STRING(readY);
	
						strHelp:='" cy="';
						strcat(ADR(shapeString),ADR(strX));
						strcat(ADR(shapeString),ADR(strHelp));
						strcat(ADR(shapeString),ADR(strY));
						strHelp:='" r="';
						strcat(ADR(shapeString),ADR(strHelp));
						stage:=1;
						
						IF prevReadX-CircleRadius<0 OR prevReadY-CircleRadius<0 OR prevReadX+CircleRadius>780 OR prevReadY+CircleRadius>630 THEN
							stage:=1;
						ELSIF CircleRadius=0 THEN
							stage:=2;
						ELSE
							strRadius:=REAL_TO_STRING(CircleRadius);
							strcat(ADR(shapeString),ADR(strRadius));
							strHelp:='" stroke="black" fill="none" />';
							strcat(ADR(shapeString),ADR(strHelp));
				
							svgStringArray[svgStringArrayIndex]:=shapeString;	
							svgStringArrayIndex:=svgStringArrayIndex+1;
							
							IF svgStringArray[3]<>'' THEN
	  
								(*PositionArray*)
								strHelp:='type:';	
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(CurrentShape));
								strHelp:='; x=';
								strcat(ADR(PositionString), ADR(strHelp));
								
								strcat(ADR(PositionString), ADR(strX));
								strHelp:='; y=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strY));;
								strHelp:='; rot=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strRot));
								strHelp:='';
								strcat(ADR(PositionString), ADR(strHelp));
					
							
								PositionArray[PositionArrayIndex]:=PositionString;
								PositionArrayIndex:=PositionArrayIndex+1;
								PositionString:='';
								
							END_IF;
							
							stage:=0;
							
							
						END_IF;
					END_IF;
		
	
				1:
					InfoString:='Shape outside drawing field!';
			
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF;
				
						
				2: 
					InfoString:='Radius can not be equal to 0!';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF;
				
			END_CASE;
	
			
			
			(*---------------*)
		line:
			(*-line drawing-*)
			CASE stage OF  
				
				0:
					CurrentShape:='line';
					
					InfoString:='Point first-point of the line';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<polyline points="';
						prevReadX:=readX;
						prevReadY:=readY;
				
						stage:=1;	
					END_IF;
		
				1:
			InfoString:='Point end-point of the line';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						strPrevX:=UINT_TO_STRING(prevReadX);
						strPrevY:=UINT_TO_STRING(prevReadY);
						strX:=UINT_TO_STRING(readX);
						strY:=UINT_TO_STRING(readY);
						strHelp:=',';
						strcat(ADR(shapeString),ADR(strPrevX));
						strcat(ADR(shapeString),ADR(strHelp));
						strcat(ADR(shapeString),ADR(strPrevY));
						strHelp:=' ';
						strcat(ADR(shapeString),ADR(strHelp));
						strHelp:=',';
						strcat(ADR(shapeString),ADR(strX));
						strcat(ADR(shapeString),ADR(strHelp));
						strcat(ADR(shapeString),ADR(strY));
						
				
						strHelp:='" fill="none" stroke="black" />';
						strcat(ADR(shapeString),ADR(strHelp));
						svgStringArray[svgStringArrayIndex]:=shapeString;	
				
						svgStringArrayIndex:=svgStringArrayIndex+1;
				
						stage:=0;
					END_IF;
	
			END_CASE;
	
		(*---------------*)
	
		rectangle:
			(*-rectangle drawing-*)
			CurrentShape:='rectangle';
			CASE stage OF  
				0:
			InfoString:='Point top-left corner of the rectangle';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<polyline points="';
						prevReadX:=readX;
						prevReadY:=readY;
						strPrevReadX:=UINT_TO_STRING(prevReadX);
						strPrevReadY:=UINT_TO_STRING(prevReadY);
						strRot:=REAL_TO_STRING(RotationAngle);
						
						IF prevReadX+readXRec>780 OR prevReadY+readYRec>630 THEN
							cmdDraw:=FALSE;
							stage:=1;
						ELSIF readXRec=0 OR readYRec=0 THEN
							stage:=2;
						ELSE
							strPrevX:=UINT_TO_STRING(prevReadX);
							strPrevY:=UINT_TO_STRING(prevReadY);
							strXRec:=UINT_TO_STRING(prevReadX+readXRec);
							strYRec:=UINT_TO_STRING(prevReadY+readYRec);
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strPrevX));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevY));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strXRec));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevY));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strXRec));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strYRec));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strPrevX));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strYRec));
						
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strPrevX));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevY));
							strHelp:='" transform="rotate(';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strRot));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevX));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevY));
							strHelp:=')"';
							strcat(ADR(shapeString),ADR(strHelp));
							strHelp:=' fill="none" stroke="black" />';
							strcat(ADR(shapeString),ADR(strHelp));
							svgStringArray[svgStringArrayIndex]:=shapeString;	
				
							svgStringArrayIndex:=svgStringArrayIndex+1;
						
							IF svgStringArray[3]<>'' THEN
	  
								(*PositionArray*)
								strHelp:='type:';	
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(CurrentShape));
								strHelp:='; x=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strPrevReadX));
								strHelp:='; y=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strPrevReadY));
								strHelp:='; rot=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strRot));
								strHelp:='';
								strcat(ADR(PositionString), ADR(strHelp));
							
								PositionArray[PositionArrayIndex]:=PositionString;
								PositionArrayIndex:=PositionArrayIndex+1;
								PositionString:='';
							END_IF;
							
							stage:=0;
						END_IF;
					END_IF;
					
				
				1:	
					InfoString:='Shape outside drawing field!';
			
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF;
				
				2: 
					InfoString:='Distance can not be equal to 0!';
							
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF;
	
			END_CASE;
	
		(*---------------*)
		
		star:
			(*-star drawing-*)
			CASE stage OF  
				
				0:
					CurrentShape:='star';
					InfoString:='Point centre of the star';
					strRot:=REAL_TO_STRING(RotationAngle);
					
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<polyline points="';
						prevReadX:=readX;
						prevReadY:=readY;
						strPrevReadX:=REAL_TO_STRING(prevReadX);
						strPrevReadY:=REAL_TO_STRING(prevReadY);
						cmdDraw:=FALSE;

						IF prevReadX-radius<0 OR prevReadY-radius<0 OR prevReadX+radius>780 OR prevReadY+radius>630 THEN
							stage:=1;
						ELSIF radius=0 THEN
							stage:=2;
						ELSE
							smallRadius:=radius/3;
							angle:=-18; // degrees
							FOR i:=1 TO 5 DO
	  					
								x:=radius*COS(angle/180*PI);
								y:=radius*SIN(angle/180*PI);
								strX:=REAL_TO_STRING(x+prevReadX);
								strY:=REAL_TO_STRING(y+prevReadY);
								strHelp:=',';
								strcat(ADR(shapeString),ADR(strX));
								strcat(ADR(shapeString),ADR(strHelp));
								strcat(ADR(shapeString),ADR(strY));
								strHelp:=' ';
								strcat(ADR(shapeString),ADR(strHelp));
							
								x:=smallRadius*COS((angle+36)/180*PI);
								y:=smallRadius*SIN((angle+36)/180*PI);
							
								strX:=REAL_TO_STRING(x+prevReadX);
								strY:=REAL_TO_STRING(y+prevReadY);
								strHelp:=',';
								strcat(ADR(shapeString),ADR(strX));
								strcat(ADR(shapeString),ADR(strHelp));
								strcat(ADR(shapeString),ADR(strY));
								strHelp:=' ';
								strcat(ADR(shapeString),ADR(strHelp));
								angle:=angle+72;
							
							END_FOR;
				
							x:=radius*COS(angle/180*PI);
							y:=radius*SIN(angle/180*PI);
							strX:=REAL_TO_STRING(x+prevReadX);
							strY:=REAL_TO_STRING(y+prevReadY);
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strX));
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strY));
					
							strHelp:='" transform="rotate(';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strRot));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevReadX));
							strHelp:=',';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strPrevReadY));
							strHelp:=')"';
							strcat(ADR(shapeString),ADR(strHelp));
							
							strHelp:='" fill="none" stroke="black" />';
							strcat(ADR(shapeString),ADR(strHelp));
							svgStringArray[svgStringArrayIndex]:=shapeString;	
				
							svgStringArrayIndex:=svgStringArrayIndex+1;
				
							
							IF svgStringArray[3]<>'' THEN
	  
								(*PositionArray*)
								strHelp:='type:';	
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(CurrentShape));
								strHelp:='; x=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strPrevReadX));
								strHelp:='; y=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strPrevReadY));
								strHelp:='; rot=';
								strcat(ADR(PositionString), ADR(strHelp));
								strcat(ADR(PositionString), ADR(strRot));
								strHelp:='';
								strcat(ADR(PositionString), ADR(strHelp));
							
								PositionArray[PositionArrayIndex]:=PositionString;
								PositionArrayIndex:=PositionArrayIndex+1;
								PositionString:='';
							END_IF;
							
							stage:=0;
						END_IF;
						
					END_IF;
				1:
					InfoString:='Shape outside drawing field!';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF
				
				2: 
					InfoString:='Distance can not be equal to 0!';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF;
				

				
			END_CASE;
	
	END_CASE;
	
(*----clearing paper-----*)
	IF EDGEPOS(cmdClear) THEN
		cmdClear:=FALSE;
		FOR i:=3 TO svgStringArrayIndex DO
			svgStringArray[i]:='';
		END_FOR;
		svgStringArrayIndex:=3;
		FOR i:=0 TO PositionArrayIndex DO
			PositionArray[i]:='';
		END_FOR;
		PositionArrayIndex:=0;
	END_IF;
(*------Undo--------*)
	IF EDGEPOS(cmdBack) THEN
		cmdBack:=FALSE;
		IF svgStringArrayIndex>0 THEN
			svgStringArrayIndex:=svgStringArrayIndex-1;
		END_IF
			svgStringArray[svgStringArrayIndex]:='';
	
		IF PositionArrayIndex>0 THEN
			PositionArrayIndex:=svgStringArrayIndex-1;
		END_IF
		PositionArray[PositionArrayIndex]:='';
	END_IF;

	
	
	
	IF HelpLines THEN

	
	(* A line showing the position in X*)
	inXlinePosYStr:=REAL_TO_STRING(inXlinePosY);
	inXlinePosXStr:=REAL_TO_STRING(inXlinePosX);
	inXlinePosYStr1:=REAL_TO_STRING(inXlinePosY1);
	
	
	svgStringArray[0]:='<polyline points="';
	inXlinePosY1:=0;
	strcat(ADR(svgStringArray[0]),ADR(inXlinePosXStr));
	strHelp:=',';
	strcat(ADR(svgStringArray[0]),ADR(strHelp));
	strcat(ADR(svgStringArray[0]),ADR(inXlinePosYStr1));
	strHelp:=' ';
	strcat(ADR(svgStringArray[0]),ADR(strHelp));
	inXlinePosY:=630;
	strcat(ADR(svgStringArray[0]),ADR(inXlinePosXStr));
	strHelp:=',';
	strcat(ADR(svgStringArray[0]),ADR(strHelp));
	strcat(ADR(svgStringArray[0]),ADR(inXlinePosYStr));
	strHelp:='" fill="none" stroke="red" />';
	strcat(ADR(svgStringArray[0]),ADR(strHelp));
	
	
	(* A line showing the position in Y*)
	inYlinePosYStr:=REAL_TO_STRING(inYlinePosY);
	inYlinePosXStr:=REAL_TO_STRING(inYlinePosX);
	inYlinePosXStr1:=REAL_TO_STRING(inYlinePosX1);
	
	
	svgStringArray[1]:='<polyline points="';
	inYlinePosX1:=0;
	strcat(ADR(svgStringArray[1]),ADR(inYlinePosXStr1));
	strHelp:=',';
	strcat(ADR(svgStringArray[1]),ADR(strHelp));
	strcat(ADR(svgStringArray[1]),ADR(inYlinePosYStr));
	strHelp:=' ';
	strcat(ADR(svgStringArray[1]),ADR(strHelp));
	inYlinePosX:=780;
	strcat(ADR(svgStringArray[1]),ADR(inYlinePosXStr));
	strHelp:=',';
	strcat(ADR(svgStringArray[1]),ADR(strHelp));
	strcat(ADR(svgStringArray[1]),ADR(inYlinePosYStr));
	strHelp:='" fill="none" stroke="red" />';
	strcat(ADR(svgStringArray[1]),ADR(strHelp));
		
		(* A circle*)
		
		svgStringArray[2]:='<circle cx="';
	
		strHelp:='" cy="';
		strcat(ADR(svgStringArray[2]),ADR(inXlinePosXStr));
		strcat(ADR(svgStringArray[2]),ADR(strHelp));
		strcat(ADR(svgStringArray[2]),ADR(inYlinePosYStr));
		strHelp:='" r="20" stroke="red" stroke-width="1" fill="none" />';
		strcat(ADR(svgStringArray[2]),ADR(strHelp));
	ELSE
		(* A line showing the position in X*)
		inXlinePosYStr:=REAL_TO_STRING(inXlinePosY);
		inXlinePosXStr:=REAL_TO_STRING(inXlinePosX);
		inXlinePosYStr1:=REAL_TO_STRING(inXlinePosY1);
	
	
		svgStringArray[0]:='<polyline points="';
		inXlinePosY1:=0;
		strcat(ADR(svgStringArray[0]),ADR(inXlinePosXStr));
		strHelp:=',';
		strcat(ADR(svgStringArray[0]),ADR(strHelp));
		strcat(ADR(svgStringArray[0]),ADR(inXlinePosYStr1));
		strHelp:=' ';
		strcat(ADR(svgStringArray[0]),ADR(strHelp));
		inXlinePosY:=630;
		strcat(ADR(svgStringArray[0]),ADR(inXlinePosXStr));
		strHelp:=',';
		strcat(ADR(svgStringArray[0]),ADR(strHelp));
		strcat(ADR(svgStringArray[0]),ADR(inXlinePosYStr));
		strHelp:='" fill="none" stroke="white" />';
		strcat(ADR(svgStringArray[0]),ADR(strHelp));
	
	
		(* A line showing the position in Y*)
		inYlinePosYStr:=REAL_TO_STRING(inYlinePosY);
		inYlinePosXStr:=REAL_TO_STRING(inYlinePosX);
		inYlinePosXStr1:=REAL_TO_STRING(inYlinePosX1);
	
	
		svgStringArray[1]:='<polyline points="';
		inYlinePosX1:=0;
		strcat(ADR(svgStringArray[1]),ADR(inYlinePosXStr1));
		strHelp:=',';
		strcat(ADR(svgStringArray[1]),ADR(strHelp));
		strcat(ADR(svgStringArray[1]),ADR(inYlinePosYStr));
		strHelp:=' ';
		strcat(ADR(svgStringArray[1]),ADR(strHelp));
		inYlinePosX:=780;
		strcat(ADR(svgStringArray[1]),ADR(inYlinePosXStr));
		strHelp:=',';
		strcat(ADR(svgStringArray[1]),ADR(strHelp));
		strcat(ADR(svgStringArray[1]),ADR(inYlinePosYStr));
		strHelp:='" fill="none" stroke="white" />';
		strcat(ADR(svgStringArray[1]),ADR(strHelp));
		
		(* A circle*)
		
		svgStringArray[2]:='<circle cx="';
	
		strHelp:='" cy="';
		strcat(ADR(svgStringArray[2]),ADR(inXlinePosXStr));
		strcat(ADR(svgStringArray[2]),ADR(strHelp));
		strcat(ADR(svgStringArray[2]),ADR(inYlinePosYStr));
		strHelp:='" r="20" stroke="white" stroke-width="2" fill="none" />';
		strcat(ADR(svgStringArray[2]),ADR(strHelp));
	END_IF;
	
	(*------Pass to global---------*)
	gSvgStringArray:=svgStringArray;
	gSvgStringArrayIndex:=svgStringArrayIndex;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

