//%attributes = {"invisible":true}
C_LONGINT:C283($1)  //ID de l'objet sur lequel on DEPOSE (déstination)
C_LONGINT:C283($0)

C_TEXT:C284($Name)
C_LONGINT:C283($NumTable;$NumField)

C_POINTER:C301($PtrSrcObjet)
C_LONGINT:C283($srcElément;$srcProcess)
C_LONGINT:C283($DestID;$SouceID)

C_TEXT:C284($TempSampleName)
C_LONGINT:C283($TempSamplecolor)

RESOLVE POINTER:C394(Self:C308;$Name;$NumTable;$NumField)
$DestID:=Num:C11($Name)

_O_DRAG AND DROP PROPERTIES:C607($PtrSrcObjet;$srcElément;$srcProcess)

RESOLVE POINTER:C394($PtrSrcObjet;$SrcVarName;$table;$field)

Case of 
		
		  //________________________________________
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		$CommandName:=Command name:C538(628)  //"FIXER COULEURS RVB"
		$ColorID:=Choose:C955($DestID>8;$DestID-8;$DestID)
		
		  // @UPDATE@ 12/04/15 -{ Add decimal/hexadecimal colors values format
		  //+Chaine(<>_SampleValue{$ColorID})+";"+Chaine(<>_SampleValue{$ColorID+8})+")\r"
		$Texte:=$CommandName+"(*;\""+(Get pointer:C304("<>SampleName"+String:C10($ColorID))->)+"\";"\
			+String:C10(<>_SampleValue{$ColorID};Choose:C955(<>rbtn_dec;"&x";"|DecColorFormat"))+";"\
			+String:C10(<>_SampleValue{$ColorID+8};Choose:C955(<>rbtn_dec;"&x";"|DecColorFormat"))+")\r"
		
		  // @UPDATE@ 12/04/15 -} Add decimal/hexadecimal colors values format
		
		CLEAR PASTEBOARD:C402
		SET TEXT TO PASTEBOARD:C523($Texte)
		
		  //________________________________________
	: (Form event code:C388=On Clicked:K2:4)\
		 | (Form event code:C388=On Getting Focus:K2:7)  // @UPDATE@ 03/09/2013 - Make drag work
		
		<>Color:=<>_SampleValue{$DestID}
		Color_RGB_to_HLS (<>Color;->vH;->vL;->vS)
		vR:=(<>Color & 0x00FF0000) >> 16
		vG:=(<>Color & 0xFF00) >> 8
		vB:=(<>Color & 0x00FF)
		
		  // @UPDATE@ 12/04/15 - Mise en commentaire - OBJET FIXER COULEURS RVB(*;"TestObject";0;<>Color)
		  //________________________________________
	: (Form event code:C388=On Drag Over:K2:13)
		
		$0:=0
		
		Case of 
				
				  //----------------------------------------
			: ($SrcVarName="<>FakePict@")
				
				  //----------------------------------------
			: ($SrcVarName="<>Sample@")
				
				  //----------------------------------------
			Else 
				
				$0:=-1
				
				  //----------------------------------------
		End case 
		
		  //________________________________________
	: (Form event code:C388=On Drop:K2:12)
		
		GOTO OBJECT:C206(Self:C308->)
		
		Case of 
				
				  //----------------------------------------
			: ($SrcVarName="<>FakePict@")  //nouveau sample
				
				<>_SampleValue{$DestId}:=<>Color
				OBJECT SET RGB COLORS:C628(Get pointer:C304("<>Sample"+String:C10($DestId))->;0;<>_SampleValue{$DestId})
				
				  //----------------------------------------
			: ($SrcVarName="<>Sample@")  //echange de sample
				
				  //provenance
				$SouceId:=Num:C11($SrcVarName)
				
				  //destination
				If ($SouceId>8)
					
					  //remove 8
					$SourcePtr:=Get pointer:C304("<>SampleName"+String:C10($SouceId-8))
					
				Else 
					
					$SourcePtr:=Get pointer:C304("<>SampleName"+String:C10($SouceId))
					
				End if 
				
				  //mémorisation de la valeur courante
				$TempSamplecolor:=<>_SampleValue{$DestId}
				$TempSampleName:=$DestPtr->
				
				  //affectation de la valeur courante
				<>_SampleValue{$DestId}:=<>_SampleValue{$SouceId}
				$DestPtr->:=$SourcePtr->
				
				  //affectation de la valeur source (swap)
				<>_SampleValue{$SouceId}:=$TempSamplecolor
				$SourcePtr->:=$TempSampleName
				
				  //mise à jour des couleurs
				OBJECT SET RGB COLORS:C628(Get pointer:C304("<>Sample"+String:C10($SouceId))->;0;<>_SampleValue{$SouceId})
				OBJECT SET RGB COLORS:C628(Get pointer:C304("<>Sample"+String:C10($DestId))->;0;<>_SampleValue{$DestId})
				
				  //----------------------------------------
			Else 
				
				$0:=-1
				
				  //----------------------------------------
		End case 
		
		  //________________________________________
End case 

If ($DestID>8)
	
	$DestID:=$DestID-8
	
End if 

OBJECT SET RGB COLORS:C628(<>Color;<>_SampleValue{$DestId};<>_SampleValue{$DestId+8})