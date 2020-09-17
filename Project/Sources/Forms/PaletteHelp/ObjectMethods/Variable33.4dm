Case of 
		
		  //________________________________________
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		C_BLOB:C604($Blob)
		
		CLEAR PASTEBOARD:C402
		
		$CommandName:=Command name:C538(628)  //"FIXER COULEURS RVB"
		
		  // @UPDATE@ 12/04/15 -{ Choix decimal/hexadecimal
		  //$Text:=$CommandName+"(*;\"objectname\";"+Chaine(<>Color)+";"+Chaine(<>Color)+")"+"\r"
		$Text:=$CommandName+"(*;\"objectname\";"
		$Text:=$Text+String:C10(<>Color;Choose:C955(<>rbtn_dec;"&x";"|DecColorFormat"))+";"
		$Text:=$Text+String:C10(<>Color;Choose:C955(<>rbtn_dec;"&x";"|DecColorFormat"))+")\r"
		
		  // @UPDATE@ 12/04/15 }- Choix decimal/hexadecimal
		
		SET BLOB SIZE:C606($Blob;0)
		TEXT TO BLOB:C554($Text;$Blob;Mac text without length:K22:10)
		APPEND DATA TO PASTEBOARD:C403(Text data:K20:2;$Blob)
		
		SET BLOB SIZE:C606($Blob;0)
		
		PICTURE TO BLOB:C692(<>FakePict;$Blob;".4pct")
		APPEND DATA TO PASTEBOARD:C403("com.4d.private.picture.4dpicture";$Blob)
		
		  //________________________________________
End case 