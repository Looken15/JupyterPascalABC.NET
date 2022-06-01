unit RendererModuleJS;

interface

uses FigureModule, AxesModule;

type
  Color = AxesModule.Color;
  Colors = AxesModule.Colors;
  
function EmptyColor: Color;

type
  /// Тип шрифта
  FontOptions = class
  public
    Name: string := 'Arial';
    Color: Color := Colors.Black;
    Size: real := 10;
  end;

  ///контейнер для позиционирования графика
  AxesContainer = class
  private
    fax: Axes;
    fposition: (real, real);
    fsize: (real, real);
    forigin: (real, real);
    fborders: (real, real);
    ffield: (real, real);
    fstep: (real, real);
    foriginxy: (real, real);
    flinewidth: real := 1;  
    ffuncstep: real;
    fnumssize: real;
    fynums: array of real;
    fxnums: array of real;
    fynums_str: array of string;
    fxnums_str: array of string;
    faxesmultipliers: (real, real);
    ffoptnums: FontOptions;
    fcountaxesnums_max: (integer, integer) := (10, 10);
    fcountaxesnums_min: (integer, integer) := (2, 2);
    fptsize: real;
    fptsizexy: real;
    fminmaxx: (real, real);
    fminmaxy: (real, real);
    fnumsfont: FontOptions;
    fbarlabels: array of string;
    fclearablesize: (real, real);
    
    ///Расчёт размера шрифта на осях
    //procedure SetNumSize;
    ///Подбор числа для отсчёта сетки 
    function FindFineNumber: (real, real);
    ///Расчёт чисел на осях
    procedure SetNums;
    ///Расчёт расстояний между точками точечного графика
    procedure SetSpaces;
    ///Заполнение полей
    procedure Init(x, y, size_x, size_y: real; ax: Axes);
    ///Расчёт множителя для отображения
    procedure AxesNumberMultiplier;
  
  public
    ///вернуть график
    property GetAxes: Axes read fax;
    ///позиция графика
    property Position: (real, real) read fposition;
    ///размер графика
    property Size: (real, real) read fsize;
    ///левый нижний угол координатной области
    property Origin: (real, real) read forigin;
    ///отступы от краёв
    property Borders: (real, real) read fborders;
    ///размеры координатной области
    property FieldSize: (real, real) read ffield;
    ///размер единицы по осям координатной области
    property Step: (real, real) read fstep;
    ///значения X и Y в точке origin
    property OriginXY: (real, real) read foriginxy;
    ///абсолютные координаты точки отсчёта графика
    property AbsoluteOrigin: (real, real) read (fposition.Item1 + forigin.Item1, fposition.Item2 + forigin.Item2);
    ///Возвращает толщину отрисовки коорд. элементов
    property LineWidth: real read flinewidth;
    ///Возвращает размер чисел на осях
    property GetNumsSize: real read fnumssize;
    ///Возвращает массив чисел оси Y
    property YNums: array of real read fynums;
    ///Возвращает массив чисел оси X
    property XNums: array of real read fxnums;
    ///Возвращает массив чисел оси Y в строковом виде
    property YNumsStr: array of string read fynums_str;
    ///Возвращает массив чисел оси X в строковом виде
    property XNumsStr: array of string read fxnums_str;
    ///Возвращает размер шрифта чисел на осях
    property NumsFont: FontOptions read fnumsfont write fnumsfont;
    ///Возвращает множитель чисел на осях
    property AxesMultipliers: (real, real) read faxesmultipliers;
    ///Возвращает шрифт для текста
    property GetFontOptions: FontOptions read ffoptnums;
    ///Возвращает шаг для отрисовки функции
    property GetFuncStep: real read ffuncstep;
    ///Возвращает размер единичного штриха
    property GetPtSize: real read fptsize;
    ///Возвращает размер единичного штриха относительно X и Y
    property GetPtSizeXY: real read fptsizexy;
    ///Возвращает подписи столбцов, если заданы
    property GetBarLabels: array of string read fbarlabels;
    ///Возвращает/задаёт размеры правого верхнего угла для зачистки
    property ClearableSize: (real,real )read fclearablesize write fclearablesize;
    
    
    constructor Create(x, y, size_x, size_y: real; ax: Axes);
    begin
      Init(x, y, size_x, size_y, ax);
      AxesNumberMultiplier;
      SetNums;
      //SetNumSize;
      NumsFont := new FontOptions;
      SetSpaces;
    end;
    
    
    
    ///Возвращает размер маркеров по индексу кривой
    function GetMarkerSize(ind: integer): real;
    
    ///Возвращает значение промежутков точечного графика по индексу кривой
    function GetScatterSpace(ind: integer): real;
    
    ///Запускает метод отрисовки, если на контенер наведена мышка
    procedure StartPositionDraw(x, y: real; mousebutton: integer);
  
  end;

///список отображаемых координатных сеток
var
  AxContList := new List<AxesContainer>;

///Отобразить окно с графиком
procedure Show(f: Figure);

///нарисовать график
procedure DrawAxes(x, y, size_x, size_y: real; ax: Axes; fig: Figure);

///Задать размеры окна
procedure WindowSize(width, height: integer);

///Отрисовка кривых одной координатной сетки
procedure DrawCurves(ac: AxesContainer);
///Отрисовка координатного интерфейса
procedure DrawCoordinates(ac: AxesContainer; fig: Figure);
///Отисовка легенды графика
procedure DrawLegend(ac: AxesContainer);
///Отисовка поизиции мыши на графике
procedure DrawMousePosition(ac: AxesContainer; x,y: real);
///Отрисовка линейного графика
procedure DrawLineGraph(ac: AxesContainer; ind: integer);
///Отрисовка линейного графика
procedure DrawScatterGraph(ac: AxesContainer; ind: integer);
///Отрисовка столбчатого графика
procedure DrawBarGraph(ac: AxesContainer; ind: integer);

//функции генерации и вывода JS кода
procedure FillRectangleJS(x,y,w,h:real; fillColor:Color);
procedure DrawRectangleJS(x,y,w,h:real; fillColor,strokeColor:Color; width: real);
procedure DrawLineJS(x1,y1,x2,y2:real; lineColor:Color; width:real);
procedure DrawLinesJS(arr_x,arr_y:List<real>; lineColor:Color; width:real);
procedure FillCircleJS(x,y,r:real; fillColor:Color);
procedure DrawScatterJS(arr_x,arr_y:List<real>; lineColor:Color; r:real);
procedure TextOutJS(x,y:real; text: string; fnt:FontOptions);
procedure TextOutJS(x,y:real; text: string;align_x:string:='left';align_y:string:='top');
procedure OutputJS(text :string);
procedure SetAxesNumsSizeJS(ac:AxesContainer);
procedure SetSizeByWHJS(text,font_name:string;w,h:real);

procedure NeedButtons(flag: boolean);

implementation

///Нужна ли отрисовка кнопок
var drawUI := false;
///шаг отрисовки
var
  step := 0.1;
///Размеры окна (костыль)
var
  w := 800;
  h := 600;
///отступы между графиками по осям X и Y
var
  Borders := (10, 8);
///отображаемый экземпляр Figure
var
  fig: Figure;
///вывод JS код
var
  output: StringBuilder = new StringBuilder();
///кол-во символов после которого происходит вывод
var
  symbolsToOutput := 100000;
var
  prevOutputCount := 0;
var curOutputId := '';


procedure NeedButtons(flag: boolean):= drawUI := flag;

function ARGB(a,r,g,b: byte) := new Color(r, g, b, a);
function EmptyColor: Color := ARGB(0,0,0,0);

procedure Show(f: Figure);
begin
  fig := f;
  curOutputId := System.DateTime.UtcNow.Ticks.ToString;
  OutputJS('<html><canvas width="'+w+'" height="'+h+'" id="'+curOutputId+'"></canvas>');
  var tmp := ReadAllText('JSPlotterBegin.txt');
  output += tmp.Replace(NewLine,' ').Replace('cx','cx_'+curOutputId).
                                     Replace('cv','cv_'+curOutputId).
                                     Replace('axes','axes_'+curOutputId).
                                     Replace('writePosition','writePosition_'+curOutputId).
                                     Replace('getCursorPosition','getCursorPosition_'+curOutputId).
                                     Replace('downloadCnv','downloadCnv_'+curOutputId).
                                     Replace('copyCnv','copyCnv_'+curOutputId); 
  OutputJS('cv_'+curOutputId+' = document.getElementById("'+curOutputId+'");');
  OutputJS('cx_'+curOutputId+' = cv_'+curOutputId+'.getContext("2d");');
  
  OutputJS('cv_'+curOutputId+'.addEventListener("mousemove", function(e){getCursorPosition_'+curOutputId+'(cv_'+curOutputId+', e);});');
  FillRectangleJS(0,0,w,h,fig.GetFacecolor);
	
  
  var axes_x_size := ((w - Borders.Item1) / fig.GetAxesMatrix.ColCount) - Borders.Item1;
  var axes_y_size := ((h - Borders.Item2) / fig.GetAxesMatrix.RowCount) - Borders.Item2;
  
  for var k := 0 to fig.GetAxes.Count - 1 do
  begin
    var row := Borders.Item2 * 1.0;
    var col := Borders.Item1 * 1.0; 
    var x, y: integer;
    for var i := 0 to fig.GetAxesMatrix.RowCount - 1 do
    begin
      col := Borders.Item1 * 1.0; 
      var founded := false;
      for var j := 0 to fig.GetAxesMatrix.ColCount - 1 do
      begin
        if fig.GetAxesMatrix[i, j] <> k then
        begin
          col += axes_x_size + Borders.Item1;
          continue;
        end;
        (x, y) := (j, i);
        founded := true;
        break;
      end;
      if founded then
        break;
      row += axes_y_size + Borders.Item2;
    end;
    
    (var count_x, var count_y) := (0, 0);
    while (x < fig.GetAxesMatrix.ColCount) and (fig.GetAxesMatrix[y, x] = k) do
    begin
      x += 1;
      count_x += 1;
    end;
    x -= 1;
    while (y < fig.GetAxesMatrix.RowCount) and (fig.GetAxesMatrix[y, x] = k) do
    begin
      y += 1;
      count_y += 1;
    end;

    DrawAxes(col, row, (axes_x_size * count_x) + (Borders.Item1 * (count_x - 1)),
                      (axes_y_size * count_y) + (Borders.Item2 * (count_y - 1)),
                        fig.GetAxes[k], fig);   
  end;
  OutputJS('SetPositionFontSize();');
  OutputJS('</script></html>');
  
  if drawUI then
  begin
    var addition := ReadAllText('JSUIAddition.txt').Replace(NewLine,' ');
    addition := addition.Replace('downloadCnv','downloadCnv_'+curOutputId).
                         Replace('copyCnv','copyCnv_'+curOutputId);
    OutputJS(addition);
  end;
  Console.WriteLine(output.ToString);
end;

procedure DrawAxes(x, y, size_x, size_y: real; ax: Axes; fig: Figure);
begin
  var ax_cont := new AxesContainer(x, y, size_x, size_y, ax); 
  
  var flag := 'false';
  if ax.TrackMouse then
    flag := 'true';
  var s := 'axes_'+curOutputId+'.push({x:'+ax_cont.Position.Item1.ToString+','+   //position
                      'y:'+ax_cont.Position.Item2.ToString+','+
                      'width:'+ax_cont.Size.Item1.ToString+','+       //size
                      'height:'+ax_cont.Size.Item2.ToString+','+
                      'field_x:'+(ax_cont.Position.Item1+ax_cont.fborders.Item1).ToString+','+  //field position
                      'field_y:'+(ax_cont.Position.Item2+ax_cont.fborders.Item2).ToString+','+  
                      'field_width:'+(ax_cont.Size.Item1-2*ax_cont.fborders.Item1).ToString+','+    //field size
                      'field_height:'+(ax_cont.Size.Item2-2*ax_cont.fborders.Item2).ToString+','+
                      'origin_x:'+(ax_cont.Position.Item1+ax_cont.fborders.Item1).ToString+','+  //origin
                      'origin_y:'+(ax_cont.Position.Item2+ax_cont.Size.Item2-ax_cont.fborders.Item2).ToString+','+
                      'need_position:'+flag+','+   //need track mouse
                      'position_width:'+ax_cont.Size.Item1/3+','+   //position size
                      'position_height:'+ax_cont.fborders.Item2*0.9+','+
                      'position_font_size:'+(ax_cont.NumsFont.Size/96*72).ToString+','+
                      'position_font_name:"'+ax_cont.NumsFont.Name+'",'+
                      'R:'+fig.GetFacecolor.R+',G:'+fig.GetFacecolor.G+',B:'+fig.GetFacecolor.B+','
                      'step_x:'+ax_cont.Step.Item1+',step_y:'+ax_cont.Step.Item2+','
                      'field_origin_x:'+ax_cont.OriginXY.Item1+',field_origin_y:'+ax_cont.OriginXY.Item2+
                      '});';
  
  AxContList.Add(ax_cont);
  
  DrawCoordinates(ax_cont, fig);
  DrawCurves(ax_cont);
  DrawLegend(ax_cont);

  
  
 OutputJS(s);
 
end;

procedure DrawCoordinates(ac: AxesContainer; fig: Figure);
begin
  var (field_x, field_y) := ac.fieldsize;
  var (x_border, y_border) := ac.borders;
  var origin := ac.origin;
  var (x, y) := ac.Position;
  var (size_x, size_y) := ac.Size;
  var(x_mult, y_mult) := ac.AxesMultipliers;
  
  
  
  FillRectangleJS(x,y,size_x,size_y,fig.GetFacecolor);        
          
  
  //название
  if (ac.GetAxes.Title <> nil) and (ac.GetAxes.Title.Length > 0) then
  begin
    ac.ClearableSize := (size_x/3, y_border*0.9);
    SetSizeByWHJS(ac.GetAxes.Title,ac.NumsFont.Name,size_x/3,y_border);
    TextOutJS(x+size_x/2,y,ac.GetAxes.Title,'center');
  end;
  
  //Область рисования для Axes
  DrawRectangleJS(ac.AbsoluteOrigin.Item1,ac.AbsoluteOrigin.Item2 - field_y,
                field_x, field_y,ac.GetAxes.GetFacecolor,Colors.Black,ac.LineWidth * 0.5);
  
  var fnt := ac.NumsFont;
  SetAxesNumsSizeJS(ac);
  //отрисовка чёрточек и сетки
  var temp := origin.Item1 + (ac.Xnums[0] - ac.originxy.Item1) * ac.Step.Item1;
  for var i := 0 to ac.XNums.Length - 1 do 
  begin
    if temp > field_x + x_border then
      break;
    if ac.GetBarLabels = nil then
    begin
      DrawLineJS(x+temp,y+origin.Item2,x+temp,y + origin.Item2 + y_border * 0.3,Colors.Black,ac.LineWidth * 0.5);
      TextOutJS(x + temp,y + origin.Item2 + y_border * 0.35,ac.XNums[i].ToString,'center');
    end;
    
    //сетка
    if ac.GetAxes.grid then
    begin
      DrawLineJS(x + temp, y + origin.Item2, x + temp, y + y_border, 
                  Colors.Gray, ac.LineWidth * 0.5);
    end;
    
    
    temp += ac.Step.Item1 * x_mult;
  end;
  
  temp := origin.Item2 - (ac.Ynums[0] - ac.originxy.Item2) * ac.Step.Item2;
  for var i := 0 to ac.YNums.Length - 1 do 
  begin
    if temp < y_border then
      break;
    DrawLineJS(x + origin.Item1, y + temp, x + origin.Item1 - x_border * 0.3, 
                y + temp, Colors.Black, ac.LineWidth * 0.5);
    TextOutJS(x + origin.Item1 - x_border * 0.4,y + temp,ac.YNums[i].ToString,'right','center');
    
    //сетка
    if ac.GetAxes.grid then
    begin
      DrawLineJS(x + origin.Item1, y + temp, x + x_border + field_x, y + temp, 
                  Colors.Gray, ac.LineWidth * 0.5);            
    end;
    
    temp -= ac.Step.Item2 * y_mult;
  end;
  
  
end;

procedure DrawLegend(ac: AxesContainer);
begin
  if (not ac.GetAxes.NeedLegend) then
    exit;
  
  var (field_x, field_y) := ac.fieldsize;
  var (x_border, y_border) := ac.borders;
  var origin := ac.origin;
  var (x, y) := ac.Position;
  var (size_x, size_y) := ac.Size;
  var(x_mult, y_mult) := ac.AxesMultipliers;
  var crv := ac.GetAxes.GetCurves;
  
  var with_names := new List<integer>;
  for var i := 0 to crv.Count-1 do
    if crv[i].HasName then
      with_names.Add(i);
  
  if with_names.Count = 0 then
    exit;
  
  var h := field_y/3;
  var w := field_x/7;
  var fnt := new FontOptions;
  fnt.Size := ac.NumsFont.Size;
  var split := h*0.05;
  var h1 := (h-split*with_names.Count)/with_names.Count;
  
  
  var l_pos :=(x+field_x+x_border-w*1.1, y+y_border+h*0.1);
  
  var cur_y:= l_pos.Item2 + split;


  DrawRectangleJS(l_pos.Item1, l_pos.Item2,
                  w,h,Colors.White,Colors.Black,ac.flinewidth*0.5);
  
  var cl: Color;
  foreach var i in with_names do
  begin
    cl := crv[i].GetFacecolor;
    case (crv[i].GetCurveType) of
      CurveType.ScatterGraph: 
      begin
        FillCircleJS(l_pos.Item1+w*0.25,cur_y+h1/2,h1*0.4,cl);
      end;
      CurveType.LineGraph: 
      begin
        DrawLineJS(l_pos.Item1+w*0.1,cur_y+h1/2,l_pos.Item1+w*0.3,cur_y+h1/2,
                    cl,crv[i].linewidth*ac.GetPtSize);
      end;
      CurveType.barGraph: 
      begin
        DrawRectangleJS(l_pos.Item1+w*0.1,cur_y,w*0.2,h1*0.8,cl,EmptyColor,0);
      end;
    end;
    SetSizeByWHJS(crv[i].Name,ac.NumsFont.Name,w*0.5,h1);
    TextOutJS(l_pos.Item1+w*0.4,cur_y+h1/4,crv[i].Name,'left');
    //TextOutJS(l_pos.Item1+w*0.4,cur_y+h1/4,crv[i].Name,fnt);
    cur_y += h1+split;
  end;

end;

procedure DrawCurves(ac: AxesContainer);
begin
  for var i := 0 to ac.GetAxes.GetCurves.Count - 1 do
  begin
    var crv := ac.GetAxes.GetCurves[i];
    case (crv.GetCurveType) of
      CurveType.LineGraph: DrawLineGraph(ac, i);
      CurveType.ScatterGraph: DrawScatterGraph(ac, i);
      CurveType.BarGraph: DrawBarGraph(ac, i);
      //вызов отрисовки нового типа графика
    end;
  end;
end;

procedure DrawBarGraph(ac: AxesContainer; ind: integer);
begin
  var crv := ac.GetAxes.GetCurves[ind];
  var o_x := ac.absoluteOrigin.Item1;
  var o_y := ac.absoluteOrigin.Item2;
  var markersize := ac.GetMarkerSize(ind);
  
  var (x_border, y_border) := ac.borders;
  var (xx, yy) := ac.Position;
  var (size_x, size_y) := ac.Size;
  var null_y := o_y + ac.originxy.Item2 * ac.step.Item2;
  
  var width_draw := (crv.width / 2) * ac.step.Item1;
  


  for var i := 0 to crv.X.Length - 1 do
  begin
    var x := ((crv.X[i] - crv.width / 2) - ac.originxy.Item1) * ac.step.Item1;
    var h := abs(crv.Y[i]) * ac.step.Item2;
    
    if ac.GetBarLabels <> nil then
    begin
      DrawLineJS(o_x + x + width_draw, o_y, o_x + x + width_draw, 
                 o_y + y_border * 0.3, Colors.Black, ac.LineWidth * 0.5);  
      TextOutJS(o_x + x + width_draw,o_y + y_border * 0.35,crv.GetBarLabels[i],'center');
    end;
    if (crv.Y[i] > 0) then
    begin
      DrawRectangleJS(o_x + x, null_y - h, crv.width * ac.Step.Item1,
                      h, crv.GetFacecolor, Colors.Black, crv.linewidth * 0.5);
    end
    else
    begin
      DrawRectangleJS(o_x + x, null_y, crv.width * ac.Step.Item1,
                      h, crv.GetFacecolor, Colors.Black, crv.linewidth * 0.5);
    end;
    
  end;

end;

procedure DrawLineGraph(ac: AxesContainer; ind: integer);
begin
  var func_step := ac.GetFuncStep;
  var crv := ac.GetAxes.GetCurves[ind];
  var o_x := ac.absoluteOrigin.Item1;
  var o_y := ac.absoluteOrigin.Item2;
  
  var (x_border, y_border) := ac.borders;
  var (xx, yy) := ac.Position;
  var (size_x, size_y) := ac.Size;
  
  //Массивы для JS функций
  var arr_x := new List<real>();
  var arr_y := new List<real>();
  
  if crv.IsFunctional then
  begin
    var ax := ac.GetAxes;
    var (x_min, x_max) := ax.GetXLim;
    var (y_min, y_max) := ax.GetYLim;
    var (x_bounded, y_bounded) := (ax.isxbounded, ax.isybounded);
    
    
    var x := x_min;
    if (not x_bounded) or (ac.OriginXY.Item1 > x_min) then
      x := ac.OriginXY.Item1;
    var y: real?;
    var (prev_x, prev_y) := (0.0, 0.0);
    
    while (true) do
    begin
      var draw_x := o_x + (x - ac.originxy.Item1) * ac.step.Item1;
      
      if (x_bounded and (x >= x_max))
          or (draw_x > xx + size_x - x_border) then
        break;
      
      y := crv.GetY(x);
      if (not y.HasValue) or 
         (y_bounded and ((y.Value < y_min) or (y.Value > y_max))) then
      begin
        x += func_step;
        continue;
      end;
      
      var draw_y := o_y - (y.Value - ac.originxy.Item2) * ac.step.Item2;
      
      if (draw_x < xx + x_border)  or
          (draw_y < yy + y_border) or 
          (draw_y > yy + size_y - y_border) then
      begin
        x += func_step;
        continue;
      end;
      
      if (prev_x, prev_y) = (0.0, 0.0) then
      begin
        arr_x.Add(draw_x); arr_y.Add(draw_y);
        (prev_x, prev_y) := (draw_x, draw_y);
        x += func_step;
        continue;
      end;
      

      arr_x.Add(draw_x); arr_y.Add(draw_y);
      
      (prev_x, prev_y) := (draw_x, draw_y);
      x += func_step;

    end;
    DrawLinesJS(arr_x,arr_y,crv.GetFacecolor,crv.linewidth * ac.GetPtSize);
    exit;
  end;

  var x1 := (crv.X[0] - ac.originxy.Item1) * ac.step.Item1;
  var y1 := (crv.Y[0] - ac.originxy.Item2) * ac.step.Item2;
  arr_x.Add(o_x + x1); arr_y.Add(o_y - y1);
  for var i := 1 to crv.X.Length - 1 do
  begin
    var x := (crv.X[i] - ac.originxy.Item1) * ac.step.Item1;
    var y := (crv.Y[i] - ac.originxy.Item2) * ac.step.Item2;
    arr_x.Add(o_x + x); arr_y.Add(o_y - y);
    
    (x1, y1) := (x, y);
  end;

  DrawLinesJS(arr_x,arr_y,crv.GetFacecolor,crv.linewidth * ac.GetPtSize);
end;

procedure DrawScatterGraph(ac: AxesContainer; ind: integer);
begin
  
  var crv := ac.GetAxes.GetCurves[ind];
  var o_x := ac.absoluteOrigin.Item1;
  var o_y := ac.absoluteOrigin.Item2;
  var markersize := ac.GetMarkerSize(ind);
  
  var (x_border, y_border) := ac.borders;
  var (xx, yy) := ac.Position;
  var (size_x, size_y) := ac.Size;
  
  //Массивы для JS функций
  var arr_x := new List<real>();
  var arr_y := new List<real>();
  
  if crv.IsFunctional then
  begin
    var func_step := ac.GetScatterSpace(ind);
    var ax := ac.GetAxes;
    var (x_min, x_max) := ax.GetXLim;
    var (y_min, y_max) := ax.GetYLim;
    var (x_bounded, y_bounded) := (ax.isxbounded, ax.isybounded);
    
    //FastDraw(dc_curve ->
    begin
      var x := x_min;
      if (not x_bounded) or (ac.OriginXY.Item1 > x_min) then
        x := ac.OriginXY.Item1;
      var y: real?;
      
      while (true) do
      begin
        var draw_x := o_x + (x - ac.originxy.Item1) * ac.step.Item1;
        
        if (x_bounded and (x >= x_max))
            or (draw_x > xx + size_x - x_border) then
          break;
        
        y := crv.GetY(x);
        if (not y.HasValue) or 
           (y_bounded and ((y.Value < y_min) or (y.Value > y_max))) then
        begin
          x += func_step;
          continue;
        end;
        
        var draw_y := o_y - (y.Value - ac.originxy.Item2) * ac.step.Item2;
        
        if (draw_x < xx + x_border)  or
            (draw_y < yy + y_border) or 
            (draw_y > yy + size_y - y_border) then
        begin
          x += func_step;
          continue;
        end;
        
        arr_x.Add(draw_x); arr_y.Add(draw_y);
        x += func_step;
      end; 
    end;
    DrawScatterJS(arr_x,arr_y,crv.GetFacecolor,markersize);
    exit;
  end;
  

  for var i := 0 to crv.X.Length - 1 do
  begin
    var x := (crv.X[i] - ac.originxy.Item1) * ac.step.Item1;
    var y := (crv.Y[i] - ac.originxy.Item2) * ac.step.Item2;
    
    arr_x.Add(o_x + x); arr_y.Add(o_y - y);
  end;

  DrawScatterJS(arr_x,arr_y,crv.GetFacecolor,markersize);
end;

procedure WindowSize(width, height: integer);
begin
  w := width;
  h := height;
end;

//////////////////////////////////

procedure AxesContainer.StartPositionDraw(x, y: real; mousebutton: integer);
begin
  var x1, y1: real;
  if (x >= AbsoluteOrigin.Item1) 
      and (x <= AbsoluteOrigin.Item1 + FieldSize.Item1)
      and (y <= AbsoluteOrigin.Item2)
      and (y >= AbsoluteOrigin.Item2 - FieldSize.Item2) then
  begin
    x1 := OriginXY.Item1 + (x - AbsoluteOrigin.Item1) / Step.Item1;
    y1 := OriginXY.Item2 + (AbsoluteOrigin.Item2 - y) / Step.Item2;
    DrawMousePosition(self, x1, y1);
  end; 
end;

procedure AxesContainer.SetNums;
begin
  var fine := FindFineNumber;
  var num := fine.Item1;
  fxnums := new real[fcountaxesnums_max.Item1];
  fxnums_str := new string[fcountaxesnums_max.Item1];
  for var i := 0 to fcountaxesnums_max.Item1 - 1 do
  begin
    fxnums_str[i] := num.ToString;
    fxnums[i] := num;
    num += faxesmultipliers.Item1;
  end;
  
  num := fine.Item2;
  fynums_str := new string[fcountaxesnums_max.Item2];
  fynums := new real[fcountaxesnums_max.Item2];
  for var i := 0 to fcountaxesnums_max.Item1 - 1 do
  begin
    fynums_str[i] := num.ToString;
    fynums[i] := num;
    num += faxesmultipliers.Item2;
  end;
end;

function AxesContainer.FindFineNumber: (real, real);
begin
  var x := faxesmultipliers.Item1;
  var left_bound := OriginXY.Item1;
  if x <> left_bound then
  begin
    if x < left_bound then
      while x < left_bound do
        x += faxesmultipliers.Item1
    else
      while x >= left_bound + faxesmultipliers.Item1 do
        x -= faxesmultipliers.Item1;
  end;
  
  var y := faxesmultipliers.Item2;
  var down_bound := OriginXY.Item2;
  if y <> down_bound then
  begin
    if y < down_bound then
      while y < down_bound do
        y += faxesmultipliers.Item2
    else
      while y >= down_bound + faxesmultipliers.Item2 do
        y -= faxesmultipliers.Item2;
  end;
  Result := (x, y);
end;

procedure AxesContainer.Init(x, y, size_x, size_y: real; ax: Axes);
begin
  fax := ax;
  fposition := (x, y);
  fsize := (size_x, size_y);
  fborders := (size_x * 0.05, size_y * 0.07);
  forigin := (fborders.Item1, size_y - fborders.Item2);
  fclearablesize := (size_x/2, fborders.Item2*0.9);
  
      //отступы от краёв
  var x_border := fborders.Item1;
  var y_border := fborders.Item2;
      //размеры поля
  var field_x := size_x - x_border * 2;
  var field_y := size_y - y_border * 2;
  ffield := (field_x, field_y);
  
      //длина единицы
  var step_x := field_x / 20;
  var step_y := field_y / 10;
  
  
      //определение границ графика, если есть
  var hasarrays_flag := false;
  var onlybars_flag := true;
  var y_positive_flag := true;
  var min_x := real.MaxValue;
  var max_x := real.MinValue;
  var min_y := real.MaxValue;
  var max_y := real.MinValue;
  
  for var j := 0 to ax.GetCurves.Count - 1 do
  begin
    var curve := ax.GetCurves[j];
    
    if curve.IsFunctional then
    begin
      onlybars_flag := false;
      y_positive_flag := false;
      continue;
    end;
    hasarrays_flag := true;
    
    if curve.GetCurveType = CurveType.BarGraph then
    begin
      if curve.GetBarLabels <> nil then
        fbarlabels := curve.GetBarLabels;
      if (curve.X[0] - curve.width / 2 < min_x) then
        min_x := curve.X[0] - curve.width / 2;
      if (curve.X[curve.X.Length - 1] + curve.width / 2 > max_x) then
        max_x := curve.X[curve.X.Length - 1] + curve.width / 2;
    end
    else
    begin
      onlybars_flag := false;
      if (curve.X[0] < min_x) then
        min_x := curve.X[0];
      if (curve.X[curve.X.Length - 1] > max_x) then
        max_x := curve.X[curve.X.Length - 1];
    end;
    
    for var i := 0 to curve.Y.Length - 1 do
    begin
      if y_positive_flag and (curve.Y[i] < 0) then
        y_positive_flag := false;
      if curve.Y[i] < min_y then
        min_y := curve.Y[i];
      if curve.Y[i] > max_y then
        max_y := curve.Y[i];
    end;
  end;
  
  //коэф сдвига графика
  var (shift_x, shift_y) := (0.1, 0.1);
  
  //шаг,если заданы значения
  if onlybars_flag and y_positive_flag then
    min_y := 0;
  
  if hasarrays_flag then
  begin
    if not ax.isxbounded then
      step_x := field_x / ((max_x - min_x) * (1 + 2 * shift_x));
    
    if not ax.isybounded then
      step_y := field_y / ((max_y - min_y) * (1 + 2 * shift_y));
  end
      else
  begin
    min_x := ax.GetXLim.Item1;
    max_x := ax.GetXLim.Item2;
    min_y := ax.GetYLim.Item1;
    max_y := ax.GetYLim.Item2;
  end;
  
  if (ax.isxbounded) then
  begin
    step_x := field_x / (ax.GetXLim.Item2 - ax.GetXLim.Item1);
    min_x := ax.GetXLim.Item1;
    max_x := ax.GetXLim.Item2;
  end;
  
  if (ax.isybounded) then
  begin
    step_y := field_y / (ax.GetYLim.Item2 - ax.GetYLim.Item1);
    min_y := ax.GetYLim.Item1;
    max_y := ax.GetYLim.Item2;
  end;
  
  fminmaxx := (min_x, max_x);
  fminmaxy := (min_y, max_y);
  
  if ax.EqualProportion then
    (step_x, step_y) := (min(step_x, step_y), min(step_x, step_y));
  
  var (x_range, y_range) := (max_x - min_x, max_y - min_y);
  
  if onlybars_flag then
    foriginxy := (min_x - x_range * shift_x, min_y)
  else
    foriginxy := (min_x - x_range * shift_x, min_y - y_range * shift_y);
  
  fstep := (step_x, step_y);
  ffuncstep := (max_x - min_x) / (field_x * 0.8);
  fptsize := min(field_x, field_y) / 200; 
  
end;

procedure AxesContainer.AxesNumberMultiplier;
begin
  var (step_x, step_y) := Step;
  var (field_x, field_y) := FieldSize;
  
  var x_mult1 := 1.0;
  var x_mult2 := 1.0;
  
  while field_x / (step_x * x_mult1 * x_mult2) > fcountaxesnums_max.Item1 do
  begin
    if x_mult1 = 1.0 then
    begin
      x_mult1 := 2.0;
      continue;
    end;
    if x_mult1 = 2.0 then
      x_mult1 := 5.0
    else 
      (x_mult1, x_mult2) := (1.0, x_mult2 * 10);
  end;
  
  while field_x / (step_x * x_mult1 * x_mult2) < fcountaxesnums_min.Item1 do
  begin
    if x_mult1 = 1.0 then
    begin
      x_mult1 := 0.5;
      continue;
    end;
    if x_mult1 = 0.5 then
      x_mult1 := 0.2
    else 
      (x_mult1, x_mult2) := (1.0, x_mult2 * 0.1);
  end;
  
  var y_mult1 := 1.0;
  var y_mult2 := 1.0;
  
  while field_y / (step_y * y_mult1 * y_mult2) > fcountaxesnums_max.Item2 do
  begin
    if y_mult1 = 1.0 then
    begin
      y_mult1 := 2.0;
      continue;
    end;
    if y_mult1 = 2.0 then
      y_mult1 := 5.0
    else 
      (y_mult1, y_mult2) := (1.0, y_mult2 * 10);
  end;
  
  while field_y / (step_y * y_mult1 * y_mult2) < fcountaxesnums_min.Item2 do
  begin
    if y_mult1 = 1.0 then
    begin
      y_mult1 := 0.5;
      continue;
    end;
    if y_mult1 = 0.5 then
      y_mult1 := 0.2
    else 
      (y_mult1, y_mult2) := (1.0, y_mult2 * 0.1);
  end;
  
  faxesmultipliers := (x_mult1 * x_mult2, y_mult1 * y_mult2);
end;

procedure AxesContainer.SetSpaces;
begin
end;

function AxesContainer.GetMarkerSize(ind: integer): real;
begin
  Result := GetAxes.GetCurves[ind].get_markersize * GetPtSize;
end;

function AxesContainer.GetScatterSpace(ind: integer): real;
begin
  var (min_x, max_x) := fminmaxx;
  var (field_x, field_y) := ffield;
  var markersize := GetMarkerSize(ind);
  var space := GetAxes.GetCurves[ind].spacesize * GetPtSize;
  Result := (max_x - min_x) / min(field_x / (space + markersize), field_y / (space + markersize));
end;

procedure DrawMousePosition(ac: AxesContainer; x,y: real);
begin
  var (x_border, y_border) := ac.borders;
  var (x_glob, y_glob) := ac.Position;
  var (size_x, size_y) := ac.Size;
  
  var fnt := ac.NumsFont;
  
  var x_str,y_str: string;
  Str(x:0:3,x_str); Str(y:0:3,y_str);
  var text := 'X: '+x_str+' Y: '+y_str;
end;

procedure FillRectangleJS(x,y,w,h:real; fillColor:Color);
begin
	OutputJS('Rct('+x.ToString('0.000')+','+y.ToString('0.000')+','+w+','+h+','+fillColor.R+','+fillColor.G+','+fillColor.B+');');
end;

procedure DrawRectangleJS(x,y,w,h:real; fillColor, strokeColor:Color; width: real);
begin
	OutputJS('Rct('+x.ToString('0.000')+','+y.ToString('0.000')+','+w+','+h+','+fillColor.R+','+fillColor.G+','+fillColor.B+','+
					width+','+strokeColor.R+','+strokeColor.G+','+strokeColor.B+');');
end;

procedure DrawLinesJS(arr_x,arr_y:List<real>; lineColor:Color; width:real);
begin
  var temp := new StringBuilder();
  temp += 'Lns([';
  for var i:= 0 to arr_x.Count-1 do
    temp += arr_x[i].ToString('0.000')+',';
  temp +='],[';
  for var i:= 0 to arr_y.Count-1 do
    temp += arr_y[i].ToString('0.000')+',';
  temp+='],'+width+','+lineColor.R+','+lineColor.G+','+lineColor.B+');';
  OutputJS(temp.ToString);
end;

procedure DrawLineJS(x1,y1,x2,y2:real; lineColor:Color; width:real);
begin
   OutputJS('cx_'+curOutputId+'.strokeStyle = "rgb('+lineColor.R+','+lineColor.G+','+lineColor.B+')";'+
            'cx_'+curOutputId+'.lineWidth = '+width+';'+
            'cx_'+curOutputId+'.beginPath();'+
            'cx_'+curOutputId+'.moveTo('+x1.ToString('0.000')+','+y1.ToString('0.000')+');'+
            'cx_'+curOutputId+'.lineTo('+x2.ToString('0.000')+','+y2.ToString('0.000')+');'+
            'cx_'+curOutputId+'.stroke();');
end;

procedure FillCircleJS(x,y,r:real; fillColor:Color);
begin
   OutputJS('cx_'+curOutputId+'.fillStyle = "rgb('+fillColor.R+','+fillColor.G+','+fillColor.B+')";'+
            'cx_'+curOutputId+'.beginPath();'+
            'cx_'+curOutputId+'.arc('+x.ToString('0.000')+','+y.ToString('0.000')+','+r+',0,'+(Pi*2)+');'+
            'cx_'+curOutputId+'.fill();');
end;

procedure DrawScatterJS(arr_x,arr_y:List<real>; lineColor:Color; r:real);
begin
  var temp := new StringBuilder();
  temp += 'Sct([';
  for var i:= 0 to arr_x.Count-1 do
    temp += arr_x[i].ToString('0.000')+',';
  temp +='],[';
  for var i:= 0 to arr_y.Count-1 do
    temp += arr_y[i].ToString('0.000')+',';
  temp+='],'+r+','+lineColor.R+','+lineColor.G+','+lineColor.B+');';
  OutputJS(temp.ToString);
end;

procedure TextOutJS(x,y:real; text: string; fnt:FontOptions);
begin
  //y := y+TextHeightPFont(text,fnt)*0.15;
  OutputJS('cx_'+curOutputId+'.font = "'+ (fnt.Size/96*72) +'pt '+fnt.Name+'";'+
            'cx_'+curOutputId+'.fillStyle = "black";'+
            'cx_'+curOutputId+'.textAlign = "left";'+
            'cx_'+curOutputId+'.textBaseline = "top";'+
            'cx_'+curOutputId+'.fillText("'+text+'", '+x.ToString('0.000')+','+y.ToString('0.000')+');');
end;

procedure TextOutJS(x,y:real; text: string; align_x,align_y:string);
begin
  
  OutputJS('Txt('+x.ToString('0.000')+','+y.ToString('0.000')+',"'+text+'","'+align_x+'","'+align_y+'");');
end;

procedure SetSizeByWHJS(text,font_name:string;w,h:real);
begin
  OutputJS('GetSizeByWH("'+text+'","'+font_name+'",'+w+','+h+');'); 
end;

procedure SetAxesNumsSizeJS(ac:AxesContainer);
begin
  OutputJS('SetAxesNumsSize('+ac.Position.Item1.ToString('0.000')+','+
            ac.Position.Item2.ToString('0.000')+',[');
  for var i := 0 to ac.XNums.length-2 do
    OutputJS(ac.XNums[i]+',');
  OutputJS(ac.XNums[ac.XNums.length-1]+'],[');
  for var i := 0 to ac.YNums.length-2 do
    OutputJS(ac.YNums[i]+',');
  OutputJS(ac.YNums[ac.YNums.length-1]+'],'+ac.fborders.Item1+','+ac.fborders.Item2+',"'+
            ac.NumsFont.Name+'");');
end;

procedure OutputJS(text :string);
begin
  output.Append(text);
  //if output.Length-prevOutputCount > symbolsToOutput then
  //begin
  //  Console.WriteLine(output.ToString+'</script></html>');
  //  prevOutputCount := output.Length;
  //end;
end;


initialization
end. 