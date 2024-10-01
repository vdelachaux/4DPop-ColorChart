//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): jpupier
// Date and time: 01/06/07, 08:19:13
// Modified by Roland Lannuzel 01/06/0711:15
// ----------------------------------------------------
// Method: RGB_to_WebSafe_RGB
// Description
//
//
// Parameters
var $1 : Integer  // RGB color
var $0 : Integer  // Safe Web RGB

// ----------------------------------------------------
var $Color; $SafeColor : Integer
ARRAY LONGINT:C221($_RGB; 3)

$Color:=$1

$_RGB{1}:=($Color & 0x00FF0000) >> 16  // RED
$_RGB{2}:=($Color & 0xFF00) >> 8  // GREEN
$_RGB{3}:=($Color & 0x00FF)  // BLUE

ARRAY LONGINT:C221($_SafeColor; 6)
$_SafeColor{1}:=255
$_SafeColor{2}:=204
$_SafeColor{3}:=153
$_SafeColor{4}:=102
$_SafeColor{5}:=51
$_SafeColor{6}:=0

For ($i; 1; 3; 1)
	
	$Color:=$_RGB{$i}
	
	For ($j; 1; 6; 1)
		
		$SafeColor:=$_SafeColor{$j}
		
		If ($Color>=$SafeColor)
			
			$_RGB{$i}:=$SafeColor
			$j:=6
			
		End if 
	End for 
End for 

$SafeColor:=($_RGB{1} << 16)+($_RGB{2} << 8)+($_RGB{3})

$0:=$SafeColor