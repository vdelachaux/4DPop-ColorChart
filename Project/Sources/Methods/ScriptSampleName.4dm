//%attributes = {"invisible":true}
var $Name : Text
var $NumTable; $NumField : Integer
var $ColorID : Integer

RESOLVE POINTER:C394(Self:C308; $Name; $NumTable; $NumField)
$ColorID:=Num:C11($Name)

Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		$CommandName:=Command name:C538(628)  // "FIXER COULEURS RVB"
		$Color:=<>_Colors{$ColorID}
		$Texte:=$CommandName+"(*;\""+(Get pointer:C304("<>SampleName"+String:C10($ColorID))->)+"\";"+String:C10($Color)+";"+String:C10($Color)+")\r"
		CLEAR PASTEBOARD:C402
		SET TEXT TO PASTEBOARD:C523($Texte)
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 