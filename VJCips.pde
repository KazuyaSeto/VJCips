import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import ddf.minim.analysis.*;
import ddf.minim.*;
import controlP5.*;
import codeanticode.syphon.*;

AudioAnalyzer analyzer;
boolean reverse = false;
ControlP5 cp5;

int levelSliderValue = 20;
int loopx = 0;
int loopy = 0;
int angle = 0;

// 共通のパラメータ
int type = 0;
float value0 = 0; // 0 - 1
float value1 = 0; // 0 - 1
float value2 = 0; // 0 - 1

float slider0 = 0; // 0 - 1
float slider1 = 0; // 0 - 1
float slider2 = 0; // 0 - 1

boolean toggle = false;

ArrayList<Drawer> drawerList;
Drawer drawer;
SyphonServer server;
ColorPalette pallette;
PImage imgBuff;
PFont font;

int situation = 1;
// シチュエーション定数（起承転結）
public static class Situation {
  public static int Introduction = 0;
  public static int Development = 1;
  public static int Turn = 2;
  public static int Conclusion = 3;
}

int blend = BLEND;
boolean inited = false;

PApplet instance()
{
  return this;
}

void settings() {
  size(350, 600, P3D);
  PJOGL.profile=1;
}

void setup() {
  font = createFont( "Apple", 48, true );//loadFont("AppleSDGothicNeo-ExtraBold-48.vlw");
  textFont(font, 48);
  ortho();
  Ani.init(this);
  server = new SyphonServer(this, "P5 VJCips Syphon:" + reverse );
  imgBuff = createImage(this.width, this.height, RGB);
  InitDrawer();
  frameRate(60);
  analyzer = new AudioAnalyzer(this);  
  pallette = new ColorPalette();
  
  guiSettings();
  
}

void update()
{
    if(situation == Situation.Introduction) drawer.UpdateIntroduction();
    if(situation == Situation.Development) drawer.UpdateDevelopment();
    if(situation == Situation.Turn) drawer.UpdateTurn();
    if(situation == Situation.Conclusion) drawer.UpdateConclusion();
}

void draw()
{
    if(analyzer != null)analyzer.forward(levelSliderValue);
    if(pallette != null)pallette.Generate(angle,100,100);

 

    update();
    blendMode(blend);
    //background(frameCount%255);
    if(situation == Situation.Introduction) drawer.DrawIntroduction();
    if(situation == Situation.Development) drawer.DrawDevelopment();
    if(situation == Situation.Turn) drawer.DrawTurn();
    if(situation == Situation.Conclusion) drawer.DrawConclusion();
    server.sendScreen();
    
}

void drawFramerate()
{
    stroke(255);
    fill(255);
    textSize(16);
    text(""+frameRate,10,100);
}

void ChangeDrawer(int index)
{
    if(index >= drawerList.size())return ;
    drawer = drawerList.get(index);
    drawer.Setup();
}

void ChangeBlendMode(int index)
{
  blend = index;
}

void ChangeSituation(int index)
{
  situation = index;
  drawer.ChangeSituation();
}

void guiSettings() {
  cp5 = new ControlP5(this);

  cp5.addSlider("levelSliderValue")
     .setPosition(20,5)
     .setRange(0,100)
     ; 
     
   cp5.addSlider("value0")
     .setPosition(20,20)
     .setRange(0,1)
     ;
   cp5.addSlider("value1")
     .setPosition(20,45)
     .setRange(0,1)
     ;
   cp5.addSlider("value2")
     .setPosition(20,60)
     .setRange(-1,1)
     ;
   cp5.addSlider("angle")
     .setPosition(20,80)
     .setRange(0,720)
     ;
   cp5.addRadioButton("radioButton")
       .setPosition(10,100)
       .setSize(15,15)
       .setColorForeground(color(120))
       .setColorActive(color(255))
       .setColorLabel(color(255))
       .setItemsPerRow(10)
       .setSpacingColumn(10)
       .addItem("0",0)
       .addItem("1",1)
       .addItem("2",2)
       .addItem("3",3)
       .addItem("4",4)
       .addItem("5",5)
       .addItem("6",6)
       .addItem("7",7)
       .addItem("8",8)
       .addItem("9",9)
       ;
       
     cp5.addRadioButton("blendRadioButton")
       .setPosition(10,130)
       .setSize(15,15)
       .setColorForeground(color(120))
       .setColorActive(color(255))
       .setColorLabel(color(255))
       .setItemsPerRow(10)
       .setSpacingColumn(10)
       .addItem("BLEND",BLEND)
       .addItem("ADD",ADD)
       .addItem("SUBTRACT",SUBTRACT)
       .addItem("DARKEST",DARKEST)
       .addItem("LIGHTEST",LIGHTEST)
       .addItem("DIFFERENCE",DIFFERENCE)
       .addItem("EXCLUSION",EXCLUSION)
       .addItem("MULTIPLY",MULTIPLY)
       .addItem("SCREEN",SCREEN)
       .addItem("REPLACE",REPLACE)
       ;
     cp5.addRadioButton("changeSituationButton")
       .setPosition(10,160)
       .setSize(15,15)
       .setColorForeground(color(120))
       .setColorActive(color(255))
       .setColorLabel(color(255))
       .setItemsPerRow(10)
       .setSpacingColumn(10)
       .addItem("Intro",Situation.Introduction)
       .addItem("Develop",Situation.Development)
       .addItem("Turn",Situation.Turn)
       .addItem("Conclusion",Situation.Conclusion)
       ;
}

void radioButton(int a) {
  println("a radio Button event: "+a);
  ChangeDrawer(a);
}

void blendRadioButton(int blendType)
{
  ChangeBlendMode(blendType);
}

void changeSituationButton(int situation)
{
  ChangeSituation(situation);
}

  void InitDrawer()
  {
    drawerList = new ArrayList<Drawer>();
    drawerList.add(new Scroll());
    drawerList.add(new Rotater());
    drawerList.add(new LightBlur());
    drawerList.add(new DLogo());
    drawerList.add(new DJKatoh());
    drawerList.add(new Rail());
    drawerList.add(new Tile());
    drawerList.add(new Swimer());
    drawerList.add(new Shuffle());
    drawer = drawerList.get(0);
    drawer.Setup();
  }

  public void UpdateImageBuffer()
  {
    this.loadPixels();
    imgBuff.pixels = pixels;
    //画像バッファへ反映
    imgBuff.updatePixels();
  }