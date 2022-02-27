unit CompileRunHelper;
{$zerobasedstrings}
{$reference Errors.dll} 
{$reference Localization.dll}
{$reference NetGenerator.dll} 
{$reference ParserTools.dll} 
{$reference PascalABCParser.dll}
{$reference SemanticTree.dll} 
{$reference SyntaxTree.dll}
{$reference SyntaxTreeConverters.dll}
{$reference SyntaxVisitors.dll}
{$reference TreeConverter.dll}
{$reference YieldHelpers.dll}
{$reference OptimizerConversion.dll}
{$reference CompilerTools.dll}
{$reference Compiler.dll}

uses PascalABCCompiler.Errors;
uses System.IO;

function CreateTempPas(code: string): string;
begin
  var myfilename := Path.GetTempFileName();
  myfilename := ChangeFileNameExtension(myfilename,'pas');
  WriteAllText(myfilename,code);
  Result := myfilename
end;

function EnhanceErrorMsg(err0: Object): string;
begin
  var err: LocatedError := err0 as LocatedError;
  var msg := err.ToString;
  var ind1 := msg.IndexOf('(');
  var ind2 := msg.IndexOf(')');
  var pos := '';
  if (ind1 > -1) and (ind2 > -1) then
  begin
    pos := msg?[ind1:ind2+1];
  end;
  if (ind2 > -1) and (ind2 < msg.Length) then
    ind2 := msg.IndexOf(':',ind2);
  if (ind2 > -1) and (ind2 < msg.Length-1) then
    ind2 := msg.IndexOf(':',ind2+1);
  Result := Trim(msg?[ind2+1:]);
  if pos <> '' then
    Result := pos + ': ' + Result;
  if err0 is SemanticError(var semErr) then
  begin
    pos := '(' + semErr.Location.begin_line_num + ',' + semErr.Location.begin_column_num + ')';
    Result := pos + ': ' + Result;
  end;
end;

begin
end.