//%attributes = {"invisible":true}
// Color_RGB_to_HSL($Color;->Hue;->Luminosity;->Salturation)

var $1 : Integer  // Color coded as 0xRRGGBB
var $2; $3; $4 : Pointer  // Ptr on H, L, S

var $Red; $Green; $Blue : Integer
var $Hue; $Saturation; $Luminosity : Integer

$Red:=(($1 & 0x00FF0000) >> 16)*100/255
$Green:=(($1 & 0xFF00) >> 8)*100/255
$Blue:=($1 & 0x00FF)*100/255

Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Red>$Green)\
		 & ($Green=$Blue)  // 0
		
		$Luminosity:=$Red
		$Saturation:=100*($Luminosity-$Blue)/$Luminosity
		$Hue:=0  // •••
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Red>$Green)\
		 & ($Green>$Blue)  // 1 à 59
		
		$Luminosity:=$Red
		$Saturation:=100*($Luminosity-$Blue)/$Luminosity
		$Hue:=0+(60*(($Green-$Blue)/($Red-$Blue)))  // Plus le vert croit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Green=$Red)\
		 & ($Red>$Blue)  // 60
		
		$Luminosity:=$Red
		$Saturation:=100*($Luminosity-$Blue)/$Luminosity
		$Hue:=60  // 60 •••
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Green>$Red)\
		 & ($Red>$Blue)  // 61 à 119
		
		$Luminosity:=$Green
		$Saturation:=100*($Luminosity-$Blue)/$Luminosity
		$Hue:=60+(60*(($Green-$Red)/($Green-$Blue)))  // Plus le Rouge décroit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Green>$Blue)\
		 & ($Blue=$Red)  // 120
		
		$Luminosity:=$Green
		$Saturation:=100*($Luminosity-$Red)/$Luminosity
		$Hue:=120
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Green>$Blue)\
		 & ($Blue>$Red)  // 121 à 179
		
		$Luminosity:=$Green
		$Saturation:=100*($Luminosity-$Red)/$Luminosity
		$Hue:=120+(60*(($Blue-$Red)/($Green-$Red)))  // Plus le bleu croit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Blue=$Green)\
		 & ($Green>$Red)  // 180
		
		$Luminosity:=$Green
		$Saturation:=100*($Luminosity-$Red)/$Luminosity
		$Hue:=180  // 180
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Blue>$Green)\
		 & ($Green>$Red)  // 181 à 239
		
		$Luminosity:=$Blue
		$Saturation:=100*($Luminosity-$Red)/$Luminosity
		$Hue:=180+(60*(($Blue-$Green)/($Blue-$Red)))  // Plus le Vert décroit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Blue>$Red)\
		 & ($Red=$Green)  // 240
		
		$Luminosity:=$Blue
		$Saturation:=100*($Luminosity-$Green)/$Luminosity
		$Hue:=240
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Blue>$Red)\
		 & ($Red>$Green)  // 241 à 299
		
		$Luminosity:=$Blue
		$Saturation:=100*($Luminosity-$Green)/$Luminosity
		$Hue:=240+(60*(($Red-$Green)/($Blue-$Green)))  // Plus le rouge croit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Red=$Blue)\
		 & ($Blue>$Green)  // 300
		
		$Luminosity:=$Blue
		$Saturation:=100*($Luminosity-$Green)/$Luminosity
		$Hue:=300
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Red>=$Blue)\
		 & ($Blue>=$Green)
		
		$Luminosity:=$Red
		$Saturation:=100*($Luminosity-$Green)/$Luminosity
		$Hue:=300+(60*(($Red-$Blue)/($Red-$Green)))  // Plus le Bleu décroit, plus le HUE croit
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Red=$Blue)\
		 & ($Blue=$Green)
		
		$Luminosity:=$Blue  // Or red or green
		$Saturation:=0
		$Hue:=0
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 

If ($Hue>=0)
	
	$2->:=$Hue
	$3->:=$Luminosity
	$4->:=$Saturation
	
End if 