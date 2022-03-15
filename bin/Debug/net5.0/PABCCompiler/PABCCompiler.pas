{$zerobasedstrings}
uses CompileRunHelper;
uses PascalABCCompiler.SyntaxTree;
uses PascalABCCompiler.Errors;
uses PascalABCCompiler;
uses PascalABCCompiler.TreeConverter;
uses System.IO;

function Compile(c: Compiler; myfilename: string): string;
begin
  try
    var co := new CompilerOptions(myfilename, CompilerOptions.OutputType.ConsoleApplicaton);
    co.UseDllForSystemUnits := False;
    co.Debug := False;
    co.ForDebugging := False;
    Result := c.Compile(co);
  except
    Result := 'ОШБИЬА'
  end;
end;

begin
  if ParamCount = 0 then
  begin
    Writeln('Требуется параметр - имя .pas-файла');
    exit;
  end;
  StringResourcesLanguage.LoadDefaultConfig();
  MillisecondsDelta;
  var c := new Compiler;
  var myfilename := ParamStr(1);
  var myexefilename := Compile(c, myfilename);
end.