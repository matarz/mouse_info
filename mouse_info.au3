#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Search.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $msg

  $automatic = 0
  $pos = MouseGetPos()
  $color = PixelGetColor($pos[0], $pos[1])
  $cursorID = MouseGetCursor()

  $gui = GUICreate("Mouse Info", 200, 180, -1, -1, -1, $WS_EX_TOPMOST)
  GUISetBkColor(0xDDDDDD)

  $menu = GUICtrlCreateMenu("File")
  $about = GUICtrlCreateMenuItem("About", $menu)
  $exit = GUICtrlCreateMenuItem("Exit", $menu)

  $pos_XY = GUICtrlCreateLabel("Coords: " & $pos[0] & ", " & $pos[1], 10, 20, 100,15)
  $color_Hex = GUICtrlCreateLabel("Color <Hex>: " & Hex($color,6), 10, 37, 130,15)
  $cursID = GUICtrlCreateLabel("Cursor ID: " & $CursorID, 10, 54, 130,15)
  $color_Dec = GUICtrlCreateLabel("Color <Dec>: " & $color, 10, 71, 130,15)

  $button_1 = GUICtrlCreateButton("Copy <F3>", 135, 16, 60, 19)
  $button_2 = GUICtrlCreateButton("Copy", 140, 34, 50, 19)
  $button_3 = GUICtrlCreateButton("Copy", 140, 52, 50, 19)
  $button_4 = GUICtrlCreateButton("Copy", 140, 70, 50, 19)

  GUICtrlCreateGroup("Options", 18, 91, 160, 60)
    $man = GUICtrlCreateRadio("Manual data update <F4>", 28, 105, 137, 20)
    $auto = GUICtrlCreateRadio("Automatic data update", 28, 125, 137, 20)
    GUICtrlSetState($man, $GUI_CHECKED)


  HotKeySet("{F4}", "get_data")
  HotKeySet("{F3}", "_copy")

  GUISetState()

  Do
    $msg = GUIGetMsg()

	If $automatic Then get_data()

	Switch $msg
        Case $button_1
          ClipPut($pos[0] & ", " & $pos[1])
        Case $button_2
	      ClipPut(Hex($color,6))
		Case $button_3
		  ClipPut($cursorID)
		Case $button_4
		  ClipPut($color)
		Case $man
		  $automatic =0
		Case $auto
		  $automatic =1
		Case $about
		  MsgBox(0,"About","Programmed by w!ck3d, 11/02/08", 0, $gui)
        Case $exit
		  ExitLoop
	  EndSwitch

    sleep(10)
    WinSetOnTop($gui, 0, 1)
    Until $msg = $GUI_EVENT_CLOSE
    GUIDelete()


;a function to update the data if the new data is different.
Func get_data()
	$pos2 = MouseGetPos()
	$color2 = PixelGetColor($pos2[0], $pos2[1])
	$cursorID2 = MouseGetCursor()

    If($pos[0] <> $pos2[0] or $pos[1] <> $pos2[1]) Then
      $pos = $pos2
      GUICtrlSetData($pos_XY, "Coords: " & $pos[0] & ", " & $pos[1])
    EndIf

	If($color <> $color2) Then
      $color = $color2
      GUICtrlSetData($color_Hex, "Color <Hex>: " & Hex($color,6))
	  GUICtrlSetData($Color_Dec, "Color <Dec>: " & $color)
    EndIf

    If($cursorID <> $cursorID2) Then
      $cursorID = $cursorID2
      GUICtrlSetData($cursID, "Cursor ID: " & $cursorID)
	EndIf
EndFunc

Func _copy()
	ClipPut($pos[0] & ", " & $pos[1])
EndFunc
