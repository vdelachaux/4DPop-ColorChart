$Ptr:=Focus object:C278
RESOLVE POINTER:C394($Ptr;$name;$Table;$Field)

<>Color:=0x00FFFFFF  //white

If ($name="<>Sample@")  // @UPDATE@ 12/04/15 - Correction bug : les noms de variables globales ne commencent plus par un diamant ◊ mais par <> // ($name="◊Sample@")
	
	OBJECT SET RGB COLORS:C628($Ptr->;0;<>Color)
	$Id:=Num:C11($name)
	<>_SampleValue{$Id}:=<>Color
	
	If ($Id>8)
		
		$Id:=$Id-8
		
	End if 
	
	OBJECT SET RGB COLORS:C628(<>Color;<>_SampleValue{$Id};<>_SampleValue{$Id+8})
	
Else 
	
	  // @UPDATE@ 12/04/15 -{ Mise à jour de  <>FakePict si aucun sample sélectionné
	
	  // @UPDATE@ 12/04/15 - Mise en commentaire - OBJET FIXER COULEURS RVB(*;"TestObject";0;<>Color)
	
	Color_RGB_to_HLS (<>Color;->vH;->vL;->vS)
	vR:=(<>Color & 0x00FF0000) >> 16
	vG:=(<>Color & 0xFF00) >> 8
	vB:=(<>Color & 0x00FF)
	
	<>FakePict:=CreateSVG (<>Color;<>Color)
	
	GOTO OBJECT:C206(<>FakePict)
	
	  // @UPDATE@ 12/04/15 }- Mise à jour de  <>FakePict si aucun sample sélectionné
	
End if 