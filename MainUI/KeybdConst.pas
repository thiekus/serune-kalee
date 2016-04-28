unit KeybdConst;

interface

uses
  Windows, DirectInput, Classes;

const
  KeybdKeysCount = 124;

type
  TSKeyboardCode = packed record
    Code: Byte;
    Name: string;
  end;
  TSKeyboardList = array[0..KeybdKeysCount-1] of TSKeyboardCode;

const
  SKeyboardKeys: TSKeyboardList = ((Code: DIK_ESCAPE; Name: 'Escape'),
                                   (Code: DIK_1; Name: '1'),
                                   (Code: DIK_2; Name: '2'),
                                   (Code: DIK_3; Name: '3'),
                                   (Code: DIK_4; Name: '4'),
                                   (Code: DIK_5; Name: '5'),
                                   (Code: DIK_6; Name: '6'),
                                   (Code: DIK_7; Name: '7'),
                                   (Code: DIK_8; Name: '8'),
                                   (Code: DIK_9; Name: '9'),
                                   (Code: DIK_0; Name: '0'),
                                   (Code: DIK_MINUS; Name: 'Minus (-)'),
                                   (Code: DIK_EQUALS; Name: 'Equals (=)'),
                                   (Code: DIK_BACK; Name: 'Backspace'),
                                   (Code: DIK_TAB; Name: 'Tab'),
                                   (Code: DIK_Q; Name: 'Q'),
                                   (Code: DIK_W; Name: 'W'),
                                   (Code: DIK_E; Name: 'E'),
                                   (Code: DIK_R; Name: 'R'),
                                   (Code: DIK_T; Name: 'T'),
                                   (Code: DIK_Y; Name: 'Y'),
                                   (Code: DIK_U; Name: 'U'),
                                   (Code: DIK_I; Name: 'I'),
                                   (Code: DIK_O; Name: 'O'),
                                   (Code: DIK_P; Name: 'P'),
                                   (Code: DIK_LBRACKET; Name: 'Left Bracket ([)'),
                                   (Code: DIK_RBRACKET; Name: 'Right Bracket (])'),
                                   (Code: DIK_RETURN; Name: 'Return'),
                                   (Code: DIK_LCONTROL; Name: 'Left Control'),
                                   (Code: DIK_A; Name: 'A'),
                                   (Code: DIK_S; Name: 'S'),
                                   (Code: DIK_D; Name: 'D'),
                                   (Code: DIK_F; Name: 'F'),
                                   (Code: DIK_G; Name: 'G'),
                                   (Code: DIK_H; Name: 'H'),
                                   (Code: DIK_J; Name: 'J'),
                                   (Code: DIK_K; Name: 'K'),
                                   (Code: DIK_L; Name: 'L'),
                                   (Code: DIK_SEMICOLON; Name: 'Semicolon (;)'),
                                   (Code: DIK_APOSTROPHE; Name: 'Aspostrophe ('')'),
                                   (Code: DIK_GRAVE; Name: 'Grave'),
                                   (Code: DIK_LSHIFT; Name: 'Left Shift'),
                                   (Code: DIK_BACKSLASH; Name: 'Backslash'),
                                   (Code: DIK_Z; Name: 'Z'),
                                   (Code: DIK_X; Name: 'X'),
                                   (Code: DIK_C; Name: 'C'),
                                   (Code: DIK_V; Name: 'V'),
                                   (Code: DIK_B; Name: 'B'),
                                   (Code: DIK_N; Name: 'N'),
                                   (Code: DIK_M; Name: 'M'),
                                   (Code: DIK_COMMA; Name: 'Comma (,)'),
                                   (Code: DIK_PERIOD; Name: 'Period (.)'),
                                   (Code: DIK_SLASH; Name: 'Slash (/)'),
                                   (Code: DIK_RSHIFT; Name: 'Right Shift'),
                                   (Code: DIK_MULTIPLY; Name: 'Num Multiply (*)'),
                                   (Code: DIK_LMENU; Name: 'Left Alt'),
                                   (Code: DIK_SPACE; Name: 'Space'),
                                   (Code: DIK_CAPITAL; Name: 'Capital'),
                                   (Code: DIK_F1; Name: 'F1'),
                                   (Code: DIK_F2; Name: 'F2'),
                                   (Code: DIK_F3; Name: 'F3'),
                                   (Code: DIK_F4; Name: 'F4'),
                                   (Code: DIK_F5; Name: 'F5'),
                                   (Code: DIK_F6; Name: 'F6'),
                                   (Code: DIK_F7; Name: 'F7'),
                                   (Code: DIK_F8; Name: 'F8'),
                                   (Code: DIK_F9; Name: 'F9'),
                                   (Code: DIK_F10; Name: 'F10'),
                                   (Code: DIK_NUMLOCK; Name: 'Num Lock'),
                                   (Code: DIK_SCROLL; Name: 'Scroll Lock'),
                                   (Code: DIK_NUMPAD7; Name: 'Num 7'),
                                   (Code: DIK_NUMPAD8; Name: 'Num 8'),
                                   (Code: DIK_NUMPAD9; Name: 'Num 9'),
                                   (Code: DIK_SUBTRACT; Name: 'Num Subtract (-)'),
                                   (Code: DIK_NUMPAD4; Name: 'Num 4'),
                                   (Code: DIK_NUMPAD5; Name: 'Num 5'),
                                   (Code: DIK_NUMPAD6; Name: 'Num 6'),
                                   (Code: DIK_ADD; Name: 'Num Add (+)'),
                                   (Code: DIK_NUMPAD1; Name: 'Num 1'),
                                   (Code: DIK_NUMPAD2; Name: 'Num 2'),
                                   (Code: DIK_NUMPAD3; Name: 'Num 3'),
                                   (Code: DIK_NUMPAD0; Name: 'Num 0'),
                                   (Code: DIK_DECIMAL; Name: 'Num Decimal (.)'),
                                   (Code: DIK_F11; Name: 'F11'),
                                   (Code: DIK_F12; Name: 'F12'),
                                   (Code: DIK_NEXTTRACK; Name: 'Next Track'),
                                   (Code: DIK_NUMPADENTER; Name: 'Num Enter'),
                                   (Code: DIK_RCONTROL; Name: 'Right Control'),
                                   (Code: DIK_MUTE; Name: 'Mute'),
                                   (Code: DIK_CALCULATOR; Name: 'Calculator'),
                                   (Code: DIK_PLAYPAUSE; Name: 'Play/Pause'),
                                   (Code: DIK_MEDIASTOP; Name: 'Media Stop'),
                                   (Code: DIK_VOLUMEDOWN; Name: 'Volume -'),
                                   (Code: DIK_VOLUMEUP; Name: 'Volume +'),
                                   (Code: DIK_WEBHOME; Name: 'Web Home'),
                                   (Code: DIK_DIVIDE; Name: 'Num Divide (/)'),
                                   (Code: DIK_SYSRQ; Name: 'SysRq'),
                                   (Code: DIK_RMENU; Name: 'Right Alt'),
                                   (Code: DIK_PAUSE; Name: 'Pause'),
                                   (Code: DIK_HOME; Name: 'Home'),
                                   (Code: DIK_UP; Name: 'Up Arrow'),
                                   (Code: DIK_PRIOR; Name: 'Page Up'),
                                   (Code: DIK_LEFT; Name: 'Left Arrow'),
                                   (Code: DIK_RIGHT; Name: 'Right Arrow'),
                                   (Code: DIK_END; Name: 'End'),
                                   (Code: DIK_DOWN; Name: 'Down Arrow'),
                                   (Code: DIK_NEXT; Name: 'Page Down'),
                                   (Code: DIK_INSERT; Name: 'Insert'),
                                   (Code: DIK_DELETE; Name: 'Delete'),
                                   (Code: DIK_LWIN; Name: 'Left Winkey'),
                                   (Code: DIK_RWIN; Name: 'Right Winkey'),
                                   (Code: DIK_APPS; Name: 'App Menu'),
                                   (Code: DIK_POWER; Name: 'System Power'),
                                   (Code: DIK_SLEEP; Name: 'System Sleep'),
                                   (Code: DIK_WAKE; Name: 'System WakeUp'),
                                   (Code: DIK_WEBSEARCH; Name: 'Web Search'),
                                   (Code: DIK_WEBFAVORITES; Name: 'Web Favorites'),
                                   (Code: DIK_WEBREFRESH; Name: 'Web Refresh'),
                                   (Code: DIK_WEBSTOP; Name: 'Web Stop'),
                                   (Code: DIK_WEBFORWARD; Name: 'Web Forward'),
                                   (Code: DIK_WEBBACK; Name: 'Web Back'),
                                   (Code: DIK_MYCOMPUTER; Name: 'My Computer'),
                                   (Code: DIK_MAIL; Name: 'Mail'),
                                   (Code: DIK_MEDIASELECT; Name: 'Media Select'));

  procedure GetKeybdList(List: TStrings);
  function GetKeybdIndex(Key: Byte): Byte;
  function GetKeybdKey(Index: Byte): Byte;

implementation

//==============================================================================

procedure GetKeybdList(List: TStrings);
var
  l: integer;
begin
  List.Clear;
  for l:= 0 to KeybdKeysCount-1 do
    List.Add(SKeyboardKeys[l].Name);
end;

//==============================================================================

function GetKeybdIndex(Key: Byte): Byte;
var
  l: integer;
begin
  Result:= $FF;
  for l:= 0 to KeybdKeysCount-1 do
    if (SKeyboardKeys[l].Code = Key) then
      begin
      Result:= l;
      Break;
    end;
end;

//==============================================================================

function GetKeybdKey(Index: Byte): Byte;
begin
  Result:= SKeyboardKeys[Index].Code;
end;

//==============================================================================

end.
