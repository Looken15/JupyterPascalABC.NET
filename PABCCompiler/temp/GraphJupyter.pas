unit GraphJupyter;

interface

{$reference 'PresentationCore.dll'}
{$reference 'PresentationFramework.dll'}
{$reference 'WindowsBase.dll'}

{$apptype windows}
uses System.Windows;
uses System.Windows.Media;


//uses FigureModule, AxesModule;

///шаг отрисовки
var
  step := 0.1;
///Размеры окна (костыль)
var
  w, h: real;
///вывод JS код
var
  output: StringBuilder = new StringBuilder();
///кол-во символов после которого происходит вывод
var
  symbolsToOutput := 100000;

var
  prevOutputCount := 0;

type
  /// Цветовые константы
  Colors = System.Windows.Media.Colors;
  /// Тип цвета
  Color = System.Windows.Media.Color;
  /// Тип цвета
  GColor = System.Windows.Media.Color;
  /// Тип прямоугольника
  GRect = System.Windows.Rect;
  /// Тип окна
  GPen = System.Windows.Media.Pen;
  /// Тип точки
  Point = System.Windows.Point;
  /// Тип точки
  GPoint = System.Windows.Point;
  /// Тип вектора
  Vector = System.Windows.Vector;
  /// Тип кисти
  GBrush = System.Windows.Media.Brush;
  /// Тип стиля шрифта
  FontStyle = (Normal, Bold, Italic, BoldItalic);
  
  FontStyles = System.Windows.FontStyles;
  FontWeights = System.Windows.FontWeights;
  FontStretches = System.Windows.FontStretches;
  FlowDirection = System.Windows.FlowDirection;
  
  /// Константы выравнивания текста относительно точки
  Alignment = (LeftTop, CenterTop, RightTop, LeftCenter, Center, RightCenter, LeftBottom, CenterBottom, RightBottom);

function GetFontFamily(name: string): FontFamily;
function GetBrush(c: GColor): GBrush;

type

  ///!#
  /// Тип кисти
  BrushType = class
  private
    c := Colors.White;
    function BrushConstruct := GetBrush(c);
  public  
    /// Цвет кисти
    property Color: GColor read c write c;
  end;
  
  ///!#
  /// Тип пера
  PenType = class
  private
    c: Color := Colors.Black;
    th: real := 1;
    fx,fy: real;
    rc: boolean := false;
    function PenConstruct: GPen;
    begin
      Result := new GPen(GetBrush(c),th);
      Result.LineJoin := PenLineJoin.Round;
      if rc then 
      begin
        Result.StartLineCap := PenLineCap.Round;
        Result.EndLineCap := PenLineCap.Round;
      end
      else
      begin
        Result.StartLineCap := PenLineCap.Flat;
        Result.EndLineCap := PenLineCap.Flat;
      end;
    end;
  public  
    /// Цвет пера
    property Color: GColor read c write c;
    /// Ширина пера
    property Width: real read th write th;
    /// Текущая координата X пера
    property X: real read fx;
    /// Текущая координата Y пера
    property Y: real read fy;
    /// Скругление пера на концах линий
    property RoundCap: boolean read rc write rc;
  end;

  ///!#
  /// Тип шрифта
  FontOptions = class
  private
    tf := new Typeface('Arial');
    sz: real := 14;
    c: GColor := Colors.Black;
    procedure SetNameP(s: string) := tf := new Typeface(GetFontFamily(s), FontStyles.Normal, FontWeights.Normal, FontStretches.Normal); 
    function GetName := tf.FontFamily.ToString;
    //procedure SetName(s: string) := Invoke(SetNameP,s);
    procedure SetFSP(fs: FontStyle);
    begin
      var s := FontStyles.Normal;
      var w := FontWeights.Normal;
      case fs of
        FontStyle.Bold: w := FontWeights.Bold;
        FontStyle.Italic: s := FontStyles.Italic;
        FontStyle.BoldItalic: begin s := FontStyles.Italic; w := FontWeights.Bold; end;
      end;
      //tf := new Typeface(GetFontFamily(Name),s,w,FontStretches.Normal); 
    end;
    //procedure SetFS(fs: FontStyle) := Invoke(SetFSP,fs);
    property BrushClone: GBrush read GetBrush(c);
    property TypefaceClone: Typeface read tf;
  public
    /// Цвет шрифта
    property Color: GColor read c write c;
    /// Имя шрифта
    property Name: string read GetName;
    /// Размер шрифта в единицах по 1/96 дюйма
    property Size: real read sz write sz;
    /// Стиль шрифта
    //property Style: FontStyle write SetFS;
    /// Декоратор стиля шрифта
    function WithStyle(fs: FontStyle): FontOptions;
    begin
      Result := new FontOptions;
      Result.sz := sz;
      Result.Color := c;
      //Result.Style := fs;
    end;
    /// Декоратор цвета шрифта
    function WithColor(c: GColor): FontOptions;
    begin
      Result := new FontOptions;
      Result.tf := tf;
      Result.sz := sz;
      Result.Color := c;
    end;
    /// Декоратор размера шрифта
    function WithSize(sz: real): FontOptions;
    begin
      Result := new FontOptions;
      Result.tf := tf;
      Result.sz := sz;
      Result.Color := c;
    end;
    /// Декоратор стиля шрифта
    function WithName(name: string): FontOptions;
    begin
      Result := new FontOptions;
      Result.sz := sz;
      Result.Color := c;
      Result.tf := new Typeface(GetFontFamily(name), tf.Style, tf.Weight, FontStretches.Normal);
    end;
  end;

// -----------------------------------------------------
//>>     Графические примитивы # GraphWPF primitives
// -----------------------------------------------------
/// Рисует пиксел в точке (x,y) цветом c
//procedure SetPixel(x,y: real; c: Color);
/// Рисует прямоугольник пикселей размера (w,h), задаваемых отображением f, начиная с левого верхнего угла с координатами (x,y)
//procedure SetPixels(x,y: real; w,h: integer; f: (integer,integer)->Color);
/// Рисует двумерный массив пикселей pixels начиная с левого верхнего угла с координатами (x,y)
//procedure DrawPixels(x,y: real; pixels: array [,] of Color);
/// Рисует прямоугольную область (px,py,pw,ph) двумерного массива пикселей pixels начиная с левого верхнего угла с координатами (x,y)
//procedure DrawPixels(x,y: real; pixels: array [,] of Color; px,py,pw,ph: integer);

/// Рисует эллипс с центром в точке (x,y) и радиусами rx и ry
//procedure Ellipse(x,y,rx,ry: real);
/// Рисует контур эллипса с центром в точке (x,y) и радиусами rx и ry
//procedure DrawEllipse(x,y,rx,ry: real);
/// Рисует внутренность эллипса с центром в точке (x,y) и радиусами rx и ry
//procedure FillEllipse(x,y,rx,ry: real);
/// Рисует эллипс с центром в точке (x,y), радиусами rx и ry и цветом внутренности c
//procedure Ellipse(x,y,rx,ry: real; c: Color);
/// Рисует контур эллипса с центром в точке (x,y), радиусами rx и ry и цветом c
//procedure DrawEllipse(x,y,rx,ry: real; c: Color);
/// Рисует внутренность эллипса с центром в точке (x,y), радиусами rx и ry и цветом c
//procedure FillEllipse(x,y,rx,ry: real; c: Color);

/// Рисует эллипс с центром в точке p и радиусами rx и ry
//procedure Ellipse(p: Point; rx,ry: real);
/// Рисует контур эллипса с центром в точке p и радиусами rx и ry
//procedure DrawEllipse(p: Point; rx,ry: real);
/// Рисует внутренность эллипса с центром в точке p и радиусами rx и ry
//procedure FillEllipse(p: Point; rx,ry: real);
/// Рисует эллипс с центром в точке p, радиусами rx и ry и цветом внутренности c
//procedure Ellipse(p: Point; rx,ry: real; c: Color);
/// Рисует контур эллипса с центром в точке p, радиусами rx и ry и цветом c
//procedure DrawEllipse(p: Point; rx,ry: real; c: Color);
/// Рисует внутренность эллипса с центром в точке p, радиусами rx и ry и цветом c
//procedure FillEllipse(p: Point; rx,ry: real; c: Color);

/// Рисует окружность с центром в точке (x,y) и радиусом r
//procedure Circle(x,y,r: real);
/// Рисует контур окружности с центром в точке (x,y) и радиусом r
//procedure DrawCircle(x,y,r: real);
/// Рисует внутренность окружности с центром в точке (x,y) и радиусом r
//procedure FillCircle(x,y,r: real);
/// Рисует окружность с центром в точке (x,y), радиусом r и цветом c
//procedure Circle(x,y,r: real; c: Color);
/// Рисует контур окружности с центром в точке (x,y), радиусом r и цветом c
//procedure DrawCircle(x,y,r: real; c: Color);
/// Рисует внутренность окружности с центром в точке (x,y), радиусом r и цветом c
//procedure FillCircle(x,y,r: real; c: Color);

/// Рисует окружность с центром в точке p и радиусом r
//procedure Circle(p: Point; r: real);
/// Рисует контур окружности с центром в точке p и радиусом r
//procedure DrawCircle(p: Point; r: real);
/// Рисует внутренность окружности с центром в точке p и радиусом r
//procedure FillCircle(p: Point; r: real);
/// Рисует окружность с центром в точке p, радиусом r и цветом c
//procedure Circle(p: Point; r: real; c: Color);
/// Рисует контур окружности с центром в точке p, радиусом r и цветом c
//procedure DrawCircle(p: Point; r: real; c: Color);
/// Рисует внутренность окружности с центром в точке p, радиусом r и цветом c
//procedure FillCircle(p: Point; r: real; c: Color);


/// Рисует прямоугольник с координатами вершин (x,y) и (x+w,y+h)
procedure Rectangle(x,y,w,h: real);
/// Рисует контур прямоугольника с координатами вершин (x,y) и (x+w,y+h)
procedure DrawRectangle(x,y,w,h: real);
/// Рисует внутренность прямоугольника с координатами вершин (x,y) и (x+w,y+h)
procedure FillRectangle(x,y,w,h: real);
/// Рисует прямоугольник с координатами вершин (x,y) и (x+w,y+h) цветом c
procedure Rectangle(x,y,w,h: real; c: Color);
/// Рисует контур прямоугольника с координатами вершин (x,y) и (x+w,y+h) цветом c
procedure DrawRectangle(x,y,w,h: real; c: Color);
/// Рисует внутренность прямоугольника с координатами вершин (x,y) и (x+w,y+h) цветом c
procedure FillRectangle(x,y,w,h: real; c: Color);

/// Рисует дугу окружности с центром в точке (x,y) и радиусом r, заключенную между двумя лучами, образующими углы angle1 и angle2 с осью OX
//procedure Arc(x, y, r, angle1, angle2: real);
/// Рисует дугу окружности с центром в точке (x,y) и радиусом r, заключенную между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
//procedure Arc(x, y, r, angle1, angle2: real; c: Color);

/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX
//procedure Sector(x, y, r, angle1, angle2: real);
/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX
//procedure Pie(x, y, r, angle1, angle2: real);
/// Рисует контур сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX
//procedure DrawSector(x, y, r, angle1, angle2: real);
/// Рисует внутренность сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX
//procedure FillSector(x, y, r, angle1, angle2: real);
/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
//procedure Sector(x, y, r, angle1, angle2: real; c: Color);
/// Рисует контур сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
//procedure DrawSector(x, y, r, angle1, angle2: real; c: Color);
/// Рисует внутренность сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
//procedure FillSector(x, y, r, angle1, angle2: real; c: Color);

/// Рисует отрезок прямой от точки (x,y) до точки (x1,y1)
//procedure Line(x,y,x1,y1: real);
/// Рисует отрезок прямой от точки (x,y) до точки (x1,y1) цветом c
//procedure Line(x,y,x1,y1: real; c: Color);
/// Рисует отрезок прямой от точки p до точки p1
//procedure Line(p,p1: Point);
/// Рисует отрезок прямой от точки p до точки p1 цветом c
//procedure Line(p,p1: Point; c: Color);
/// Рисует отрезки, заданные массивом пар точек 
//procedure Lines(a: array of (Point,Point));
/// Рисует отрезки, заданные массивом пар точек, цветом c 
//procedure Lines(a: array of (Point,Point); c: Color);
/// Устанавливает текущую позицию рисования в точку (x,y)
//procedure MoveTo(x,y: real);
/// Рисует отрезок от текущей позиции до точки (x,y). Текущая позиция переносится в точку (x,y)
//procedure LineTo(x,y: real);
/// Перемещает текущую позицию рисования на вектор (dx,dy)
//procedure MoveRel(dx,dy: real);
/// Рисует отрезок от текущей позиции до точки, смещённой на вектор (dx,dy). Текущая позиция переносится в новую точку
//procedure LineRel(dx,dy: real);
/// Перемещает текущую позицию рисования на вектор (dx,dy)
//procedure MoveBy(dx,dy: real);
/// Рисует отрезок от текущей позиции до точки, смещённой на вектор (dx,dy). Текущая позиция переносится в новую точку
//procedure LineBy(dx,dy: real);
///--
//procedure MoveOn(dx,dy: real);
///--
//procedure LineOn(dx,dy: real);

/// Рисует ломаную, заданную массивом точек 
//procedure PolyLine(points: array of Point);
/// Рисует ломаную заданную массивом точек и цветом
//procedure PolyLine(points: array of Point; c: Color);

/// Рисует многоугольник, заданный массивом точек 
//procedure Polygon(points: array of Point);
/// Рисует контур многоугольника, заданного массивом точек 
//procedure DrawPolygon(points: array of Point);
/// Рисует внутренность многоугольника, заданного массивом точек 
//procedure FillPolygon(points: array of Point);
/// Рисует многоугольник, заданный массивом точек и цветом
//procedure Polygon(points: array of Point; c: Color);
/// Рисует контур многоугольника, заданного массивом точек и цветом 
//procedure DrawPolygon(points: array of Point; c: GColor);
/// Рисует внутренность многоугольника, заданного массивом точек и цветом
//procedure FillPolygon(points: array of Point; c: GColor);
///Задать размеры окна
//procedure WindowSize(width, height: integer);


// -----------------------------------------------------
//>>     Вспомогательные функции GraphWPF # GraphWPF service functions
// -----------------------------------------------------
/// Возвращает цвет по красной, зеленой и синей составляющей (в диапазоне 0..255)
function RGB(r,g,b: byte): Color;
/// Возвращает цвет по красной, зеленой и синей составляющей и параметру прозрачности (в диапазоне 0..255)
function ARGB(a,r,g,b: byte): Color;
/// Возвращает серый цвет с интенсивностью b
function GrayColor(b: byte): Color;
/// Возвращает случайный цвет
function RandomColor: Color;
/// Возвращает полностью прозрачный цвет
function EmptyColor: Color;
/// Возвращает случайный цвет
function clRandom: Color;
/// Возвращает точку с координатами (x,y)
function Pnt(x,y: real): GPoint;
/// Возвращает прямоугольник с координатами угла (x,y), шириной w и высотой h
function Rect(x,y,w,h: real): GRect;
/// Возвращает однотонную цветную кисть, заданную цветом
function ColorBrush(c: Color): GBrush;
/// Возвращает однотонное цветное перо, заданное цветом
function ColorPen(c: Color): GPen;
/// Возвращает однотонное цветное перо, заданное цветом и толщиной
function ColorPen(c: Color; w: real): GPen;
/// Функция генерации случайной точки в границах экрана. Необязательный параметр w задаёт минимальный отступ от границы
function RandomPoint(wd: real := 0): Point;
/// Функция генерации массива случайных точек в границах экрана. Необязательный параметр w задаёт минимальный отступ от границы
function RandomPoints(n: integer; w: real := 0): array of Point;
/// Создаёт вектор с координатами vx,vy
function Vect(vx,vy: real): Vector;

// -----------------------------------------------------
//>>     Функции для вывода текста # GraphWPF text functions
// -----------------------------------------------------
/// Выводит строку в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; text: string; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит строку в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; text: string; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит целое в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; number: integer; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит вещественное в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; number: real; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит строку в прямоугольник
//procedure DrawText(r: GRect; text: string; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит целое в прямоугольник
//procedure DrawText(r: GRect; number: integer; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит вещественное в прямоугольник
//procedure DrawText(r: GRect; number: real; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит целое в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; number: integer; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит вещественное в прямоугольник к координатами левого верхнего угла (x,y)
//procedure DrawText(x, y, w, h: real; number: real; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит строку в прямоугольник
//procedure DrawText(r: GRect; text: string; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит целое в прямоугольник
//procedure DrawText(r: GRect; number: integer; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит вещественное в прямоугольник
//procedure DrawText(r: GRect; number: real; c: GColor; align: Alignment := Alignment.Center; angle: real := 0.0);
/// Выводит строку в прямоугольник к координатами левого верхнего угла (x,y) указанным шрифтом
//procedure DrawText(x, y, w, h: real; text: string; f: FontOptions; align: Alignment; angle: real);

/// Выводит строку в позицию (x,y)
//procedure TextOut(x, y: real; text: string; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит строку в позицию (x,y) цветом c
//procedure TextOut(x, y: real; text: string; c: GColor; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит целое в позицию (x,y)
//procedure TextOut(x, y: real; text: integer; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит целое в позицию (x,y) цветом c
//procedure TextOut(x, y: real; text: integer; c: GColor; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит вещественное в позицию (x,y)
//procedure TextOut(x, y: real; text: real; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит вещественное в позицию (x,y) цветом c
//procedure TextOut(x, y: real; text: real; c: GColor; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит строку в позицию (x,y) указанным шрифтом
//procedure TextOut(x, y: real; text: string; f: FontOptions; align: Alignment := Alignment.LeftTop; angle: real := 0.0);

/// Ширина текста при выводе
//function TextWidth(text: string): real;
/// Высота текста при выводе
//function TextHeight(text: string): real;
/// Размер текста при выводе
//function TextSize(text: string): Size;

/// Ширина текста при выводе заданным шрифтом
//function TextWidth(text: string; f: FontOptions): real;
/// Высота текста при выводе заданным шрифтом
//function TextHeight(text: string; f: FontOptions): real;
/// Размер текста при выводе заданным шрифтом
//function TextSize(text: string; f: FontOptions): Size;

// -----------------------------------------------------
//>>     Переменные модуля GraphWPF # GraphWPF variables
// -----------------------------------------------------
/// Текущая кисть
var Brush: BrushType;
/// Текущее перо
var Pen: PenType;
/// Текущий шрифт
var Font: FontOptions;


///Шрифт по заданной ширине, высоте и тексту
function GetFontSizeByWH(W, H: real; text: string): FontOptions;
///Шрифт по заданной ширине и тексту
function GetFontSizeByW(W: real; text: string): FontOptions;
///Шрифт по заданной высоте и тексту
function GetFontSizeByH(H: real; text: string): FontOptions;

//функции генерации и вывода JS кода
//procedure FillRectangleJS(x, y, w, h: real; fillColor: Color);
//procedure DrawRectangleJS(x, y, w, h: real; fillColor, strokeColor: Color; width: real);

//procedure DrawLineJS(x1, y1, x2, y2: real; lineColor: Color; width: real);
//procedure DrawLinesJS(arr_x, arr_y: List<real>; lineColor: Color; width: real);
//procedure FillCircleJS(x, y, r: real; fillColor: Color);
//procedure DrawScatterJS(arr_x, arr_y: List<real>; lineColor: Color; r: real);
//procedure TextOutJS(x, y: real; text: string; fnt: FontOptions);
//procedure OutputJS(text: string);

function TextWidthPFont(text: string; f: FontOptions): real;
function TextHeightPFont(text: string; f: FontOptions): real;

procedure WindowSize(width, height: integer);

implementation

procedure OutputJS(text: string);
begin
  output.Append(text);
end;

function GetBrush(c: GColor): GBrush := new SolidColorBrush(c);

var
  FontFamiliesDict := new Dictionary<string, FontFamily>;

function GetFontFamily(name: string): FontFamily;
begin
  if not (name in FontFamiliesDict) then
  begin
    var b := new FontFamily(name);
    FontFamiliesDict[name] := b;
    Result := b
  end
  else Result := FontFamiliesDict[name];
end;

function RGB(r,g,b: byte) := Color.Fromrgb(r, g, b);
function ARGB(a,r,g,b: byte) := Color.FromArgb(a, r, g, b);
function GrayColor(b: byte): Color := RGB(b, b, b);
function RandomColor := RGB(PABCSystem.Random(256), PABCSystem.Random(256), PABCSystem.Random(256));
function EmptyColor: Color := ARGB(0,0,0,0);
function clRandom := RandomColor();
function Pnt(x,y: real) := new Point(x,y);
function Rect(x,y,w,h: real) := new System.Windows.Rect(x,y,w,h);
function ColorBrush(c: Color) := GetBrush(c);
function ColorPen(c: Color) := new GPen(GetBrush(c),Pen.Width);
function ColorPen(c: Color; w: real) := new GPen(GetBrush(c),w);
function RandomPoint(wd: real): Point := Pnt(Random(wd,w-wd),Random(wd,h-wd));
function RandomPoints(n: integer; w: real): array of Point;
begin
  Result := new Point[n];
  foreach var i in 0..n-1 do
    Result[i] := RandomPoint(w);
end;
function Vect(vx,vy: real): Vector := new Vector(vx,vy);

procedure WindowSize(width, height: integer);
begin
  w := width;
  h := height;
end;

var
  RusCultureInfo := new System.Globalization.CultureInfo('ru-ru');
  
function FormText(text: string) := 
  new FormattedText(text, RusCultureInfo, FlowDirection.LeftToRight, 
                    Font.tf, Font.Size, Font.BrushClone);                   
function FormTextFont(text: string; f: FontOptions): FormattedText;
begin
  var tf := new Typeface(GetFontFamily(f.Name), f.tf.Style, f.tf.Weight, f.tf.Stretch);
  Result := new FormattedText(text, RusCultureInfo, FlowDirection.LeftToRight, tf, f.Size, f.BrushClone);
end;
function FormTextC(text: string; c: GColor): FormattedText;
begin 
  Result := new FormattedText(text,RusCultureInfo, FlowDirection.LeftToRight, Font.TypefaceClone, Font.Size, GetBrush(c));
end;

function TextWidthP(text: string) := FormText(text).Width;
function TextHeightP(text: string) := FormText(text).Height;

function TextWidthPFont(text: string; f: FontOptions) := FormTextFont(text, f).Width;
function TextHeightPFont(text: string; f: FontOptions) := FormTextFont(text, f).Height;
function GetFontSizeByW(W: real; text: string): FontOptions;
begin
  var fnt := new FontOptions;
  var cur_width := TextWidthPFont(text, fnt);
  while (cur_width > w) do
  begin
    fnt.Size -= 0.1;
    cur_width := TextWidthPFont(text, fnt);
  end;
  while (cur_width < w * 0.9) do
  begin
    fnt.Size += 0.1;
    cur_width := TextWidthPFont(text, fnt);
  end;
  Result := fnt;
end;
function GetFontSizeByH(H: real; text: string): FontOptions;
begin
  var fnt := new FontOptions;
  var cur_height := TextHeightPFont(text, fnt);
  while (cur_height > h) do
  begin
    fnt.Size -= 0.1;
    cur_height := TextHeightPFont(text, fnt);
  end;
  while (cur_height < h * 0.9) do
  begin
    fnt.Size += 0.1;
    cur_height := TextHeightPFont(text, fnt);
  end;
  Result := fnt;
end;
function GetFontSizeByWH(W, H: real; text: string): FontOptions;
begin
  var Hfont := GetFontSizeByH(h, text);
  var Wfont := GetFontSizeByW(h, text);
  if Hfont.Size < Wfont.Size then
    Result := Hfont
  else
    Result := Wfont;
end;

//////////////////////////////////

procedure FillRectangleJS(x, y, w, h: real; fillColor: Color);
begin
  OutputJS('Rct(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + w + ',' + h + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ');');
end;

procedure StrokeRectangleJS(x, y, w, h: real; strokeColor: Color; width: real);
begin
  OutputJS('RctS(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + w + ',' + h + ',' + 
 					 strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B +','+width+');');
end;

procedure RectangleJS(x, y, w, h: real; fillColor, strokeColor: Color; width: real);
begin
  OutputJS('Rct(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + w + ',' + h + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ',' +
 					width + ',' + strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ');');
end;

procedure DrawLinesJS(arr_x, arr_y: List<real>; lineColor: Color; width: real);
begin
  var temp := new StringBuilder();
  temp += 'Lns([';
  for var i := 0 to arr_x.Count - 1 do
    temp += arr_x[i].ToString('0.000') + ',';
  temp += '],[';
  for var i := 0 to arr_y.Count - 1 do
    temp += arr_y[i].ToString('0.000') + ',';
  temp += '],' + width + ',' + lineColor.R + ',' + lineColor.G + ',' + lineColor.B + ');';
  OutputJS(temp.ToString);
end;

procedure DrawLineJS(x1, y1, x2, y2: real; lineColor: Color; width: real);
begin
  OutputJS('cx.strokeStyle = "rgb(' + lineColor.R + ',' + lineColor.G + ',' + lineColor.B + ')";' +
            'cx.lineWidth = ' + width + ';' +
            'cx.beginPath();' +
            'cx.moveTo(' + x1.ToString('0.000') + ',' + y1.ToString('0.000') + ');' +
            'cx.lineTo(' + x2.ToString('0.000') + ',' + y2.ToString('0.000') + ');' +
            'cx.stroke();');
end;

procedure FillCircleJS(x, y, r: real; fillColor: Color);
begin
  OutputJS('cx.fillStyle = "rgb(' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ')";' +
            'cx.beginPath();' +
            'cx.arc(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',0,' + (Pi * 2) + ');' +
            'cx.fill();');
end;

procedure DrawScatterJS(arr_x, arr_y: List<real>; lineColor: Color; r: real);
begin
  var temp := new StringBuilder();
  temp += 'Sct([';
  for var i := 0 to arr_x.Count - 1 do
    temp += arr_x[i].ToString('0.000') + ',';
  temp += '],[';
  for var i := 0 to arr_y.Count - 1 do
    temp += arr_y[i].ToString('0.000') + ',';
  temp += '],' + r + ',' + lineColor.R + ',' + lineColor.G + ',' + lineColor.B + ');';
  OutputJS(temp.ToString);
end;

procedure TextOutJS(x, y: real; text: string; fnt: FontOptions);
begin
  y := y + TextHeightPFont(text, fnt) * 0.15;
  OutputJS('cx.font = "' + (fnt.Size / 96 * 72) + 'pt ' + fnt.Name + '";' +
            'cx.fillStyle = "black";' +
            'cx.textAlign = "left";' +
            'cx.textBaseline = "top";' +
            'cx.fillText("' + text + '", ' + x.ToString('0.000') + ',' + y.ToString('0.000') + ');');
end;

/////////////////////////////////////////////

///---- P - primitives

procedure Rectangle(x,y,w,h: real) := RectangleJS(x,y,w,h,Brush.Color,Pen.Color,Pen.Width);
procedure DrawRectangle(x,y,w,h: real) := StrokeRectangleJS(x,y,w,h,Pen.Color,Pen.Width);
procedure FillRectangle(x,y,w,h: real) := FillRectangleJS(x,y,w,h,Brush.Color);
procedure Rectangle(x,y,w,h: real; c: GColor) := RectangleJS(x,y,w,h,c,Pen.Color,Pen.Width);
procedure DrawRectangle(x,y,w,h: real; c: GColor) := StrokeRectangleJS(x,y,w,h,c,Pen.Width);
procedure FillRectangle(x,y,w,h: real; c: GColor) := FillRectangleJS(x,y,w,h,c);


procedure InitModule();
begin
  w := 800; h := 600;
  
  Brush := new BrushType();
  Pen := new PenType();
end;

procedure FinalizeModule();
begin
  var s := '<html><canvas width="'+w+'" height="'+h+'" id="graphCanvas"></canvas>';
  s := s + ReadAllText('JSGraphBegin.txt');
  OutputJS('</script></html>');
  Console.WriteLine(s+output.ToString());
end;

initialization
  InitModule();
finalization
  FinalizeModule();
end. 