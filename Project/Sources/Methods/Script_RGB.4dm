//%attributes = {"invisible":true}
var $Id : Integer

var $Ptr : Pointer
var $Name : Text
var $NumTable; $NumField : Integer

<>Color:=(vR << 16)+(vG << 8)+(vB)
Color_RGB_to_HLS(<>Color; ->vH; ->vL; ->vS)

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