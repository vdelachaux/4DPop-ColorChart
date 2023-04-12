Case of 
		
		//________________________________________
	: (Form event code:C388=On Load:K2:1)
		
		C_LONGINT:C283(<>Color)
		
		C_PICTURE:C286(<>FakePict)
		
		C_PICTURE:C286(<>Sample1)
		C_PICTURE:C286(<>Sample2)
		C_PICTURE:C286(<>Sample3)
		C_PICTURE:C286(<>Sample4)
		C_PICTURE:C286(<>Sample5)
		C_PICTURE:C286(<>Sample6)
		C_PICTURE:C286(<>Sample7)
		C_PICTURE:C286(<>Sample8)
		C_PICTURE:C286(<>Sample9)
		C_PICTURE:C286(<>Sample10)
		C_PICTURE:C286(<>Sample11)
		C_PICTURE:C286(<>Sample12)
		C_PICTURE:C286(<>Sample13)
		C_PICTURE:C286(<>Sample14)
		C_PICTURE:C286(<>Sample15)
		C_PICTURE:C286(<>Sample16)
		
		//LECTURE DES PRÉFÉRENCES
		Form:C1466.preferences:=pop.Preferences.new("Color_Chart")
		
		//set default values
		var $i : Integer
		var $o : Object
		
		$o:=New object:C1471(\
			"decimalFormat"; 1; \
			"colors"; New collection:C1472.resize(16; 0); \
			"samplenames"; New collection:C1472)
		
		For ($i; 1; 8; 1)
			
			$o.samplenames.push("Sample "+String:C10($i))
			
		End for 
		
		Form:C1466.preferences.default($o)
		
		$o:=Form:C1466.preferences.get()
		
		C_LONGINT:C283(<>rbtn_dec; <>rbtn_hex)
		
		<>rbtn_dec:=Num:C11($o.decimalFormat)
		<>rbtn_hex:=Choose:C955(<>rbtn_dec; 1; 0)
		OBJECT SET FORMAT:C236(<>Color; Choose:C955(<>rbtn_dec; "&x"; "|DecColorFormat"))
		
		ARRAY LONGINT:C221(<>_SampleValue; 0)
		COLLECTION TO ARRAY:C1562($o.colors; <>_SampleValue)
		
		For ($i; 1; Size of array:C274(<>_SampleValue); 1)
			
			$Ptr:=Get pointer:C304("<>Sample"+String:C10($i))
			$Ptr->:=($Ptr->)*0
			OBJECT SET RGB COLORS:C628($Ptr->; 0; <>_SampleValue{$i})
			
		End for 
		
		C_TEXT:C284(<>SampleName1)
		C_TEXT:C284(<>SampleName2)
		C_TEXT:C284(<>SampleName3)
		C_TEXT:C284(<>SampleName4)
		C_TEXT:C284(<>SampleName5)
		C_TEXT:C284(<>SampleName6)
		C_TEXT:C284(<>SampleName7)
		C_TEXT:C284(<>SampleName8)
		
		ARRAY TEXT:C222($_SampleNames; 0)
		COLLECTION TO ARRAY:C1562($o.samplenames; $_SampleNames)
		
		For ($i; 1; Size of array:C274($_SampleNames); 1)
			
			$Ptr:=Get pointer:C304("<>SampleName"+String:C10($i))
			$Ptr->:=Choose:C955(Length:C16($_SampleNames{$i})#0; $_SampleNames{$i}; Get localized string:C991("ColorChart_Sample")+" "+String:C10($i))  //sample ou echantillon
			
		End for 
		
		//INITIALISATION DU DIALOGUE AVEC UNE PALETTE PAR DEFAUT EN DEMI TEINTES
		
		vH:=180
		vS:=50
		vL:=100
		
		<>Color:=Color_HSL_to_RGB(vH; vL; vS)
		
		// @UPDATE@ 12/04/15 - Mise en commentaire - OBJET FIXER COULEURS RVB(*;"TestObject";0;<>Color)
		
		ARRAY TEXT:C222(<>PopMode; 6)
		<>PopMode{1}:=Get localized string:C991("ColorChart_Mode1")
		<>PopMode{2}:=Get localized string:C991("ColorChart_Mode2")
		<>PopMode{3}:=Get localized string:C991("ColorChart_Mode3")
		<>PopMode{4}:=Get localized string:C991("ColorChart_Mode4")
		<>PopMode{5}:=Get localized string:C991("ColorChart_Mode5")
		<>PopMode{6}:=Get localized string:C991("ColorChart_Mode6")
		
		<>PopMode:=1
		<>ColorPicker:=1
		
		ARRAY LONGINT:C221(<>_Colors; 256)
		C_LONGINT:C283(<>ColorPicker)
		
		GOTO OBJECT:C206(<>FakePict)
		
		SET TIMER:C645(10)
		
		//________________________________________
	: (Form event code:C388=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$index:=0
		
		Case of 
				
				//----------------------------------------
			: (<>PopMode=1)  //256 hues
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Hue:=Round:C94(($i-1)*360/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB($Hue; vS; vL)
					
				End for 
				
				//----------------------------------------
			: (<>PopMode=2)  //256 saturations
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Saturation:=Round:C94(($i-1)*100/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB(vH; $Saturation; vL)
					
				End for 
				
				//----------------------------------------
			: (<>PopMode=3)  //256 lights
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Luminosity:=Round:C94(($i-1)*100/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB(vH; vS; $Luminosity)
					
				End for 
				
				//----------------------------------------
			: (<>PopMode=4)  //16 hues, 16 luminosities
				
				For ($i; 1; 16; 1)
					
					For ($j; 1; 16; 1)
						
						$index:=$index+1
						$Hue:=Round:C94(($i-1)*360/16; 0)
						$Luminosity:=100-Round:C94(($j-1)*100/16; 0)
						<>_Colors{$index}:=Color_HSL_to_RGB($Hue; vS; $Luminosity)
						
					End for 
				End for 
				
				//----------------------------------------
			: (<>PopMode=5)  //16 hues, 16 saturations
				
				For ($i; 1; 16; 1)
					
					For ($j; 1; 16; 1)
						
						$index:=$index+1
						$Hue:=Round:C94(($i-1)*360/16; 0)
						$Saturation:=100-Round:C94(($j-1)*100/16; 0)
						<>_Colors{$index}:=Color_HSL_to_RGB($Hue; $Saturation; vL)
						
					End for 
				End for 
				
				//----------------------------------------
			: (<>PopMode=6)  // 16 saturations, 16 luminosities
				
				For ($i; 1; 16; 1)
					
					For ($j; 1; 16; 1)
						
						$index:=$index+1
						$Luminosity:=Round:C94(($i-1)*100/16; 0)
						$Saturation:=100-Round:C94(($j-1)*100/16; 0)
						<>_Colors{$index}:=Color_HSL_to_RGB(vH; $Saturation; $Luminosity)
						
					End for 
				End for 
				
				//----------------------------------------
		End case 
		
		For ($i; 1; 256; 1)
			
			$ObjectName:="Rectangle"+String:C10($i)
			
			If (<>WebSafe=1)
				
				<>_Colors{$i}:=Color_RGB_to_WebRGB(<>_Colors{$i})
				
			End if 
			
			OBJECT SET RGB COLORS:C628(*; $ObjectName; 0; <>_Colors{$i})
			
		End for 
		
		// @UPDATE@ 12/04/15 - Mise en commentaire - OBJET FIXER COULEURS RVB(*;"Sample3";16776444;16774645)
		
		//________________________________________
	: (Form event code:C388=On Unload:K2:2)
		
		Form:C1466.preferences.set("decimalFormat"; -><>rbtn_dec)
		
		var $c : Collection
		$c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($c; <>_SampleValue)
		Form:C1466.preferences.set("colors"; $c)
		
		ARRAY TEXT:C222($_SampleNames; 8)
		
		For ($i; 1; 8; 1)
			
			$Ptr:=Get pointer:C304("<>SampleName"+String:C10($i))
			$_SampleNames{$i}:=$Ptr->
			
		End for 
		
		$c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($c; $_SampleNames)
		Form:C1466.preferences.set("samplenames"; $c)
		
		//________________________________________
End case 