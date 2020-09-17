//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : PREFERENCES
  // Created 04/06/07 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($Boo_Set)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Dom_item;$Dom_node;$Dom_preferences;$Error_Method;$kTxt_tool;$PreferencesPath;$Txt_entryPoint;$Txt_item;$Txt_value;$Txt_xml)
C_TEXT:C284($Txt_Xpath)

If (False:C215)
	C_TEXT:C284(PREFERENCES ;$1)
	C_POINTER:C301(PREFERENCES ;${2})
End if 

$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$kTxt_tool:="Color_Chart"
	
	$Txt_entryPoint:=$1
	
	$Boo_set:=($Txt_entryPoint="@.set")
	
	$Txt_entryPoint:=Replace string:C233($Txt_entryPoint;Choose:C955($Boo_set;".set";".get");"")
	
	$Txt_Xpath:="preference/"+$kTxt_Tool+"/"+$Txt_entryPoint
	
	ARRAY TEXT:C222($tTxt_Components;0x0000)
	COMPONENT LIST:C1001($tTxt_Components)
	
	If (Asserted:C1132(Find in array:C230($tTxt_Components;"4DPop")>0;"The component '4dPop' is not installed or loaded. "))
		
		EXECUTE METHOD:C1007("4DPop_preferenceLoad";$Txt_xml;$kTxt_tool)
		
		$Dom_preferences:=DOM Parse XML variable:C720($Txt_xml)
		
	Else 
		
		ABORT:C156
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

If (OK=1)
	
	$Dom_node:=DOM Find XML element:C864($Dom_preferences;$Txt_Xpath)
	
	Case of 
			
			  //______________________________________________________
		: ($Txt_entryPoint="colors")\
			 & (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
			
			If ($Boo_Set)
				
				If (OK=1)
					
					DOM REMOVE XML ELEMENT:C869($Dom_node)
					
				End if 
				
				
				$Dom_node:=DOM Create XML element:C865($Dom_preferences;$Txt_Xpath)
				
				For ($Lon_i;1;Size of array:C274($2->);1)
					
					$Txt_item:=$Txt_Xpath+"/"+"color"+"["+String:C10($Lon_i)+"]"
					$Dom_item:=DOM Create XML element:C865($Dom_preferences;$Txt_item;\
						"value";$2->{$Lon_i})
					
				End for 
				
			Else 
				
				If (OK=1)
					
					For ($Lon_i;1;Size of array:C274($2->);1)
						
						$Txt_item:=$Txt_Xpath+"/"+"color"+"["+String:C10($Lon_i)+"]"
						$Dom_item:=DOM Find XML element:C864($Dom_preferences;$Txt_item)
						
						If (OK=1)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_item;"value";$Lon_value)
							
						End if 
						
						$2->{$Lon_i}:=Choose:C955(OK=1;$Lon_value;0)
						
					End for 
				End if 
				
				$2->:=Choose:C955(OK=1;$Lon_value;0)
				
			End if 
			
			  //______________________________________________________
		: ($Txt_entryPoint="samplenames")\
			 & (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
			
			If ($Boo_Set)
				
				If (OK=1)
					
					DOM REMOVE XML ELEMENT:C869($Dom_node)
					
				End if 
				
				
				$Dom_node:=DOM Create XML element:C865($Dom_preferences;$Txt_Xpath)
				
				For ($Lon_i;1;Size of array:C274($2->);1)
					
					$Txt_item:=$Txt_Xpath+"/"+"sample"+"["+String:C10($Lon_i)+"]"
					$Dom_item:=DOM Create XML element:C865($Dom_preferences;$Txt_item;\
						"name";$2->{$Lon_i})
					
				End for 
				
			Else 
				
				For ($Lon_i;1;Size of array:C274($2->);1)
					
					$Txt_item:=$Txt_Xpath+"/"+"sample"+"["+String:C10($Lon_i)+"]"
					$Dom_item:=DOM Find XML element:C864($Dom_preferences;$Txt_item)
					
					If (OK=1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_item;"name";$Txt_value)
						
					End if 
					
					$2->{$Lon_i}:=Choose:C955(OK=1;$Txt_value;"")
					
				End for 
			End if 
			
			  //______________________________________________________
		: (($Txt_entryPoint="decimalFormat")\
			 & (Asserted:C1132($Lon_parameters>=2;"Missing parameter")))  // @UPDATE@ 12/04/15 -{ Choix decimal/hexadecimal
			
			If ($Boo_Set)
				
				If (OK=1)
					
					DOM REMOVE XML ELEMENT:C869($Dom_node)
					
				End if 
				
				
				$Dom_item:=DOM Create XML element:C865($Dom_preferences;$Txt_Xpath)
				
				DOM SET XML ATTRIBUTE:C866($Dom_item;\
					"value";String:C10($2->))
				
			Else 
				
				If (OK=1)
					
					$Dom_item:=DOM Find XML element:C864($Dom_preferences;$Txt_Xpath)
					
					If (OK=1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_item;"value";$Txt_value)
						
					End if 
					
					$2->:=Choose:C955(OK=1;Num:C11($Txt_value);0)
					
				End if 
				
				$2->:=Choose:C955(OK=1;Num:C11($Txt_value);0)
				
			End if 
			
			  // @UPDATE@ 12/04/15 }- Choix decimal/hexadecimal
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Unknown entrypoint: \""+$Txt_entryPoint+"\"")
			
			  //______________________________________________________
	End case 
	
	If ($Boo_Set)
		
		EXECUTE METHOD:C1007("4DPop_preferenceStore";*;$kTxt_tool;$Dom_preferences)
		
	End if 
	
	DOM CLOSE XML:C722($Dom_preferences)
	
End if 