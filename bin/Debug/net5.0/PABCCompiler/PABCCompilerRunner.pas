{$zerobasedstrings}
uses CompileRunHelper;
uses PascalABCCompiler.SyntaxTree;
uses PascalABCCompiler.Errors;
uses PascalABCCompiler;
uses PascalABCCompiler.TreeConverter;
uses System.IO;

function Compile(c: Compiler; myfilename: string): string;
begin
  var co := new CompilerOptions(myfilename,CompilerOptions.OutputType.ConsoleApplicaton);
  co.UseDllForSystemUnits := False;
  co.Debug := False;
  co.ForDebugging := False;
  Result := c.Compile(co);
end;

function RunProcess(myexefilename: string): string;
begin
  var outputstring := new StringBuilder;
  var pabcnetcProcess := new System.Diagnostics.Process();
  pabcnetcProcess.StartInfo.FileName := myexefilename;
  pabcnetcProcess.StartInfo.UseShellExecute := false;
  //pabcnetcProcess.StartInfo.CreateNoWindow := true;
  //pabcnetcProcess.StartInfo.RedirectStandardInput := true;
  //pabcnetcProcess.StartInfo.StandardOutputEncoding := System.Text.Encoding.UTF8;
  pabcnetcProcess.StartInfo.RedirectStandardOutput := True;
  pabcnetcProcess.EnableRaisingEvents := true;
  var outputOverflow := False;
  pabcnetcProcess.OutputDataReceived += procedure(o,e) -> begin
    if e.Data <> nil then
      if not outputOverflow then
      begin  
        outputstring.Append(e.Data);
        if outputstring.Length > 10000 then
        begin
          outputstring.Length := 10000;
          outputOverflow := True;
          outputstring.Append('...');
        end;
        outputstring.AppendLine;
      end;  
  end;
  pabcnetcProcess.Start();
  pabcnetcProcess.BeginOutputReadLine();
  pabcnetcProcess.WaitForExit(5000);
  if not pabcnetcProcess.HasExited then // убить процесс если он работвет больше 5 секунд. Скорее всего он завис
  begin  
    pabcnetcProcess.Kill;
    outputstring.AppendLine('Программа завершена. Она работала более 5 секунд и, вероятно, зависла');
  end;  
  Result := outputstring.ToString;
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
  var myexefilename := Compile(c,myfilename);
  //Println('Время компиляции:',MillisecondsDelta);
  
  var output := '';
  if myexefilename = nil then
  begin
    if c.ErrorsList.Count > 0 then
    begin  
      var err := c.ErrorsList[0];
      output := EnhanceErrorMsg(err) + NewLine;
    end;  
  end
  else output := RunProcess(myexefilename);
  Writeln(output);
end.