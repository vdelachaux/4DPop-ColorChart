//%attributes = {"invisible":true}
C_PICTURE:C286(<>BigPict)

C_LONGINT:C283($Id)
C_POINTER:C301($Ptr)
C_TEXT:C284($Name)
C_LONGINT:C283($NumTable; $NumField)

<>Color:=Color_HSL_to_RGB(vH; vS; vL)

vR:=((<>Color & 0x00FF0000) >> 16)
vG:=((<>Color & 0xFF00) >> 8)
vB:=(<>Color & 0x00FF)

<>FakePict:=CreateSVG(<>Color; <>Color)

If (Shift down:C543)
	$Ptr:=Focus object:C278
	RESOLVE POINTER:C394($Ptr; $name; $Table; $Field)
	If ($name="<>Sample@")
		
		$Ptr->:=<>FakePict
		
		$Id:=Num:C11($name)
		<>_SampleValue{$Id}:=<>Color
		If ($Id>8)
			$Id:=$Id-8
		End if 
		OBJECT SET RGB COLORS:C628(<>Color; <>_SampleValue{$Id}; <>_SampleValue{$Id+8})
	End if 
End if 

SET TIMER:C645(10)

