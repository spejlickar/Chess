object Form1: TForm1
  Left = 288
  Top = 110
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 93
  ClientWidth = 135
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 16
    Top = 16
    Width = 25
    Height = 25
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 56
    Top = 16
  end
end
