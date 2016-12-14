import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import oscP5.*;
import netP5.*;

import ddf.minim.analysis.*;
import ddf.minim.*;
import controlP5.*;
import codeanticode.syphon.*;

AudioAnalyzer analyzer;

ControlP5 cp5;
OscP5 oscP5;
NetAddress myRemoteLocation;

// 共通のパラメータ
// 音系
float levelValue = 20;
boolean reverse = false;
// 色系
int angle = 0;
int blend = BLEND;

// 汎用パラメータ
int type = 0;
float[] values = {0,0,0,0,0}; // 0 - 1
float[] sliders = {0,0,0,0,0}; // 0 - 1
PVector slider2D = new PVector(0,0);
boolean toggle = false;

ArrayList<Drawer> drawerList;
Drawer drawer;
SyphonServer server;
ColorPalette pallette;
PImage imgBuff;
PFont font;

int situation = 0;
// シチュエーション定数（起承転結）
public static class Situation {
  public static int Introduction = 0;
  public static int Development = 1;
  public static int Turn = 2;
  public static int Conclusion = 3;
}

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
  
  //guiSettings();
  setupOSC();
}

void setupOSC() {
    oscP5 = new OscP5(this,12000);
    myRemoteLocation = new NetAddress("127.0.0.1",12000);
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
    if(analyzer != null)analyzer.forward(levelValue);
    if(pallette != null)pallette.Generate(angle,100,100);
    update();
    blendMode(blend);
    if(situation == Situation.Introduction) drawer.DrawIntroduction();
    if(situation == Situation.Development) drawer.DrawDevelopment();
    if(situation == Situation.Turn) drawer.DrawTurn();
    if(situation == Situation.Conclusion) drawer.DrawConclusion();
    server.sendScreen();
    //drawOsc();
}

void drawOsc()
{
  // 共通のパラメータ
  // 音系
  textSize(10);
  int y = 10; int h = 10;
  text("levelValue:" + levelValue,0,y); y = y + h;
  text("reverse:" + reverse,0,y); y = y + h;
  // 色系
  text("angle:" + angle,0,y); y = y + h;
  text("blend:" + blend,0,y); y = y + h;
  // 汎用パラメータ
  text("type:" + type,0,y); y = y + h;
  for(int i = 0; i < 3; i++) {
    text("value:" + i + ":"+ values[i],0,y); y = y + h;
    text("slider:" + i + ":" + sliders[i],0,y); y = y + h;
  }
  text("type:" + type,0,y); y = y + h;
  text("slider2D:" + slider2D,0,y); y = y + h;
  text("toggle:" + toggle,0,y); y = y + h;  
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

void oscEvent(OscMessage theOscMessage) {
  print(theOscMessage.toString());
  for(int i = 1; i <= 5; i++) {
    for(int j = 1; j <= 2; j++) {
      if(getOscValue(theOscMessage,"cips/"+j+"/"+i,false)){
        ChangeDrawer((j-1)*5+i-1);
        ChangeSituation(0);
      }
    }
  }
  for(int i = 1; i <= 4; i++) {
    if(getOscValue(theOscMessage,"situation/1/"+i,false)){
      ChangeSituation(i-1);
    }
  }
  levelValue = getOscValue(theOscMessage, "level", levelValue);
  angle = getOscValue(theOscMessage, "angle", angle);
  reverse = getOscValue(theOscMessage,"reverse",reverse);
  type = getOscValue(theOscMessage,"type",type);
  toggle = getOscValue(theOscMessage,"toggle",toggle);
  for(int i = 1; i <= 3; i++) {
    values[i-1] = getOscValue(theOscMessage, "values/"+i, values[i-1]);
    sliders[i-1] = getOscValue(theOscMessage, "sliders/"+i, sliders[i-1]);
  }
  for(int i = 1; i <= 4; i++) {
    if(getOscValue(theOscMessage,"blend/1/"+i,false)){
      if(i==1)ChangeBlendMode(BLEND);
      if(i==2)ChangeBlendMode(ADD);
      if(i==3)ChangeBlendMode(MULTIPLY);
      if(i==4)ChangeBlendMode(EXCLUSION);
    }
  }
  updateSlider2D(theOscMessage);
}

void updateSlider2D(OscMessage theOscMessage)
{
  if(theOscMessage.checkAddrPattern("/Main/" + "slider2D")) {
    if(theOscMessage.checkTypetag("ff")) {
      slider2D.set(theOscMessage.get(0).floatValue(),theOscMessage.get(1).floatValue());
    }  
  }
}

int getOscValue(OscMessage theOscMessage, String valueName, int defaultValue)
{
  if(theOscMessage.checkAddrPattern("/Main/" + valueName)) {
    if(theOscMessage.checkTypetag("f")) {
      
      return (int)theOscMessage.get(0).floatValue();  
    }  
  }
  return defaultValue;
}

float getOscValue(OscMessage theOscMessage, String valueName, float defaultValue)
{
  if(theOscMessage.checkAddrPattern("/Main/" + valueName)) {
    if(theOscMessage.checkTypetag("f")) {
      return theOscMessage.get(0).floatValue();  
    }  
  }
  return defaultValue;
}

boolean getOscValue(OscMessage theOscMessage, String valueName, boolean defaultValue)
{
  if(theOscMessage.checkAddrPattern("/Main/" + valueName)) {
    if(theOscMessage.checkTypetag("f")) {
      return (theOscMessage.get(0).floatValue() == 1.0);  
    }  
  }
  return defaultValue;
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
    drawerList.add(new Swimer());
    //drawerList.add(new Shuffle());
    //drawerList.add(new Rail());
    //drawerList.add(new Tile());
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