uses GraphJupyter;
begin
    WindowSize(700,300);
    Brush.Color := Colors.Black;
    Pen.Width := 0.5;
    Pen.Color := Colors.Red;
    
    for var i := 1 to 3 do
        for var j := 1 to 3 do
        begin
            Line(i*100-30,j*50,i*100+30,j*50);
            Line(i*100,j*50-15,i*100,j*50+15);
        end;
    TextOut(90,10,'Top');
    TextOut(185,10,'Center');
    TextOut(280,10,'Bottom');
    TextOut(10,40,'Left');
    TextOut(10,90,'Center');
    TextOut(10,140,'Right');
        
    
    Font.Color := Colors.Black;
    TextOut(100,50,'hello',Alignment.LeftTop);
    TextOut(200,50,'hello',Alignment.LeftCenter);
    TextOut(300,50,'hello',Alignment.LeftBottom);
    
    Font.Color := Colors.Green;
    TextOut(100,100,'hello',Alignment.CenterTop);
    TextOut(200,100,'hello',Alignment.Center);
    TextOut(300,100,'hello',Alignment.CenterBottom);
    
    Font.Color := Colors.Purple;
    TextOut(100,150,'hello',Alignment.RightTop);
    TextOut(200,150,'hello',Alignment.RightCenter);
    TextOut(300,150,'hello',Alignment.RightBottom);
    
    TextOut(400,30,'Текст под углом 30 градусов!',Alignment.LeftTop,30);
end.