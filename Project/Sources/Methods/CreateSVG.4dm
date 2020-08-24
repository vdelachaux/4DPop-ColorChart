//%attributes = {"invisible":true}
C_LONGINT:C283($1;$2)  //foreground;background

$width:=200
$height:=200

C_PICTURE:C286($ViewDDIC)
$svgID:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")

$refID:=DOM Create XML element:C865($svgID;"svg/rect";"x";"0";"y";"0";"width";String:C10($width);"height";String:C10($height))

$r:=($1 & 0x00FF0000) >> 16
$g:=($1 & 0xFF00) >> 8
$b:=($1 & 0x00FF)
$RGBcolor:="RGB("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"
DOM SET XML ATTRIBUTE:C866($refID;"fill";$RGBcolor)

$r:=($2 & 0x00FF0000) >> 16
$g:=($2 & 0xFF00) >> 8
$b:=($2 & 0x00FF)
$RGBcolor:="RGB("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"
DOM SET XML ATTRIBUTE:C866($refID;"stroke";$RGBcolor)

SVG EXPORT TO PICTURE:C1017($svgID;$ViewDDIC)

DOM CLOSE XML:C722($svgID)

$0:=$ViewDDIC