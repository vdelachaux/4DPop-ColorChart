//%attributes = {}
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Win)
C_POINTER:C301($Ptr)

If (False:C215)
	C_POINTER:C301(ShowPalette ;$1)
	C_LONGINT:C283(ShowPalette ;$2)
End if 

C_LONGINT:C283(<>ShowPalette)

If (Count parameters:C259<2)
	
	If (Count parameters:C259>0)
		$Ptr:=$1
	End if 
	
	If (Process state:C330(<>ShowPalette)<0) | (<>ShowPalette=0)
		<>ShowPalette:=New process:C317("ShowPalette";0;"ShowPalette";$Ptr;0)
	Else 
		BRING TO FRONT:C326(<>ShowPalette)
	End if 
	
Else 
	
	$Win:=Open form window:C675("PaletteHelp";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	DIALOG:C40("PaletteHelp")
	CLOSE WINDOW:C154
	
	<>ShowPalette:=0
End if 