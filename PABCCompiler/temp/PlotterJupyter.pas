unit PlotterJupyter;

interface

uses FigureModule, RendererModuleJS;

type
  Figure = FigureModule.Figure;
  Axes = FigureModule.Axes;
  Curve = FigureModule.Curve;
  Color = System.Windows.Media.Color;
  Colors = System.Windows.Media.Colors;

///Создать область отображения графиков
function GetFigure(): Figure;
///Создать область отображения с графиками
function GetSubplots(rows, cols: integer): (Figure, List<Axes>);
///Отобразить окно с графиком
procedure Show(fig: Figure);
///Задать размеры окна
procedure WindowSize(width, height: integer);
///Требуется ли отображение кнопок
procedure NeedButtons(flag: boolean);

implementation

function GetFigure(): Figure;
begin
  Result := new Figure();
end;

function GetSubplots(rows, cols: integer): (Figure, List<Axes>);
begin
  var fig := new Figure();
  for var i := 0 to rows * cols - 1 do
    fig.addSubplot(rows, cols, i);
  Result := (fig, fig.GetAxes);
end;

procedure WindowSize(width, height: integer);
begin
  RendererModuleJS.WindowSize(width, height);
end;

procedure NeedButtons(flag: boolean):= RendererModuleJS.NeedButtons(flag);

procedure Show(fig: Figure);
begin
  RendererModuleJS.Show(fig);
end;
initialization

finalization

end. 