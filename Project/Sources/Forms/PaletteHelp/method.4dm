Case of 
		
		//________________________________________
	: (Form event code:C388=On Load:K2:1)
		
		var <>Color : Integer
		
		var <>FakePict : Picture
		
		var <>Sample1 : Picture
		var <>Sample2 : Picture
		var <>Sample3 : Picture
		var <>Sample4 : Picture
		var <>Sample5 : Picture
		var <>Sample6 : Picture
		var <>Sample7 : Picture
		var <>Sample8 : Picture
		var <>Sample9 : Picture
		var <>Sample10 : Picture
		var <>Sample11 : Picture
		var <>Sample12 : Picture
		var <>Sample13 : Picture
		var <>Sample14 : Picture
		var <>Sample15 : Picture
		var <>Sample16 : Picture
		
		// LECTURE DES PRÉFÉRENCES
		Form:C1466.preferences:=cs:C1710.pop.Preferences.new("Color_Chart")
		
		// Set default values
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
		
		var <>rbtn_dec; <>rbtn_hex : Integer
		
		<>rbtn_dec:=Num:C11($o.decimalFormat)
		<>rbtn_hex:=<>rbtn_dec ? 1 : 0
		OBJECT SET FORMAT:C236(<>Color; Choose:C955(<>rbtn_dec; "&x"; "|DecColorFormat"))
		
		ARRAY LONGINT:C221(<>_SampleValue; 0)
		COLLECTION TO ARRAY:C1562($o.colors; <>_SampleValue)
		
		For ($i; 1; Size of array:C274(<>_SampleValue); 1)
			
			$Ptr:=Get pointer:C304("<>Sample"+String:C10($i))
			$Ptr->:=($Ptr->)*0
			OBJECT SET RGB COLORS:C628($Ptr->; 0; <>_SampleValue{$i})
			
		End for 
		
		var <>SampleName1 : Text
		
		var <>SampleName2 : Text
		var <>SampleName3 : Text
		var <>SampleName4 : Text
		var <>SampleName5 : Text
		var <>SampleName6 : Text
		var <>SampleName7 : Text
		var <>SampleName8 : Text
		
		ARRAY TEXT:C222($_SampleNames; 0)
		COLLECTION TO ARRAY:C1562($o.samplenames; $_SampleNames)
		
		For ($i; 1; Size of array:C274($_SampleNames); 1)
			
			$Ptr:=Get pointer:C304("<>SampleName"+String:C10($i))
			$Ptr->:=Length:C16($_SampleNames{$i})#0 ? $_SampleNames{$i} : Localized string:C991("ColorChart_Sample")+" "+String:C10($i)  // Sample ou echantillon
			
		End for 
		
		// INITIALISATION DU DIALOGUE AVEC UNE PALETTE PAR DEFAUT EN DEMI TEINTES
		
		vH:=180
		vS:=50
		vL:=100
		
		<>Color:=Color_HSL_to_RGB(vH; vL; vS)
		
		// @UPDATE@ 12/04/15 - Mise en commentaire - OBJET FIXER COULEURS RVB(*;"TestObject";0;<>Color)
		
		ARRAY TEXT:C222(<>PopMode; 6)
		<>PopMode{1}:=Localized string:C991("ColorChart_Mode1")
		<>PopMode{2}:=Localized string:C991("ColorChart_Mode2")
		<>PopMode{3}:=Localized string:C991("ColorChart_Mode3")
		<>PopMode{4}:=Localized string:C991("ColorChart_Mode4")
		<>PopMode{5}:=Localized string:C991("ColorChart_Mode5")
		<>PopMode{6}:=Localized string:C991("ColorChart_Mode6")
		
		<>PopMode:=1
		<>ColorPicker:=1
		
		ARRAY LONGINT:C221(<>_Colors; 256)
		var <>ColorPicker : Integer
		
		GOTO OBJECT:C206(<>FakePict)
		
		SET TIMER:C645(10)
		
		//________________________________________
	: (Form event code:C388=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$index:=0
		
		Case of 
				
				//----------------------------------------
			: (<>PopMode=1)  // 256 hues
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Hue:=Round:C94(($i-1)*360/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB($Hue; vS; vL)
					
				End for 
				
				//----------------------------------------
				
			: (<>PopMode=2)  // 256 saturations
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Saturation:=Round:C94(($i-1)*100/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB(vH; $Saturation; vL)
					
				End for 
				
				//----------------------------------------
				
			: (<>PopMode=3)  // 256 lights
				
				For ($i; 1; 256; 1)
					
					$index:=$index+1
					$Luminosity:=Round:C94(($i-1)*100/256; 0)
					<>_Colors{$index}:=Color_HSL_to_RGB(vH; vS; $Luminosity)
					
				End for 
				
				//----------------------------------------
				
			: (<>PopMode=4)  // 16 hues, 16 luminosities
				
				For ($i; 1; 16; 1)
					
					For ($j; 1; 16; 1)
						
						$index:=$index+1
						$Hue:=Round:C94(($i-1)*360/16; 0)
						$Luminosity:=100-Round:C94(($j-1)*100/16; 0)
						<>_Colors{$index}:=Color_HSL_to_RGB($Hue; vS; $Luminosity)
						
					End for 
				End for 
				
				//----------------------------------------
			: (<>PopMode=5)  // 16 hues, 16 saturations
				
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