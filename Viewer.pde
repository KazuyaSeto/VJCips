import codeanticode.syphon.*;

public class Viewer extends PApplet {
  ArrayList<Drawer> drawerList;
  Drawer drawer;
  SyphonServer server;
  int index = 0;
  PImage imgBuff;
  
  Viewer(int _index){
    index = _index;
  }
  
  void settings() {
    size(350, 600, P3D);
    PJOGL.profile=1;
  }
  
  void setup()
  {
    this.server = new SyphonServer(this, "P5 VJCips Syphon" + index);
    imgBuff = createImage(width, height, RGB);
    InitDrawer();
  }
  
  void draw() {  
    update();
    background(frameCount%255);
    if(situation == Situation.Introduction) drawer.DrawIntroduction();
    if(situation == Situation.Development) drawer.DrawDevelopment();
    if(situation == Situation.Turn) drawer.DrawTurn();
    if(situation == Situation.Conclusion) drawer.DrawConclusion();
    server.sendScreen();
  }
  
  void update()
  {
    if(analyzer != null)analyzer.forward(levelSliderValue);
    if(pallette != null)pallette.Generate(angle,100,100);
  
    if(situation == Situation.Introduction) drawer.UpdateIntroduction();
    if(situation == Situation.Development) drawer.UpdateDevelopment();
    if(situation == Situation.Turn) drawer.UpdateTurn();
    if(situation == Situation.Conclusion) drawer.UpdateConclusion();
    
    //UpdateImageBuffer();
  }
  
  void InitDrawer()
  {
    drawerList = new ArrayList<Drawer>();
    drawerList.add(new Test1());
    drawerList.add(new Test2());
    drawerList.add(new LightBlur());
    drawer = drawerList.get(0);
  }

  void UpdateImageBuffer()
  {
    loadPixels();
    imgBuff.pixels = pixels;
    //画像バッファへ反映
    imgBuff.updatePixels();
  }
}