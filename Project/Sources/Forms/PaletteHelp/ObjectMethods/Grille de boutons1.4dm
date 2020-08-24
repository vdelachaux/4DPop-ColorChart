Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		<>Color:=<>_Colors{<>ColorPicker}
		Color_RGB_to_HLS (<>Color;->vH;->vL;->vS)
		vR:=(<>Color & 0x00FF0000) >> 16
		vG:=(<>Color & 0xFF00) >> 8
		vB:=(<>Color & 0x00FF)
		
		<>FakePict:=CreateSVG (<>Color;<>Color)
		
		GOTO OBJECT:C206(<>FakePict)
		
	: (Form event code:C388=On Drag Over:K2:13)
		BEEP:C151
		
End case 
