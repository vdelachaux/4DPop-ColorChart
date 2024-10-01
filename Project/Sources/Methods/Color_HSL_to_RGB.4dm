//%attributes = {"invisible":true}
// $Color:=Color_HSL_to_RGB (->$Hue;->$Saturation;->$Light)

var $1; $2; $3 : Integer
var $0 : Integer

var $Hue; $Saturation; $Luminosity : Integer
var $Red; $Green; $Blue : Integer
var $Min; $Max; $Delta : Integer

$Hue:=$1%360  // 0 à 360°
$Saturation:=$2  // 0 à 100%
$Luminosity:=$3  // 0 à 100%

$Max:=$Luminosity*255/100  // RGB vont de 0 à 255
$Min:=$Max*((100-$Saturation)/100)
$Delta:=$Max-$Min

Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=300)
		
		$Hue:=$Hue-300
		$Red:=$Max
		$Green:=$Min
		$Blue:=$Max-($Delta*($Hue/60))  // Bleu décroissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=240)
		
		$Hue:=$Hue-240
		$Blue:=$Max
		$Green:=$Min
		$Red:=$Min+($Delta*($Hue/60))  // Rouge croissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=180)
		
		$Hue:=$Hue-180
		$Blue:=$Max
		$Red:=$Min
		$Green:=$Max-($Delta*($Hue/60))  // Vert décroissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=120)
		
		$Hue:=$Hue-120
		$Green:=$Max
		$Red:=$Min
		$Blue:=$Min+($Delta*($Hue/60))  // Bleu croissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=60)
		
		$Hue:=$Hue-60
		$Green:=$Max
		$Blue:=$Min
		$Red:=$Max-($Delta*($Hue/60))  // Rouge décroissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($Hue>=0)
		
		$Hue:=$Hue-0  // Pour la symétrie des autres cas :-)
		$Red:=$Max
		$Blue:=$Min
		$Green:=$Min+($Delta*($Hue/60))  // Vert croissant
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 

$Color:=($red << 16)+($Green << 8)+$Blue

$0:=$Color