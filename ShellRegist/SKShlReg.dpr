program SKShlReg;

(*==============================================================================

  Serune Kalee Shell Integerator (SKShlReg.exe)
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

{.$APPTYPE CONSOLE}
{$R *.RES}
{$R ADMIN.RES}

uses
  Windows, SysUtils, Registry, ShlObj;

const
  MsgNoArg = 'Cara menggunakan:'#13#10#10#10+
             'Register: SKShlReg -r <ProgramPath>'#13#10+
             'Unregister: SKShlReg -u';

resourcestring
  RegDesc =  'Serune Kalee Instrument Table';
  RegExt  = '.skt';
  RegIndx = '1';
  RegType = 'SeruneKalee.Instrument';

  // Param 1: argumen
  // Param 2: Lokasi file program

var
  Reg: TRegistry;
begin

  if (ParamStr(1) = '-r') then
    begin

    Reg:= TRegistry.Create;
    try

      Reg.RootKey:= HKEY_CLASSES_ROOT;
      Reg.OpenKey(RegExt, TRUE);
      Reg.WriteString('', RegType);
      Reg.CloseKey;

      Reg.OpenKey(RegType, TRUE);
      Reg.WriteString('', RegDesc);
      Reg.CloseKey;

      Reg.OpenKey(RegType + '\DefaultIcon', TRUE);
      Reg.WriteString('', ParamStr(2) + ',' + RegIndx);
      Reg.CloseKey;

      Reg.OpenKey(RegType + '\Shell\Open', True);
      Reg.WriteString('', '&Open');
      Reg.CloseKey;

      Reg.OpenKey(RegType + '\Shell\Open\Command', True);
      Reg.WriteString('', '"' + ParamStr(2) + '" "%1"');
      Reg.CloseKey;

      SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);

    finally

      Reg.Free;

    end;

  
  end
  else
  if (ParamStr(1) = '-u') then
    begin

    Reg:= TRegistry.Create;
    try

      Reg.RootKey:= HKEY_CLASSES_ROOT;
      
      Reg.DeleteKey(RegExt);
      Reg.DeleteKey(RegType + '\Shell\Open\Command');
      Reg.DeleteKey(RegType + '\Shell\Open');
      Reg.DeleteKey(RegType + '\DefaultIcon');
      Reg.DeleteKey(RegType);

      SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);

    finally

      Reg.Free;

    end;

  end
  else
    begin
    MessageBox(0, PChar(MsgNoArg ), PChar('Shell Integerator'), MB_ICONINFORMATION);
  end;

end.
 