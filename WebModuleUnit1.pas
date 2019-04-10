unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

Uses
  NumeroPorExtenso;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  NumeroPorExtenso: TNumeroPorExtenso;
begin
  NumeroPorExtenso := TNumeroPorExtenso.Create;
  try
    NumeroPorExtenso.sNumero := Request.PathInfo;
    Response.Content := '{ "extenso":  "' + NumeroPorExtenso.sNumeroPorExtenso + '" }';
{      '<html>' +
      '<head><title>Web Server Application</title></head>' +
      '<body>' + NumeroPorExtenso.sNumeroPorExtenso + ' </body>' +
      '</html>';}
  finally
    NumeroPorExtenso.Free;
  end;
end;

end.
