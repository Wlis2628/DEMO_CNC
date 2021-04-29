
PROGRAM _INIT
	
	readX;
	readY;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	
	IF gSvgStringArrayIndex>0 THEN
		gLiveDrawing:=TRUE;
	ELSE
		gLiveDrawing:=FALSE;
		
	END_IF;
	
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
	
	
	CASE curShape OF
		
		circle:
			(*-circle drawing-*)
			CASE stage OF  
				0:
			InfoString:='Point centre of the circle';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
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
			CASE stage OF  
				0:
			InfoString:='Point top-left corner of the rectangle';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<polyline points="';
						prevReadX:=readX;
						prevReadY:=readY;
						
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
						
						
							strHelp:='" fill="none" stroke="black" />';
							strcat(ADR(shapeString),ADR(strHelp));
							svgStringArray[svgStringArrayIndex]:=shapeString;	
				
							svgStringArrayIndex:=svgStringArrayIndex+1;
				
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
				InfoString:='Point centre of the star';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<polyline points="';
						prevReadX:=readX;
						prevReadY:=readY;
					END_IF;
					
					cmdDraw:=FALSE;
					distX:=ABS(readX-prevReadX);
					distY:=ABS(readY-prevReadY);
					distX:=distX*distX;
					distY:=distY*distY;
					radius:=SQRT(UDINT_TO_REAL(distX+distY));
						
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
					
						
						strHelp:='" fill="none" stroke="black" />';
						strcat(ADR(shapeString),ADR(strHelp));
						svgStringArray[svgStringArrayIndex]:=shapeString;	
				
						svgStringArrayIndex:=svgStringArrayIndex+1;
				
					
							stage:=0;
							END_IF
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
	
		(*---------------*)
		
			
		arc:
			(*-arc drawing-*)
			CASE stage OF  
				0:
					InfoString:='Point first-point of the arc';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						shapeString:='<path d="M ';
						prevPrevReadX:=readX;
						prevPrevReadY:=readY;
				
						stage:=1;	
					END_IF;
		
				1:
					InfoString:='Point endt-point of the arc';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						prevReadX:=readX;
						prevReadY:=readY;
						stage:=2;
					END_IF;
				2:
					InfoString:='Point radius distance of the arc';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
					
		
						
						ab:=SQRT(ABS(prevReadX-prevPrevReadX)*ABS(prevReadX-prevPrevReadX)+ABS(prevReadY-prevPrevReadY)*ABS(prevReadY-prevPrevReadY));
						bc:=SQRT(ABS(readX-prevReadX)*ABS(readX-prevReadX)+ABS(readY-prevReadY)*ABS(readY-prevReadY));
						maks:=ab/2;
						radius:=bc;
						IF prevReadX-radius<0 OR prevReadY-radius<0 OR prevReadX+radius>780 OR prevReadY+radius>630 THEN
							stage:=3;
						ELSE	
						
						
							IF radius> maks THEN
								radius:=maks;
							ELSE
								radius:=(maks*15)-(radius/maks)*(maks*15);
							
							END_IF
							
							strHelp:=' ';
							strX:=UINT_TO_STRING(prevPrevReadX);
							strcat(ADR(shapeString),ADR(strX));
							strcat(ADR(shapeString),ADR(strHelp));
							strY:=UINT_TO_STRING(prevPrevReadY);
							strcat(ADR(shapeString),ADR(strY));
							strHelp:=' A ';
							strcat(ADR(shapeString),ADR(strHelp));	
							strRadius:=REAL_TO_STRING(radius);
							strcat(ADR(shapeString),ADR(strRadius));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strcat(ADR(shapeString),ADR(strRadius));
							strHelp:=' 0 0 0 ';
							strcat(ADR(shapeString),ADR(strHelp));
							strX:=UINT_TO_STRING(prevReadX);
							strcat(ADR(shapeString),ADR(strX));
							strHelp:=' ';
							strcat(ADR(shapeString),ADR(strHelp));
							strY:=UINT_TO_STRING(prevReadY);
							strcat(ADR(shapeString),ADR(strY));
							strHelp:='" fill="none" stroke="black" />';
							strcat(ADR(shapeString),ADR(strHelp));
							
							
							svgStringArray[svgStringArrayIndex]:=shapeString;	
					
							svgStringArrayIndex:=svgStringArrayIndex+1;
							
							stage:=0;
						END_IF;
						END_IF
				3:
					InfoString:='Shape outside drawing field!';
					IF EDGEPOS(cmdDraw) THEN
						cmdDraw:=FALSE;
						stage:=0;
					END_IF
				
				
			END_CASE;
	
		(*---------------*)
		
	END_CASE
(*----clearing paper-----*)
	IF EDGEPOS(cmdClear) THEN
		cmdClear:=FALSE;
		FOR i:=0 TO svgStringArrayIndex DO
			svgStringArray[i]:='';
		END_FOR;
		svgStringArrayIndex:=0;
	END_IF;
(*------Undo--------*)
	IF EDGEPOS(cmdBack) THEN
		cmdBack:=FALSE;
		IF svgStringArrayIndex>0 THEN
			svgStringArrayIndex:=svgStringArrayIndex-1;
		END_IF
			svgStringArray[svgStringArrayIndex]:='';
			
	END_IF;
(*------Pass to global---------*)
	gSvgStringArray:=svgStringArray;
	gSvgStringArrayIndex:=svgStringArrayIndex;
	
	
	
	IF HelpLines THEN

	
	(* A line showing the position in X*)
	inXlinePosYStr:=REAL_TO_STRING(inXlinePosY);
	inXlinePosXStr:=REAL_TO_STRING(inXlinePosX);
	inXlinePosYStr1:=REAL_TO_STRING(inXlinePosY1);
	
	
	gSvgStringArray[0]:='<polyline points="';
	inXlinePosY1:=0;
	strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosXStr));
	strHelp:=',';
	strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
	strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosYStr1));
	strHelp:=' ';
	strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
	inXlinePosY:=630;
	strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosXStr));
	strHelp:=',';
	strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
	strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosYStr));
	strHelp:='" fill="none" stroke="red" />';
	strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
	
	
	(* A line showing the position in Y*)
	inYlinePosYStr:=REAL_TO_STRING(inYlinePosY);
	inYlinePosXStr:=REAL_TO_STRING(inYlinePosX);
	inYlinePosXStr1:=REAL_TO_STRING(inYlinePosX1);
	
	
	gSvgStringArray[1]:='<polyline points="';
	inYlinePosX1:=0;
	strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosXStr1));
	strHelp:=',';
	strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
	strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosYStr));
	strHelp:=' ';
	strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
	inYlinePosX:=780;
	strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosXStr));
	strHelp:=',';
	strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
	strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosYStr));
	strHelp:='" fill="none" stroke="red" />';
	strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
	
	ELSE
		(* A line showing the position in X*)
		inXlinePosYStr:=REAL_TO_STRING(inXlinePosY);
		inXlinePosXStr:=REAL_TO_STRING(inXlinePosX);
		inXlinePosYStr1:=REAL_TO_STRING(inXlinePosY1);
	
	
		gSvgStringArray[0]:='<polyline points="';
		inXlinePosY1:=0;
		strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosXStr));
		strHelp:=',';
		strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
		strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosYStr1));
		strHelp:=' ';
		strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
		inXlinePosY:=630;
		strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosXStr));
		strHelp:=',';
		strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
		strcat(ADR(gSvgStringArray[0]),ADR(inXlinePosYStr));
		strHelp:='" fill="none" stroke="white" />';
		strcat(ADR(gSvgStringArray[0]),ADR(strHelp));
	
	
		(* A line showing the position in Y*)
		inYlinePosYStr:=REAL_TO_STRING(inYlinePosY);
		inYlinePosXStr:=REAL_TO_STRING(inYlinePosX);
		inYlinePosXStr1:=REAL_TO_STRING(inYlinePosX1);
	
	
		gSvgStringArray[1]:='<polyline points="';
		inYlinePosX1:=0;
		strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosXStr1));
		strHelp:=',';
		strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
		strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosYStr));
		strHelp:=' ';
		strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
		inYlinePosX:=780;
		strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosXStr));
		strHelp:=',';
		strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
		strcat(ADR(gSvgStringArray[1]),ADR(inYlinePosYStr));
		strHelp:='" fill="none" stroke="white" />';
		strcat(ADR(gSvgStringArray[1]),ADR(strHelp));
	END_IF;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

