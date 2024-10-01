//%attributes = {}
#DECLARE($run : Boolean)

var $data : Object

var <>ShowPalette : Integer

If ($run)
	
	$data:=New object:C1471(\
		"window"; Open form window:C675("PaletteHelp"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *))
	DIALOG:C40("PaletteHelp"; $data)
	CLOSE WINDOW:C154
	
	<>ShowPalette:=0
	
Else 
	
	<>ShowPalette:=New process:C317(Current method name:C684; 0; "$4DPop Color Chart"; True:C214; *)
	BRING TO FRONT:C326(<>ShowPalette)
	
End if 