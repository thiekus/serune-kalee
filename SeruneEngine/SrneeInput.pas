unit SrneeInput;

(*==============================================================================

  Serune Kalee input module
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  Windows, SysUtils, ActiveX, DirectInput, SrneeTypes;

  {$IFDEF SKE_USE_DYNLIB}
  procedure _InitSrneeInput;
  procedure _DeInitSrneeInput;
  {$ENDIF}

  function Ski_GetGameControllerInputState(const InputInterface: IDirectInputDevice8;
                                           var KeyBuffer: TDIJoyState2): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function Ski_GetKeyboardInputState(const InputInterface: IDirectInputDevice8;
                                     var KeyBuffer: TKeyboardBuffer): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function Ski_InputAcquire(const InputInterface: IDirectInputDevice8): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function Ski_InputUnacquire(const InputInterface: IDirectInputDevice8): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function Ski_EnumGameControllerDevices(Callback: TDIEnumDevicesCallback): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function Ski_SetupInput(var InputInterface: IDirectInputDevice8; InputType: TSrInputType;
                                 InputGUID: TGUID; FocusHandle: THandle): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}

implementation

var
  DInput: IDirectInput8;

//==============================================================================

function Ski_GetGameControllerInputState(const InputInterface: IDirectInputDevice8; var KeyBuffer: TDIJoyState2): boolean;
begin

  Result:= FALSE;
  if Succeeded(InputInterface.Poll) then
    Result:= Succeeded(InputInterface.GetDeviceState(SizeOf(TDIJoyState2), @KeyBuffer))

end;

//==============================================================================

function Ski_GetKeyboardInputState(const InputInterface: IDirectInputDevice8; var KeyBuffer: TKeyboardBuffer): boolean;
begin

  Result:= FALSE;
  if Succeeded(InputInterface.Poll) then
    Result:= Succeeded(InputInterface.GetDeviceState(SizeOf(TKeyboardBuffer), @KeyBuffer))

end;

//==============================================================================

function Ski_InputAcquire(const InputInterface: IDirectInputDevice8): boolean;
begin

  Result:= Succeeded(InputInterface.Acquire);

end;

//==============================================================================

function Ski_InputUnacquire(const InputInterface: IDirectInputDevice8): boolean;
begin

  Result:= Succeeded(InputInterface.Unacquire);
  
end;

//==============================================================================

function Ski_EnumGameControllerDevices(Callback: TDIEnumDevicesCallback): boolean;
begin

  Result:= Succeeded(DInput.EnumDevices(DI8DEVCLASS_GAMECTRL, Callback, nil, DIEDFL_ATTACHEDONLY));

end;

//==============================================================================

function Ski_SetupInput(var InputInterface: IDirectInputDevice8; InputType: TSrInputType; InputGUID: TGUID; FocusHandle: THandle): boolean;
var
  ipguid: TGUID;
  aformat: TDIDataFormat;
begin

  if (InputType = itKeybd) then
    ipguid:= GUID_SysKeyboard
  else
    ipguid:= InputGUID;
  Result:= FALSE;
  if Succeeded(DInput.CreateDevice(ipguid, InputInterface, nil)) then
    begin
    if (InputType = itKeybd) then
      aformat:= c_dfDIKeyboard
    else
      aformat:= c_dfDIJoystick2;
    if Succeeded(InputInterface.SetDataFormat(aformat)) then
      begin
      if Succeeded(InputInterface.SetCooperativeLevel(FocusHandle, DISCL_BACKGROUND + DISCL_NONEXCLUSIVE)) then
        begin
        Result:= InputInterface <> nil;
      end;
    end;
  end;

end;

//==============================================================================

procedure _InitSrneeInput;
begin

  // Inisialisasi objek ActiveX
  CoInitialize(nil);

  // Inisialisasi DirectInput
  DirectInput8Create(HInstance, DIRECTINPUT_VERSION,
                     IID_IDirectInput8,
                     DInput,
                     nil);

end;

//==============================================================================

procedure _DeInitSrneeInput;
begin

  DInput:= nil;
  CoUninitialize();

end;

//==============================================================================

{$IFNDEF SKE_NO_RTLINIT}
initialization

  _InitSrneeInput();

finalization

  _DeInitSrneeInput();

{$ENDIF}

end.
