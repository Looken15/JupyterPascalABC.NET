unit AxesModule;

interface
//{$reference 'PresentationCore.dll'}

//{$apptype windows}
//uses System.Windows;
//uses System.Windows.Media;

  ///цвет
type
  Color = record
  public
     R:byte := 255;
     G:byte := 255;
     B:byte := 255;
     A:byte := 255;
    
    constructor Create(r,g,b:byte; a:byte := 255);
    begin
      Self.R := r;
      Self.G := g;
      Self.B := b;
      Self.A := a;
    end;
  end;
  
  ///основные цветовые константы
type
  Colors = static class
  public
    static IndianRed := new Color(205, 92, 92);
    static LightCoral := new Color(240, 128, 128);
    static Salmon := new Color(250, 128, 114);
    static DarkSalmon := new Color(233, 150, 122);
    static LightSalmon := new Color(255, 160, 122);
    static Crimson := new Color(220, 20, 60);
    static Red := new Color(255, 0, 0);
    static FireBrick := new Color(178, 34, 34);
    static DarkRed := new Color(139, 0, 0);
    static Pink := new Color(255, 192, 203);
    static LightPink := new Color(255, 182, 193);
    static HotPink := new Color(255, 105, 180);
    static DeepPink := new Color(255, 20, 147);
    static MediumVioletRed := new Color(199, 21, 133);
    static PaleVioletRed := new Color(219, 112, 147);
    static Coral := new Color(255, 127, 80);
    static Tomato := new Color(255, 99, 71);
    static OrangeRed := new Color(255, 69, 0);
    static DarkOrange := new Color(255, 140, 0);
    static Orange := new Color(255, 165, 0);
    static Gold := new Color(255, 215, 0);
    static Yellow := new Color(255, 255, 0);
    static LightYellow := new Color(255, 255, 224);
    static LemonChiffon := new Color(255, 250, 205);
    static LightGoldenrodYellow := new Color(250, 250, 210);
    static PapayaWhip := new Color(255, 239, 213);
    static Moccasin := new Color(255, 228, 181);
    static PeachPuff := new Color(255, 218, 185);
    static PaleGoldenrod := new Color(238, 232, 170);
    static Khaki := new Color(240, 230, 140);
    static DarkKhaki := new Color(189, 183, 107);
    static Lavender := new Color(230, 230, 250);
    static Thistle := new Color(216, 191, 216);
    static Plum := new Color(221, 160, 221);
    static Violet := new Color(238, 130, 238);
    static Orchid := new Color(218, 112, 214);
    static Fuchsia := new Color(255, 0, 255);
    static Magenta := new Color(255, 0, 255);
    static MediumOrchid := new Color(186, 85, 211);
    static MediumPurple := new Color(147, 112, 219);
    static BlueViolet := new Color(138, 43, 226);
    static DarkViolet := new Color(148, 0, 211);
    static DarkOrchid := new Color(153, 50, 204);
    static DarkMagenta := new Color(139, 0, 139);
    static Purple := new Color(128, 0, 128);
    static Indigo := new Color(75, 0, 130);
    static SlateBlue := new Color(106, 90, 205);
    static DarkSlateBlue := new Color(72, 61, 139);
    static Cornsilk := new Color(255, 248, 220);
    static BlanchedAlmond := new Color(255, 235, 205);
    static Bisque := new Color(255, 228, 196);
    static NavajoWhite := new Color(255, 222, 173);
    static Wheat := new Color(245, 222, 179);
    static BurlyWood := new Color(222, 184, 135);
    static Tan := new Color(210, 180, 140);
    static RosyBrown := new Color(188, 143, 143);
    static SandyBrown := new Color(244, 164, 96);
    static Goldenrod := new Color(218, 165, 32);
    static DarkGoldenRod := new Color(184, 134, 11);
    static Peru := new Color(205, 133, 63);
    static Chocolate := new Color(210, 105, 30);
    static SaddleBrown := new Color(139, 69, 19);
    static Sienna := new Color(160, 82, 45);
    static Brown := new Color(165, 42, 42);
    static Maroon := new Color(128, 0, 0);
    static Black := new Color(0, 0, 0);
    static Gray := new Color(128, 128, 128);
    static Silver := new Color(192, 192, 192);
    static White := new Color(255, 255, 255);
    static Olive := new Color(128, 128, 0);
    static Lime := new Color(0, 255, 0);
    static Green := new Color(0, 128, 0);
    static Aqua := new Color(0, 255, 255);
    static Teal := new Color(0, 128, 128);
    static Blue := new Color(0, 0, 255);
    static Navy := new Color(0, 0, 128);
    static GreenYellow := new Color(173, 255, 47);
    static Chartreuse := new Color(127, 255, 0);
    static LawnGreen := new Color(124, 252, 0);
    static LimeGreen := new Color(50, 205, 50);
    static PaleGreen := new Color(152, 251, 152);
    static LightGreen := new Color(144, 238, 144);
    static MediumSpringGreen := new Color(0, 250, 154);
    static SpringGreen := new Color(0, 255, 127);
    static MediumSeaGreen := new Color(60, 179, 113);
    static SeaGreen := new Color(46, 139, 87);
    static ForestGreen := new Color(34, 139, 34);
    static DarkGreen := new Color(0, 100, 0);
    static YellowGreen := new Color(154, 205, 50);
    static OliveDrab := new Color(107, 142, 35);
    static DarkOliveGreen := new Color(85, 107, 47);
    static MediumAquamarine := new Color(102, 205, 170);
    static DarkSeaGreen := new Color(143, 188, 143);
    static LightSeaGreen := new Color(32, 178, 170);
    static DarkCyan := new Color(0, 139, 139);
    static Cyan := new Color(0, 255, 255);
    static LightCyan := new Color(224, 255, 255);
    static PaleTurquoise := new Color(175, 238, 238);
    static Aquamarine := new Color(127, 255, 212);
    static Turquoise := new Color(64, 224, 208);
    static MediumTurquoise := new Color(72, 209, 204);
    static DarkTurquoise := new Color(0, 206, 209);
    static CadetBlue := new Color(95, 158, 160);
    static SteelBlue := new Color(70, 130, 180);
    static LightSteelBlue := new Color(176, 196, 222);
    static PowderBlue := new Color(176, 224, 230);
    static LightBlue := new Color(173, 216, 230);
    static SkyBlue := new Color(135, 206, 235);
    static LightSkyBlue := new Color(135, 206, 250);
    static DeepSkyBlue := new Color(0, 191, 255);
    static DodgerBlue := new Color(30, 144, 255);
    static CornflowerBlue := new Color(100, 149, 237);
    static MediumSlateBlue := new Color(123, 104, 238);
    static RoyalBlue := new Color(65, 105, 225);
    static MediumBlue := new Color(0, 0, 205);
    static DarkBlue := new Color(0, 0, 139);
    static MidnightBlue := new Color(25, 25, 112);
    static Snow := new Color(255, 250, 250);
    static Honeydew := new Color(240, 255, 240);
    static MintCream := new Color(245, 255, 250);
    static Azure := new Color(240, 255, 255);
    static AliceBlue := new Color(240, 248, 255);
    static GhostWhite := new Color(248, 248, 255);
    static WhiteSmoke := new Color(245, 245, 245);
    static Seashell := new Color(255, 245, 238);
    static Beige := new Color(245, 245, 220);
    static OldLace := new Color(253, 245, 230);
    static FloralWhite := new Color(255, 250, 240);
    static Ivory := new Color(255, 255, 240);
    static AntiqueWhite := new Color(250, 235, 215);
    static Linen := new Color(250, 240, 230);
    static LavenderBlush := new Color(255, 240, 245);
    static MistyRose := new Color(255, 228, 225);
    static Gainsboro := new Color(220, 220, 220);
    static LightGrey := new Color(211, 211, 211);
    static LightGray := new Color(211, 211, 211);
    static DarkGray := new Color(169, 169, 169);
    static DarkGrey := new Color(169, 169, 169);
    static Grey := new Color(128, 128, 128);
    static DimGray := new Color(105, 105, 105);
    static DimGrey := new Color(105, 105, 105);
    static LightSlateGray := new Color(119, 136, 153);
    static LightSlateGrey := new Color(119, 136, 153);
    static SlateGray := new Color(112, 128, 144);
    static SlateGrey := new Color(112, 128, 144);
    static DarkSlateGray := new Color(47, 79, 79);
    static DarkSlateGrey := new Color(47, 79, 79);
  end;
  
  ///типы кривой
type
  CurveType = (LineGraph, ScatterGraph, BarGraph, FillBetweenGraph);

///класс кривой
type
  Curve = class
  private
    fname: string;
    ffunc: real-> real;
    ftype: CurveType;
    x_arr: array of real;
    y_arr: array of real;
    facecolor: Color;
    fmarkersize: real := 2.0;
    fspacesize: real := 3.0;
    flinewidth: real := 1.0;
    fbarwidth: real;
    fbarlabels: array of string;
  
  public
    ///вернуть тип кривой
    property GetCurveType: CurveType read ftype;
    ///вернуть/задать название кривой
    property Name: string read fname write fname;
    ///вернуть функцию
    property Func: real-> real read ffunc;
    ///вернуть массив X
    property X: array of real read x_arr;
    ///вернуть массив Y
    property Y: array of real read y_arr;
    ///вернуть цвет кривой
    property GetFacecolor: Color read facecolor;
    ///вернуть/задать размер маркеров
    property MarkerSize: real read fmarkersize write fmarkersize;
    ///вернуть/задать размер промежутков между маркерами
    property SpaceSize: real read fspacesize write fspacesize;
    ///вернуть/задать толщину линии графика
    property LineWidth: real read flinewidth write flinewidth;
    ///вернуть/задать ширину столбцов
    property Width: real read fbarwidth write fbarwidth;
    ///вернуть подписи столбцов
    property GetBarLabels: array of string read fbarlabels;
    
    constructor Create(f: real-> real; ct: CurveType; cl: Color);
    begin
      ftype := ct;
      facecolor := cl;
      ffunc := f;
    end;
    
    constructor Create(x, y: array of real; ct: CurveType; cl: Color);
    begin
      if (x.Length = 0) or (y.Length = 0) then
        raise new Exception('Отстутствие входных параметров X или Y!');
      if (x.Length <> y.Length) then
        raise new Exception('Недостаток введённых данных!');
      
      ftype := ct;
      facecolor := cl;
      x_arr := x;
      y_arr := y;
      ffunc := nil;
      if ct = CurveType.BarGraph then
        if x.Length = 1 then
          fbarwidth := x[0] / 2
        else
          fbarwidth := x[2] - x[1];
    end;
    
    ///возвращает значение функции в точке
    function GetY(x: real): real?;
    ///возвращает true, если задана функцией
    function IsFunctional(): boolean;
    ///возвращает true, если есть название кривой
    function HasName(): boolean;
    
    ///установить цвет кривой
    procedure SetFacecolor(col: Color);
    ///установить подписи столбцов
    procedure SetBarLabels(labels: array of string);
  end;

///Класс области рисования
type
  Axes = class
  
  private
    Xlim: (real, real) := (-10.0, 10.0);
    Ylim: (real, real) := (-10.0, 10.0);
    curvesList: List<Curve> := new List<Curve>();
    
    facecolor: Color := Colors.White;
    
    fisXBounded: boolean := false;
    fisYBounded: boolean := false;
    fGrid: boolean := false;
    fEqProp: boolean := false;
    flegend: boolean := false;
    ftitle: string;
    ftrackmouse: boolean := true;
    
    function checkX(x: array of real): boolean;
  
  public
    constructor Create();
    begin
    end;
    
    ///Вернуть/задать название координатной области
    property Title: string read ftitle write ftitle;
    ///Отображение координатной сетки
    property Grid: boolean read fgrid write fgrid;
    ///пропорциональное отображение по обеим осям
    property EqualProportion: boolean read fEqProp write fEqProp;
    ///вернуть цвет фона
    property GetFacecolor: Color read facecolor;
    ///Ограничен ли X
    property IsXBounded: boolean read fisXBounded;
    ///Ограничен ли Y
    property IsYBounded: boolean read fisYBounded;
    ///Вернуть список кривых
    property GetCurves: List<Curve> read curvesList;
    ///Вернуть границы по оси Х
    property GetXLim: (real, real) read Xlim;
    ///Вернуть границы по оси Y
    property GetYLim: (real, real) read Ylim;
    ///Отображение легенды
    property NeedLegend: boolean read flegend write flegend;
    ///Отображение текущей позиции курсора мыши в координатах графика
    property TrackMouse: boolean read ftrackmouse write ftrackmouse;
    
    ///Построить линейный график по функции
    function Plot(f: real-> real; cl: Color): Curve;
    ///Построить линейный график по массиву Y
    function Plot(y: array of real; cl: Color): Curve;
    ///Построить линейный график по массивам X и Y
    function Plot(x, y: array of real; cl: Color): Curve;
    ///Построить точечный график 
    function Scatter(f: real-> real; cl: Color): Curve;
    ///Построить точечный график по массиву Y
    function Scatter(y: array of real; cl: Color): Curve;
    ///Построить точечный график по массивам X и Y
    function Scatter(x, y: array of real; cl: Color): Curve;
    ///Построить столбчатый график по массиву Y
    function Bar(y: array of real; cl: Color): Curve;
    ///Построить столбчатый график по массивам X и Y
    function Bar(x, y: array of real; cl: Color): Curve;
    
    ///Построить линейный график по функции
    function Plot(f: real-> real): Curve;
    ///Построить линейный график по массиву Y
    function Plot(y: array of real): Curve;
    ///Построить линейный график по массивам X и Y
    function Plot(x, y: array of real): Curve;
    ///Построить точечный график 
    function Scatter(f: real-> real): Curve;
    ///Построить точечный график по массиву Y
    function Scatter(y: array of real): Curve;
    ///Построить точечный график по массивам X и Y
    function Scatter(x, y: array of real): Curve;
    ///Построить столбчатый график по массиву Y
    function Bar(y: array of real): Curve;
    ///Построить столбчатый график по массивам X и Y
    function Bar(x, y: array of real): Curve;
    
    ///Задать границы по оси X
    procedure SetXLim(a, b: real);
    ///Задать границы по оси Y
    procedure SetYLim(a, b: real);
    ///Задать легенду графика
    procedure SetLegend(legend: array of string); 
    ///установить цвет фона
    procedure SetFacecolor(col: Color);
  
  end;

///возвращает цвет по строке
function ColorFromString(cl: string): Color;

implementation

function Axes.Plot(f: real-> real; cl: Color): Curve;
begin
  var c: Curve := new Curve(f, CurveType.LineGraph, cl);
  curvesList.Add(c);
  fEqProp := true;
  Result := c;
end;
function Axes.Plot(y: array of real; cl: Color): Curve;
begin
  Result := Plot((0..y.Length - 1).Select(x -> x * 1.0).ToArray, y, cl);
end;
function Axes.Plot(x, y: array of real; cl: Color): Curve;
begin
  var c := new Curve(x, y, CurveType.LineGraph, cl);
  curvesList.Add(c);
  Result := c;
end;
function Axes.Scatter(f: real-> real; cl: Color): Curve;
begin
  var c: Curve := new Curve(f, CurveType.ScatterGraph, cl);
  curvesList.Add(c);
  fEqProp := true;
  Result := c;
end;
function Axes.Scatter(y: array of real; cl: Color): Curve;
begin
  Result := Scatter((0..y.Length - 1).Select(x -> x * 1.0).ToArray, y, cl);
end;
function Axes.Scatter(x, y: array of real; cl: Color): Curve;
begin
  var c: Curve := new Curve(x, y, CurveType.ScatterGraph, cl);
  curvesList.Add(c);
  Result := c;
end;
function Axes.Bar(y: array of real; cl: Color): Curve;
begin
  Result := Bar((1..y.Length).Select(x -> x * 1.0).ToArray, y, cl);
end;
function Axes.Bar(x, y: array of real; cl: Color): Curve;
begin
  if not checkX(x) then
    raise new Exception('Разное расстояние между элементами X!');
  var c: Curve := new Curve(x, y, CurveType.BarGraph, cl);
  curvesList.Add(c);
  Result := c;
end;

function Axes.Plot(f: real-> real):=Plot(f,Colors.Red);
function Axes.Plot(y: array of real):=Plot(y,Colors.Red);
function Axes.Plot(x, y: array of real):=Plot(x,y,Colors.Red);
function Axes.Scatter(f: real-> real):=Scatter(f,Colors.Red);
function Axes.Scatter(y: array of real):=Scatter(y,Colors.Red);
function Axes.Scatter(x, y: array of real):=Scatter(x,y,Colors.Red);
function Axes.Bar(y: array of real):=Bar(y,Colors.Red);
function Axes.Bar(x, y: array of real):=Bar(x,y,Colors.Red);

procedure Axes.SetXLim(a, b: real);
begin
  Self.fisxbounded := true;
  Self.Xlim := (a, b);
end;

procedure Axes.SetYLim(a, b: real);
begin
  Self.fisybounded := true;
  Self.Ylim := (a, b);
end;


function Axes.checkX(x: array of real): boolean;
begin
  if x.Length > 1 then
  begin
    var delta := x[1] - x[0];
    for var i := 2 to x.Length - 1 do
      if x[i] - x[i - 1] <> delta then
      begin
        Result := false;
        exit;
      end;
  end;
  Result := true;
end;

procedure Axes.SetLegend(legend: array of string);
begin
  if (legend = nil) or (legend.length <> curvesList.Count) then
    raise new Exception('Ошибочные входные параметры!');
  for var i := 0 to legend.Length - 1 do
    curvesList[i].Name := legend[i];
  flegend := true;
end;

procedure Axes.SetFacecolor(col: Color) := facecolor := col;

///////////////////////////////////////////////////////////////

function Curve.GetY(x: real): real?;
begin
  if func <> nil then
  begin
    Result := func(x);
    exit;
  end;
  
  if (x < x_arr[0]) or (x > x_arr[x_arr.Length - 1]) then
  begin
    Result := nil;
    exit;
  end;
  
  for var i := 1 to x_arr.Length - 1 do
    if (x >= x_arr[i - 1]) and (x < x_arr[i]) then
    begin
      Result := y_arr[i - 1];
      exit;
    end;
  
  Result := y_arr[y_arr.Length - 1];
end;

function ColorFromString(cl: string):Color;
begin
  cl := cl.ToLower();
  case cl of
    'indianred': begin Result := Colors.IndianRed; exit; end;
    'lightcoral': begin Result := Colors.LightCoral; exit; end;
    'salmon': begin Result := Colors.Salmon; exit; end;
    'darksalmon': begin Result := Colors.DarkSalmon; exit; end;
    'lightsalmon': begin Result := Colors.LightSalmon; exit; end;
    'crimson': begin Result := Colors.Crimson; exit; end;
    'red': begin Result := Colors.Red; exit; end;
    'firebrick': begin Result := Colors.FireBrick; exit; end;
    'darkred': begin Result := Colors.DarkRed; exit; end;
    'pink': begin Result := Colors.Pink; exit; end;
    'lightpink': begin Result := Colors.LightPink; exit; end;
    'hotpink': begin Result := Colors.HotPink; exit; end;
    'deeppink': begin Result := Colors.DeepPink; exit; end;
    'mediumvioletred': begin Result := Colors.MediumVioletRed; exit; end;
    'palevioletred': begin Result := Colors.PaleVioletRed; exit; end;
    'coral': begin Result := Colors.Coral; exit; end;
    'tomato': begin Result := Colors.Tomato; exit; end;
    'orangered': begin Result := Colors.OrangeRed; exit; end;
    'darkorange': begin Result := Colors.DarkOrange; exit; end;
    'orange': begin Result := Colors.Orange; exit; end;
    'gold': begin Result := Colors.Gold; exit; end;
    'yellow': begin Result := Colors.Yellow; exit; end;
    'lightyellow': begin Result := Colors.LightYellow; exit; end;
    'lemonchiffon': begin Result := Colors.LemonChiffon; exit; end;
    'lightgoldenrodyellow': begin Result := Colors.LightGoldenrodYellow; exit; end;
    'papayawhip': begin Result := Colors.PapayaWhip; exit; end;
    'moccasin': begin Result := Colors.Moccasin; exit; end;
    'peachpuff': begin Result := Colors.PeachPuff; exit; end;
    'palegoldenrod': begin Result := Colors.PaleGoldenrod; exit; end;
    'khaki': begin Result := Colors.Khaki; exit; end;
    'darkkhaki': begin Result := Colors.DarkKhaki; exit; end;
    'lavender': begin Result := Colors.Lavender; exit; end;
    'thistle': begin Result := Colors.Thistle; exit; end;
    'plum': begin Result := Colors.Plum; exit; end;
    'violet': begin Result := Colors.Violet; exit; end;
    'orchid': begin Result := Colors.Orchid; exit; end;
    'fuchsia': begin Result := Colors.Fuchsia; exit; end;
    'magenta': begin Result := Colors.Magenta; exit; end;
    'mediumorchid': begin Result := Colors.MediumOrchid; exit; end;
    'mediumpurple': begin Result := Colors.MediumPurple; exit; end;
    'blueviolet': begin Result := Colors.BlueViolet; exit; end;
    'darkviolet': begin Result := Colors.DarkViolet; exit; end;
    'darkorchid': begin Result := Colors.DarkOrchid; exit; end;
    'darkmagenta': begin Result := Colors.DarkMagenta; exit; end;
    'purple': begin Result := Colors.Purple; exit; end;
    'indigo': begin Result := Colors.Indigo; exit; end;
    'slateblue': begin Result := Colors.SlateBlue; exit; end;
    'darkslateblue': begin Result := Colors.DarkSlateBlue; exit; end;
    'cornsilk': begin Result := Colors.Cornsilk; exit; end;
    'blanchedalmond': begin Result := Colors.BlanchedAlmond; exit; end;
    'bisque': begin Result := Colors.Bisque; exit; end;
    'navajowhite': begin Result := Colors.NavajoWhite; exit; end;
    'wheat': begin Result := Colors.Wheat; exit; end;
    'burlywood': begin Result := Colors.BurlyWood; exit; end;
    'tan': begin Result := Colors.Tan; exit; end;
    'rosybrown': begin Result := Colors.RosyBrown; exit; end;
    'sandybrown': begin Result := Colors.SandyBrown; exit; end;
    'goldenrod': begin Result := Colors.Goldenrod; exit; end;
    'darkgoldenrod': begin Result := Colors.DarkGoldenRod; exit; end;
    'peru': begin Result := Colors.Peru; exit; end;
    'chocolate': begin Result := Colors.Chocolate; exit; end;
    'saddlebrown': begin Result := Colors.SaddleBrown; exit; end;
    'sienna': begin Result := Colors.Sienna; exit; end;
    'brown': begin Result := Colors.Brown; exit; end;
    'maroon': begin Result := Colors.Maroon; exit; end;
    'black': begin Result := Colors.Black; exit; end;
    'gray': begin Result := Colors.Gray; exit; end;
    'silver': begin Result := Colors.Silver; exit; end;
    'white': begin Result := Colors.White; exit; end;
    'olive': begin Result := Colors.Olive; exit; end;
    'lime': begin Result := Colors.Lime; exit; end;
    'green': begin Result := Colors.Green; exit; end;
    'aqua': begin Result := Colors.Aqua; exit; end;
    'teal': begin Result := Colors.Teal; exit; end;
    'blue': begin Result := Colors.Blue; exit; end;
    'navy': begin Result := Colors.Navy; exit; end;
    'greenyellow': begin Result := Colors.GreenYellow; exit; end;
    'chartreuse': begin Result := Colors.Chartreuse; exit; end;
    'lawngreen': begin Result := Colors.LawnGreen; exit; end;
    'limegreen': begin Result := Colors.LimeGreen; exit; end;
    'palegreen': begin Result := Colors.PaleGreen; exit; end;
    'lightgreen': begin Result := Colors.LightGreen; exit; end;
    'mediumspringgreen': begin Result := Colors.MediumSpringGreen; exit; end;
    'springgreen': begin Result := Colors.SpringGreen; exit; end;
    'mediumseagreen': begin Result := Colors.MediumSeaGreen; exit; end;
    'seagreen': begin Result := Colors.SeaGreen; exit; end;
    'forestgreen': begin Result := Colors.ForestGreen; exit; end;
    'darkgreen': begin Result := Colors.DarkGreen; exit; end;
    'yellowgreen': begin Result := Colors.YellowGreen; exit; end;
    'olivedrab': begin Result := Colors.OliveDrab; exit; end;
    'darkolivegreen': begin Result := Colors.DarkOliveGreen; exit; end;
    'mediumaquamarine': begin Result := Colors.MediumAquamarine; exit; end;
    'darkseagreen': begin Result := Colors.DarkSeaGreen; exit; end;
    'lightseagreen': begin Result := Colors.LightSeaGreen; exit; end;
    'darkcyan': begin Result := Colors.DarkCyan; exit; end;
    'cyan': begin Result := Colors.Cyan; exit; end;
    'lightcyan': begin Result := Colors.LightCyan; exit; end;
    'paleturquoise': begin Result := Colors.PaleTurquoise; exit; end;
    'aquamarine': begin Result := Colors.Aquamarine; exit; end;
    'turquoise': begin Result := Colors.Turquoise; exit; end;
    'mediumturquoise': begin Result := Colors.MediumTurquoise; exit; end;
    'darkturquoise': begin Result := Colors.DarkTurquoise; exit; end;
    'cadetblue': begin Result := Colors.CadetBlue; exit; end;
    'steelblue': begin Result := Colors.SteelBlue; exit; end;
    'lightsteelblue': begin Result := Colors.LightSteelBlue; exit; end;
    'powderblue': begin Result := Colors.PowderBlue; exit; end;
    'lightblue': begin Result := Colors.LightBlue; exit; end;
    'skyblue': begin Result := Colors.SkyBlue; exit; end;
    'lightskyblue': begin Result := Colors.LightSkyBlue; exit; end;
    'deepskyblue': begin Result := Colors.DeepSkyBlue; exit; end;
    'dodgerblue': begin Result := Colors.DodgerBlue; exit; end;
    'cornflowerblue': begin Result := Colors.CornflowerBlue; exit; end;
    'mediumslateblue': begin Result := Colors.MediumSlateBlue; exit; end;
    'royalblue': begin Result := Colors.RoyalBlue; exit; end;
    'mediumblue': begin Result := Colors.MediumBlue; exit; end;
    'darkblue': begin Result := Colors.DarkBlue; exit; end;
    'midnightblue': begin Result := Colors.MidnightBlue; exit; end;
    'snow': begin Result := Colors.Snow; exit; end;
    'honeydew': begin Result := Colors.Honeydew; exit; end;
    'mintcream': begin Result := Colors.MintCream; exit; end;
    'azure': begin Result := Colors.Azure; exit; end;
    'aliceblue': begin Result := Colors.AliceBlue; exit; end;
    'ghostwhite': begin Result := Colors.GhostWhite; exit; end;
    'whitesmoke': begin Result := Colors.WhiteSmoke; exit; end;
    'seashell': begin Result := Colors.Seashell; exit; end;
    'beige': begin Result := Colors.Beige; exit; end;
    'oldlace': begin Result := Colors.OldLace; exit; end;
    'floralwhite': begin Result := Colors.FloralWhite; exit; end;
    'ivory': begin Result := Colors.Ivory; exit; end;
    'antiquewhite': begin Result := Colors.AntiqueWhite; exit; end;
    'linen': begin Result := Colors.Linen; exit; end;
    'lavenderblush': begin Result := Colors.LavenderBlush; exit; end;
    'mistyrose': begin Result := Colors.MistyRose; exit; end;
    'gainsboro': begin Result := Colors.Gainsboro; exit; end;
    'lightgrey': begin Result := Colors.LightGrey; exit; end;
    'lightgray': begin Result := Colors.LightGray; exit; end;
    'darkgray': begin Result := Colors.DarkGray; exit; end;
    'darkgrey': begin Result := Colors.DarkGrey; exit; end;
    'grey': begin Result := Colors.Grey; exit; end;
    'dimgray': begin Result := Colors.DimGray; exit; end;
    'dimgrey': begin Result := Colors.DimGrey; exit; end;
    'lightslategray': begin Result := Colors.LightSlateGray; exit; end;
    'lightslategrey': begin Result := Colors.LightSlateGrey; exit; end;
    'slategray': begin Result := Colors.SlateGray; exit; end;
    'slategrey': begin Result := Colors.SlateGrey; exit; end;
    'darkslategray': begin Result := Colors.DarkSlateGray; exit; end;
    'darkslategrey': begin Result := Colors.DarkSlateGrey; exit; end;
  end;
  Result := Colors.Black;
end;

function Curve.IsFunctional(): boolean := x_arr = nil;

procedure Curve.SetFacecolor(col: Color) := facecolor := col;

procedure Curve.SetBarLabels(labels: array of string);
begin
  if isfunctional or (labels = nil) or 
     (x_arr = nil) or (x_arr.Length <> labels.Length) then
    raise new Exception('Ошибочные входные параметры!');
  fbarlabels := labels;
end;

function Curve.HasName(): boolean := (fname <> nil) and (fname.Length > 0);


initialization

finalization

//раздел финализации

end. 