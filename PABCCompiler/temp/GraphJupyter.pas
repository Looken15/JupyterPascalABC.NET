unit GraphJupyter;

interface

//{$reference 'PresentationCore.dll'}
//{$reference 'PresentationFramework.dll'}
//{$reference 'WindowsBase.dll'}


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

type
  /// Тип точки
  Point = class
    X :real;
    Y :real;
    constructor Create(x,y:real);
    begin
      self.X := x;
      self.Y := y;
    end;
  end;
  
  /// Константы выравнивания текста относительно точки
  Alignment = (LeftTop, CenterTop, RightTop, LeftCenter, Center, RightCenter, LeftBottom, CenterBottom, RightBottom);

type
  /// Тип кисти
  BrushType = class
  public
    Color :Color:= Colors.White;
    constructor Create(c: GraphJupyter.Color);
    begin
      self.Color :=c;
    end;
  end;
  
  ///!#
  /// Тип пера
  PenType = class
  public
    Color: Color := Colors.Black;
    Width: real := 1;
    X: real := 0.0;
    Y: real := 0.0;
    rc: boolean := false;
    /// Скругление пера на концах линий
    property RoundCap: boolean read rc write rc;
  end;

  /// Тип шрифта
  FontOptions = class
  public
    Name: string := 'Arial';
    Color: Color := Colors.Black;
    Size: real := 13;
  end;

///Требуется ли отображение кнопок
procedure NeedButtons(flag: boolean);
// -----------------------------------------------------
//>>     Графические примитивы # GraphWPF primitives
// -----------------------------------------------------
/// Рисует пиксел в точке (x,y) цветом c
procedure SetPixel(x,y: real; c: Color);
/// Рисует прямоугольник пикселей размера (w,h), задаваемых отображением f, начиная с левого верхнего угла с координатами (x,y)
//procedure SetPixels(x,y: real; w,h: integer; f: (integer,integer)->Color);
/// Рисует двумерный массив пикселей pixels начиная с левого верхнего угла с координатами (x,y)
//procedure DrawPixels(x,y: real; pixels: array [,] of Color);
/// Рисует прямоугольную область (px,py,pw,ph) двумерного массива пикселей pixels начиная с левого верхнего угла с координатами (x,y)
//procedure DrawPixels(x,y: real; pixels: array [,] of Color; px,py,pw,ph: integer);

/// Рисует эллипс с центром в точке (x,y) и радиусами rx и ry
procedure Ellipse(x,y,rx,ry: real);
/// Рисует контур эллипса с центром в точке (x,y) и радиусами rx и ry
procedure DrawEllipse(x,y,rx,ry: real);
/// Рисует внутренность эллипса с центром в точке (x,y) и радиусами rx и ry
procedure FillEllipse(x,y,rx,ry: real);
/// Рисует эллипс с центром в точке (x,y), радиусами rx и ry и цветом внутренности c
procedure Ellipse(x,y,rx,ry: real; c: Color);
/// Рисует контур эллипса с центром в точке (x,y), радиусами rx и ry и цветом c
procedure DrawEllipse(x,y,rx,ry: real; c: Color);
/// Рисует внутренность эллипса с центром в точке (x,y), радиусами rx и ry и цветом c
procedure FillEllipse(x,y,rx,ry: real; c: Color);

/// Рисует эллипс с центром в точке p и радиусами rx и ry
procedure Ellipse(p: Point; rx,ry: real);
/// Рисует контур эллипса с центром в точке p и радиусами rx и ry
procedure DrawEllipse(p: Point; rx,ry: real);
/// Рисует внутренность эллипса с центром в точке p и радиусами rx и ry
procedure FillEllipse(p: Point; rx,ry: real);
/// Рисует эллипс с центром в точке p, радиусами rx и ry и цветом внутренности c
procedure Ellipse(p: Point; rx,ry: real; c: Color);
/// Рисует контур эллипса с центром в точке p, радиусами rx и ry и цветом c
procedure DrawEllipse(p: Point; rx,ry: real; c: Color);
/// Рисует внутренность эллипса с центром в точке p, радиусами rx и ry и цветом c
procedure FillEllipse(p: Point; rx,ry: real; c: Color);

/// Рисует окружность с центром в точке (x,y) и радиусом r
procedure Circle(x,y,r: real);
/// Рисует контур окружности с центром в точке (x,y) и радиусом r
procedure DrawCircle(x,y,r: real);
/// Рисует внутренность окружности с центром в точке (x,y) и радиусом r
procedure FillCircle(x,y,r: real);
/// Рисует окружность с центром в точке (x,y), радиусом r и цветом c
procedure Circle(x,y,r: real; c: Color);
/// Рисует контур окружности с центром в точке (x,y), радиусом r и цветом c
procedure DrawCircle(x,y,r: real; c: Color);
/// Рисует внутренность окружности с центром в точке (x,y), радиусом r и цветом c
procedure FillCircle(x,y,r: real; c: Color);

/// Рисует окружность с центром в точке p и радиусом r
procedure Circle(p: Point; r: real);
/// Рисует контур окружности с центром в точке p и радиусом r
procedure DrawCircle(p: Point; r: real);
/// Рисует внутренность окружности с центром в точке p и радиусом r
procedure FillCircle(p: Point; r: real);
/// Рисует окружность с центром в точке p, радиусом r и цветом c
procedure Circle(p: Point; r: real; c: Color);
/// Рисует контур окружности с центром в точке p, радиусом r и цветом c
procedure DrawCircle(p: Point; r: real; c: Color);
/// Рисует внутренность окружности с центром в точке p, радиусом r и цветом c
procedure FillCircle(p: Point; r: real; c: Color);


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
procedure Arc(x, y, r, angle1, angle2: real);
/// Рисует дугу окружности с центром в точке (x,y) и радиусом r, заключенную между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
procedure Arc(x, y, r, angle1, angle2: real; c: Color);

/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX
procedure Sector(x, y, r, angle1, angle2: real);
/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX
procedure Pie(x, y, r, angle1, angle2: real);
/// Рисует контур сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX
procedure DrawSector(x, y, r, angle1, angle2: real);
/// Рисует внутренность сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX
procedure FillSector(x, y, r, angle1, angle2: real);
/// Рисует сектор окружности с центром в точке (x,y) и радиусом r, заключенный между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
procedure Sector(x, y, r, angle1, angle2: real; c: Color);
/// Рисует контур сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
procedure DrawSector(x, y, r, angle1, angle2: real; c: Color);
/// Рисует внутренность сектора окружности с центром в точке (x,y) и радиусом r, заключенного между двумя лучами, образующими углы angle1 и angle2 с осью OX, цветом c
procedure FillSector(x, y, r, angle1, angle2: real; c: Color);

/// Рисует отрезок прямой от точки (x,y) до точки (x1,y1)
procedure Line(x,y,x1,y1: real);
/// Рисует отрезок прямой от точки (x,y) до точки (x1,y1) цветом c
procedure Line(x,y,x1,y1: real; c: Color);
/// Рисует отрезок прямой от точки p до точки p1
procedure Line(p,p1: Point);
/// Рисует отрезок прямой от точки p до точки p1 цветом c
procedure Line(p,p1: Point; c: Color);
/// Рисует отрезки, заданные массивом пар точек 
procedure Lines(a: array of (Point,Point));
/// Рисует отрезки, заданные массивом пар точек, цветом c 
procedure Lines(a: array of (Point,Point); c: Color);
/// Устанавливает текущую позицию рисования в точку (x,y)
procedure MoveTo(x,y: real);
/// Рисует отрезок от текущей позиции до точки (x,y). Текущая позиция переносится в точку (x,y)
procedure LineTo(x,y: real);
/// Перемещает текущую позицию рисования на вектор (dx,dy)
procedure MoveRel(dx,dy: real);
/// Рисует отрезок от текущей позиции до точки, смещённой на вектор (dx,dy). Текущая позиция переносится в новую точку
procedure LineRel(dx,dy: real);
/// Перемещает текущую позицию рисования на вектор (dx,dy)
procedure MoveBy(dx,dy: real);
/// Рисует отрезок от текущей позиции до точки, смещённой на вектор (dx,dy). Текущая позиция переносится в новую точку
procedure LineBy(dx,dy: real);
///--
procedure MoveOn(dx,dy: real);
///--
procedure LineOn(dx,dy: real);

/// Рисует ломаную, заданную массивом точек 
procedure PolyLine(points: array of Point);
/// Рисует ломаную заданную массивом точек и цветом
procedure PolyLine(points: array of Point; c: Color);

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
/// Возвращает случайный цвет
function RandomColor: Color;
/// Возвращает полностью прозрачный цвет
function EmptyColor: Color;
/// Возвращает случайный цвет
function clRandom: Color;
/// Функция генерации случайной точки в границах экрана. Необязательный параметр w задаёт минимальный отступ от границы
function RandomPoint(wd: real := 0): Point;
/// Функция генерации массива случайных точек в границах экрана. Необязательный параметр w задаёт минимальный отступ от границы
function RandomPoints(n: integer; w: real := 0): array of Point;

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
procedure TextOut(x, y: real; text: string);
procedure TextOut(x, y: real; text: string; align: Alignment; angle: real := 0.0);
/// Выводит строку в позицию (x,y) цветом c
procedure TextOut(x, y: real; text: string; c: Color);
procedure TextOut(x, y: real; text: string; c: Color; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит целое в позицию (x,y)
procedure TextOut(x, y: real; text: integer);
procedure TextOut(x, y: real; text: integer; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит целое в позицию (x,y) цветом c
procedure TextOut(x, y: real; text: integer; c: Color);
procedure TextOut(x, y: real; text: integer; c: Color; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит вещественное в позицию (x,y)
procedure TextOut(x, y: real; text: real);
procedure TextOut(x, y: real; text: real; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит вещественное в позицию (x,y) цветом c
procedure TextOut(x, y: real; text: real; c: Color);
procedure TextOut(x, y: real; text: real; c: Color; align: Alignment := Alignment.LeftTop; angle: real := 0.0);
/// Выводит строку в позицию (x,y) указанным шрифтом
procedure TextOut(x, y: real; text: string; f: FontOptions);
procedure TextOut(x, y: real; text: string; f: FontOptions; align: Alignment := Alignment.LeftTop; angle: real := 0.0);

{/// Ширина текста при выводе
function TextWidth(text: string): real;
/// Высота текста при выводе
function TextHeight(text: string): real;
/// Размер текста при выводе
function TextSize(text: string): Size;

/// Ширина текста при выводе заданным шрифтом
function TextWidth(text: string; f: FontOptions): real;
/// Высота текста при выводе заданным шрифтом
function TextHeight(text: string; f: FontOptions): real;
/// Размер текста при выводе заданным шрифтом
function TextSize(text: string; f: FontOptions): Size;}

// -----------------------------------------------------
//>>     Переменные модуля GraphWPF # GraphWPF variables
// -----------------------------------------------------
/// Текущая кисть
var Brush: BrushType := new BrushType();
/// Текущее перо
var Pen: PenType := new PenType();
/// Текущий шрифт
var Font: FontOptions := new FontOptions();

procedure WindowSize(width, height: integer);


implementation
///Нужна ли отрисовка кнопок
var drawUI := false;
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
var curOutputId := '';

procedure NeedButtons(flag: boolean):= drawUI := flag;

procedure OutputJS(text: string);
begin
  output.Append(text);
end;

function RGB(r,g,b: byte) := new Color(r, g, b);
function ARGB(a,r,g,b: byte) := new Color(r, g, b, a);
function RandomColor := RGB(PABCSystem.Random(256), PABCSystem.Random(256), PABCSystem.Random(256));
function EmptyColor: Color := ARGB(0,0,0,0);
function clRandom := RandomColor();
function Pnt(x,y: real) := new Point(x,y);
function RandomPoint(wd: real): Point := Pnt(Random(wd,w-wd),Random(wd,h-wd));
function RandomPoints(n: integer; w: real): array of Point;
begin
  Result := new Point[n];
  foreach var i in 0..n-1 do
    Result[i] := RandomPoint(w);
end;

procedure WindowSize(width, height: integer);
begin
  w := width;
  h := height;
end;

//////////////////////////////////

procedure SetPixelJS(x,y:real; fillColor:Color);
begin
  OutputJS('SetP('+x.ToString('0.000') + ',' + y.ToString('0.000') + ','+ fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ');');
end;

procedure EllipseJS(x,y,rx,ry:real;fillColor, strokeColor: Color; width: real);
begin
  OutputJS('Elps(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + rx + ',' + ry + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ',' +
 					width + ',' + strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ');');
end;
procedure FillEllipseJS(x, y, rx, ry: real; fillColor: Color);
begin
  OutputJS('Elps(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + rx + ',' + ry + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ');');
end;
procedure StrokeEllipseJS(x, y, rx, ry: real; strokeColor: Color; width: real);
begin
  OutputJS('ElpsS(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + rx + ',' + ry + ',' + 
 					 strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B +','+width+');');
end;

procedure CircleJS(x,y,r:real;fillColor, strokeColor: Color; width: real);
begin
  OutputJS('Crcl(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ',' +
 					width + ',' + strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ');');
end;
procedure FillCircleJS(x, y, r: real; fillColor: Color);
begin
  OutputJS('Crcl(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ');');
end;
procedure StrokeCircleJS(x, y, r: real; strokeColor: Color; width: real);
begin
  OutputJS('CrclS(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + 
 					 strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B +','+width+');');
end;

procedure ArcJS(x,y,r,angle1,angle2:real; strokeColor: Color; width: real);
begin
  OutputJS('Arc(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + angle1 + ',' + angle2 + ',' +
 					  strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ',' + width + ');');
end;
procedure SectorJS(x,y,r,angle1,angle2:real; fillColor,strokeColor: Color; width: real);
begin
  OutputJS('Sect(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + angle1 + ',' + angle2 + ',' +
            fillColor.R + ',' + fillColor.G + ',' + fillColor.B + ',' +
 					  strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ',' + width + ');');
end;
procedure StrokeSectorJS(x,y,r,angle1,angle2:real; strokeColor: Color; width: real);
begin
  OutputJS('SectS(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + angle1 + ',' + angle2 + ',' +
 					  strokeColor.R + ',' + strokeColor.G + ',' + strokeColor.B + ',' + width + ');');
end;
procedure FillSectorJS(x,y,r,angle1,angle2:real; fillColor:Color);
begin
  OutputJS('Sect(' + x.ToString('0.000') + ',' + y.ToString('0.000') + ',' + r + ',' + angle1 + ',' + angle2 + ',' +
            fillColor.R + ',' + fillColor.G + ',' + fillColor.B +');');
end;

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

procedure DrawLinesJS(arr: array of (Point,Point); lineColor: Color; width: real);
begin
  var temp := new StringBuilder(); 
  var   x1 := new StringBuilder();
  var   y1 := new StringBuilder();
  var   x2 := new StringBuilder();
  var   y2 := new StringBuilder();
  x1 += '['; x2 += '['; y1 += '['; y2 += '['; 
  temp += 'RndLns(';
  for var i := 0 to arr.Count - 2 do
  begin
    x1+=arr[i].Item1.X.ToString('0.000')+',';
    x2+=arr[i].Item2.X.ToString('0.000')+',';
    y1+=arr[i].Item1.Y.ToString('0.000')+',';
    y2+=arr[i].Item2.Y.ToString('0.000')+',';
  end;
  x1+=arr[arr.Count - 1].Item1.X.ToString('0.000')+']';
  y1+=arr[arr.Count - 1].Item1.Y.ToString('0.000')+']';
  x2+=arr[arr.Count - 1].Item2.X.ToString('0.000')+']';
  y2+=arr[arr.Count - 1].Item2.Y.ToString('0.000')+']';
  temp += x1.ToString() +','+y1.ToString() +','+x2.ToString() +','+y2.ToString() +','+
    width + ',' + lineColor.R + ',' + lineColor.G + ',' + lineColor.B + ');';
  OutputJS(temp.ToString);
end;
procedure DrawLineJS(x1, y1, x2, y2: real; c: Color; width: real);
begin
  OutputJS('Lns(['+x1+','+x2+'],['+y1+','+y2+'],'+width+','+c.R+','+c.G+','+c.B+');');
end;
procedure DrawPolyLineJS(arr: array of Point; c: Color; width: real);
begin
  var temp := new StringBuilder();
  var   x := new StringBuilder();
  var   y := new StringBuilder();
  x += '['; y += '[';
  temp += 'Lns(';
  for var i := 0 to arr.Count - 2 do
  begin
    x+=arr[i].X.ToString('0.000')+',';
    y+=arr[i].Y.ToString('0.000')+',';
  end;
  x+=arr[arr.Count - 1].X.ToString('0.000')+']';
  y+=arr[arr.Count - 1].Y.ToString('0.000')+']';
  temp += x.ToString() +','+y.ToString() +','+
    width + ',' + c.R + ',' + c.G + ',' + c.B + ');';
  OutputJS(temp.ToString);
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

procedure TextOutJS(x, y: real; text: string; fnt: FontOptions; c: Color; align: Alignment;angle: real);
begin
  //y := y + TextHeight(text, fnt) * 0.15;
  var f := (fnt.Size / 96 * 72) + 'pt ' + fnt.Name;
  var align_w := '';
  case align of
    LeftTop,LeftCenter,LeftBottom: align_w := 'left';
    RightTop,RightCenter,RightBottom: align_w := 'right';
    CenterTop,Center,CenterBottom: align_w := 'center';
  end;
  var align_h := 'top';
  case align of
    Center,RightCenter,LeftCenter: align_h := 'center';//y -= TextHeight(text, fnt)/2;
    LeftBottom,RightBottom,CenterBottom: align_h := 'bottom';//y -= TextHeight(text, fnt);
  end;
  OutputJS('Txt('+x.ToString('0.000')+','+y.ToString('0.000')+',"'+text+'","'+f+'",'+
            c.R+','+c.G+','+c.B+',"'+align_w+'","'+align_h+'",'+angle+');');
end;

/////////////////////////////////////////////

///---- P - primitives

procedure SetPixel(x,y: real; c: Color) := SetPixelJS(x,y,c);

procedure Ellipse(x,y,rx,ry: real) := EllipseJS(x,y,rx,ry,Brush.Color,Pen.Color,Pen.Width);
procedure DrawEllipse(x,y,rx,ry: real) := StrokeEllipseJS(x,y,rx,ry,Pen.Color,Pen.Width);
procedure FillEllipse(x,y,rx,ry: real) := FillEllipseJS(x,y,rx,ry,Brush.Color);
procedure Ellipse(x,y,rx,ry: real; c: Color):= EllipseJS(x,y,rx,ry,c,Pen.Color,Pen.Width);
procedure DrawEllipse(x,y,rx,ry: real; c: Color):= StrokeEllipseJS(x,y,rx,ry,c,Pen.Width);
procedure FillEllipse(x,y,rx,ry: real; c: Color):=FillEllipseJS(x,y,rx,ry,c);

procedure Ellipse(p: Point; rx,ry: real) := Ellipse(p.x,p.y,rx,ry);
procedure DrawEllipse(p: Point; rx,ry: real):= DrawEllipse(p.x,p.y,rx,ry);
procedure FillEllipse(p: Point; rx,ry: real):= FillEllipse(p.x,p.y,rx,ry);
procedure Ellipse(p: Point; rx,ry: real; c: Color):= Ellipse(p.x,p.y,rx,ry,c);
procedure DrawEllipse(p: Point; rx,ry: real; c: Color):= DrawEllipse(p.x,p.y,rx,ry,c);
procedure FillEllipse(p: Point; rx,ry: real; c: Color):= FillEllipse(p.x,p.y,rx,ry,c);

procedure Circle(x,y,r: real) := CircleJS(x,y,r,Brush.Color,Pen.Color,Pen.Width);
procedure DrawCircle(x,y,r: real):= StrokeCircleJS(x,y,r,Pen.Color,Pen.Width);
procedure FillCircle(x,y,r: real):= FillCircleJS(x,y,r,Brush.Color);
procedure Circle(x,y,r: real; c: Color):= CircleJS(x,y,r,c,Pen.Color,Pen.Width);
procedure DrawCircle(x,y,r: real; c: Color):= StrokeCircleJS(x,y,r,c,Pen.Width);
procedure FillCircle(x,y,r: real; c: Color):= FillCircleJS(x,y,r,c);

procedure Circle(p: Point; r: real):=Circle(p.x,p.y,r);
procedure DrawCircle(p: Point; r: real):=DrawCircle(p.x,p.y,r);
procedure FillCircle(p: Point; r: real):=FillCircle(p.x,p.y,r);
procedure Circle(p: Point; r: real; c: Color):=Circle(p.x,p.y,r,c);
procedure DrawCircle(p: Point; r: real; c: Color):=DrawCircle(p.x,p.y,r,c);
procedure FillCircle(p: Point; r: real; c: Color):=FillCircle(p.x,p.y,r,c);

procedure Arc(x, y, r, angle1, angle2: real) := ArcJS(x,y,r,angle1,angle2,Pen.Color,Pen.Width);
procedure Arc(x, y, r, angle1, angle2: real; c: Color):= ArcJS(x,y,r,angle1,angle2,c,Pen.Width);

procedure Sector(x, y, r, angle1, angle2: real):=SectorJS(x,y,r,angle1,angle2,Brush.Color,Pen.Color,Pen.Width);
procedure Pie(x, y, r, angle1, angle2: real):=SectorJS(x,y,r,angle1,angle2,Brush.Color,Pen.Color,Pen.Width);
procedure DrawSector(x, y, r, angle1, angle2: real):=StrokeSectorJS(x,y,r,angle1,angle2,Pen.Color,Pen.Width);
procedure FillSector(x, y, r, angle1, angle2: real):=FillSectorJS(x,y,r,angle1,angle2,Brush.Color);
procedure Sector(x, y, r, angle1, angle2: real; c: Color):=SectorJS(x,y,r,angle1,angle2,c,Pen.Color,Pen.Width);
procedure DrawSector(x, y, r, angle1, angle2: real; c: Color):=StrokeSectorJS(x,y,r,angle1,angle2,c,Pen.Width);
procedure FillSector(x, y, r, angle1, angle2: real; c: Color):=FillSectorJS(x,y,r,angle1,angle2,c);

procedure Line(x,y,x1,y1: real):=DrawLineJS(x,y,x1,y1,Pen.Color,Pen.Width);
procedure Line(x,y,x1,y1: real; c: Color):=DrawLineJS(x,y,x1,y1,c,Pen.Width);
procedure Line(p,p1: Point):=DrawLineJS(p.x,p.y,p1.x,p1.y,Pen.Color,Pen.Width);
procedure Line(p,p1: Point; c: Color):=DrawLineJS(p.x,p.y,p1.x,p1.y,c,Pen.Width);
procedure Lines(a: array of (Point,Point)):=DrawLinesJS(a,Pen.Color,Pen.Width);
procedure Lines(a: array of (Point,Point); c: Color):=DrawLinesJS(a,c,Pen.Width);

procedure MoveTo(x,y: real) := (Pen.X,Pen.Y) := (x,y);
procedure LineTo(x,y: real);
begin 
  Line(Pen.X,Pen.Y,x,y);
  MoveTo(x,y);
end;
procedure MoveRel(dx,dy: real) := (Pen.X,Pen.Y) := (Pen.X + dx, Pen.Y + dy);
procedure LineRel(dx,dy: real) := LineTo(Pen.X + dx, Pen.Y + dy);
procedure MoveOn(dx,dy: real) := MoveRel(dx,dy);
procedure LineOn(dx,dy: real) := LineRel(dx,dy);
procedure MoveBy(dx,dy: real) := MoveRel(dx,dy);
procedure LineBy(dx,dy: real) := LineRel(dx,dy);

procedure PolyLine(points: array of Point):=DrawPolyLineJS(points,Pen.Color,Pen.Width);
procedure PolyLine(points: array of Point; c: Color):=DrawPolyLineJS(points,c,Pen.Width);

procedure Rectangle(x,y,w,h: real) := RectangleJS(x,y,w,h,Brush.Color,Pen.Color,Pen.Width);
procedure DrawRectangle(x,y,w,h: real) := StrokeRectangleJS(x,y,w,h,Pen.Color,Pen.Width);
procedure FillRectangle(x,y,w,h: real) := FillRectangleJS(x,y,w,h,Brush.Color);
procedure Rectangle(x,y,w,h: real; c: Color) := RectangleJS(x,y,w,h,c,Pen.Color,Pen.Width);
procedure DrawRectangle(x,y,w,h: real; c: Color) := StrokeRectangleJS(x,y,w,h,c,Pen.Width);
procedure FillRectangle(x,y,w,h: real; c: Color) := FillRectangleJS(x,y,w,h,c);

procedure TextOut(x, y: real; text: string):=TextOutJS(x,y,text,Font,Font.Color,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: string; align: Alignment; angle: real):=TextOutJS(x,y,text,Font,Font.Color,align,angle);
procedure TextOut(x, y: real; text: string; c: Color):=TextOutJS(x,y,text,Font,c,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: string; c: Color; align: Alignment; angle: real):=TextOutJS(x,y,text,Font,c,align,angle);
procedure TextOut(x, y: real; text: integer):=TextOutJS(x,y,text.ToString,Font,Font.Color,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: integer; align: Alignment; angle: real):=TextOutJS(x,y,text.ToString,Font,Font.Color,align,angle);
procedure TextOut(x, y: real; text: integer; c: Color):=TextOutJS(x,y,text.ToString,Font,c,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: integer; c: Color; align: Alignment; angle: real):=TextOutJS(x,y,text.ToString,Font,c,align,angle);
procedure TextOut(x, y: real; text: real):=TextOutJS(x,y,text.ToString,Font,Font.Color,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: real; align: Alignment; angle: real):=TextOutJS(x,y,text.ToString,Font,Font.Color,align,angle);
procedure TextOut(x, y: real; text: real; c: Color):=TextOutJS(x,y,text.ToString,Font,c,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: real; c: Color; align: Alignment; angle: real):=TextOutJS(x,y,text.ToString,Font,c,align,angle);
procedure TextOut(x, y: real; text: string; f: FontOptions):=TextOutJS(x,y,text.ToString,f,f.Color,Alignment.LeftTop,0.0);
procedure TextOut(x, y: real; text: string; f: FontOptions; align: Alignment; angle: real):=TextOutJS(x,y,text.ToString,f,f.Color,align,angle);

procedure InitModule();
begin
  w := 800; h := 600;
  Brush := new BrushType();
  Pen := new PenType();
  curOutputId := System.DateTime.UtcNow.Ticks.ToString;
  OutputJS('cv_'+curOutputId+' = document.getElementById("'+curOutputId+'");');
  OutputJS('cx_'+curOutputId+' = cv_'+curOutputId+'.getContext("2d");');
end;

procedure FinalizeModule();
begin
  var s := '<html><canvas width="'+w+'" height="'+h+'" id="'+curOutputId+'"></canvas>';
  s := s + ReadAllText('JSGraphBegin.txt').Replace(NewLine,' ').
                        Replace('cv','cv_'+curOutputId).
                        Replace('cx','cx_'+curOutputId).
                        Replace('downloadCnv','downloadCnv_'+curOutputId).
                        Replace('copyCnv','copyCnv_'+curOutputId); 
  OutputJS('</script></html>');
  
  if drawUI then
  begin
    var addition := ReadAllText('JSUIAddition.txt').Replace(NewLine,' ');
    addition := addition.Replace('downloadCnv','downloadCnv_'+curOutputId).
                         Replace('copyCnv','copyCnv_'+curOutputId);
    OutputJS(addition);
  end;

  WriteLn(s+output.ToString());
end;

initialization
  InitModule();
finalization
  FinalizeModule();
end. 