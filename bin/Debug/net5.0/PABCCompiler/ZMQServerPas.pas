{$reference AsyncIO.dll}
{$reference NaCl.dll} 
{$reference NetMQ.dll} 
{$reference System.Buffers.dll} 
{$reference System.Memory.dll} 
{$reference System.Numerics.Vectors.dll} 
{$reference System.Runtime.CompilerServices.Unsafe.dll} 
{$reference System.Threading.Tasks.Extensions.dll} 
{$reference System.ValueTuple.dll}

uses CompileRunHelper;
uses NetMQ.Sockets;
uses NetMQ;
uses PascalABCCompiler.SyntaxTree;
uses PascalABCCompiler.Errors;
uses PascalABCCompiler;
uses System.IO;

function Compile(c: Compiler; myfilename: string): string;
begin
  var co := new CompilerOptions(myfilename,CompilerOptions.OutputType.ConsoleApplicaton);
  co.UseDllForSystemUnits := True;
  co.Debug := False;
  co.ForDebugging := False;
  c.Reload;
  Result := c.Compile(co);
end;

function RunProcess(myexefilename: string): string;
begin
  var outputstring := new StringBuilder;
  var pabcnetcProcess := new System.Diagnostics.Process();
  pabcnetcProcess.StartInfo.FileName := myexefilename;
  pabcnetcProcess.StartInfo.UseShellExecute := false;
  //pabcnetcProcess.StartInfo.CreateNoWindow := true;
  pabcnetcProcess.StartInfo.RedirectStandardOutput := true;
  //pabcnetcProcess.StartInfo.RedirectStandardInput := true;
  //pabcnetcProcess.StartInfo.StandardOutputEncoding := System.Text.Encoding.UTF8;
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
  WriteLn('Server start');  
  var server := new ResponseSocket();
  server.Bind('tcp://*:'+ParamStr(1)); // 5557
  
  StringResourcesLanguage.LoadDefaultConfig();
  var c := new Compiler;
  
  try  
    while True do
    begin
      var code := server.ReceiveFrameString();
      Println(code);

      var myfilename := CreateTempPas(code);
      var myexefilename := Compile(c,myfilename);
      
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
      
      server.SendFrame(output);
    end
  except 
    on e: Exception do
      Println(e);
  end;
  //readln;
  server.Dispose;
end.