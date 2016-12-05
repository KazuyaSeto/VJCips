import ddf.minim.analysis.*;
import ddf.minim.*;
import controlP5.*;

AudioAnalyzer analyzer;
ControlP5 cp5;

int levelSliderValue = 20;
int loopx = 0;
int loopy = 0;
int angle = 0;

Viewer[] viewers;
ColorPalette pallette;

int situation = 0;
// シチュエーション定数（起承転結）
public static class Situation {
  public static int Introduction = 0;
  public static int Development = 1;
  public static int Turn = 2;
  public static int Conclusion = 3;
}

int blend = BLEND;

// ビデオ用のインターフェイス
interface Drawer {
  void Setup();
  void UpdateIntroduction();
  void UpdateDevelopment();
  void UpdateTurn();
  void UpdateConclusion();
  void DrawIntroduction();
  void DrawDevelopment();
  void DrawTurn();
  void DrawConclusion();
}

void settings() {
  size(300, 300);
  PJOGL.profile=1;
}

void setup() {
  frameRate(60);
  guiSettings();
  viewers = new Viewer[2];
  for(int i = 0; i < viewers.length; i++) {
    String[] argsViewer = {"Viewer" + i};
    Viewer viewer = new Viewer(i);
    PApplet.runSketch(argsViewer, viewer);
  }
  
  analyzer = new AudioAnalyzer(this);  
  //pallette = new ColorPalette();
  
}

void draw()
{
    background(0);
    stroke(255);
    fill(255);
    textSize(16);
    text(""+frameRate,10,100);
    drawAudioParam();
    pushMatrix();
    translate(200,height-30);
    //pallette.draw(this,30,100);
    popMatrix();
}

void ChangeDrawer(int index)
{
  //if(index >= drawerList.size()) return; 
  //drawer = drawerList.get(index);
}

void ChangeBlendMode(int index)
{
  blend = index;
}

void ChangeSituation(int index)
{
  situation = index;
}


void guiSettings() {
  cp5 = new ControlP5(this);

  cp5.addSlider("levelSliderValue")
     .setPosition(20,20)
     .setRange(0,100)
     ; 
     
   cp5.addSlider("loopx")
     .setPosition(20,40)
     .setRange(-3,3)
     ;
   cp5.addSlider("loopy")
     .setPosition(20,60)
     .setRange(-3,3)
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



void drawAudioParam()
{
  pushStyle();
  pushMatrix();
  noSmooth();
  colorMode(RGB,255,255,255,255);
  translate(0,200);
  textSize(10);
  text("- Audio -",10,10);
  drawDramPattern();
  drawLevel();
  drawAvg();
  drawVolume();
  popMatrix();
  popStyle();
}

void drawDramPattern()
{
  pushMatrix();
  pushStyle();
  textMode(CENTER);
  noStroke();
  textAlign(CENTER);
  textSize(10);
  translate(20,20);
  int size = 60;
  int ellipseSize = 7;
  fill(255,255,0,255);
  text("hat",0,15);
  if(analyzer.isHat()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  translate(0,25);
  fill(0,255,255,255); 
  text("snare",0,15);
  if(analyzer.isSnare()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  translate(0,25);
  fill(255,0,255,255);
  text("kick",0,15);
  if(analyzer.isKick()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  popStyle();
  popMatrix();
}

void drawLevel() {
  pushMatrix();
  pushStyle();
  stroke(0);

  int rectWidth = 4;
  int space = 2;
  int size = 20;
  int amp = 5;
  translate(40,88);
  fill(0,255,0);
  for(int i = 0; i < size; i++){
    if(i>=size-3)fill(255,0,0);
    if(analyzer.getRightLevel()*amp > i){
      //rect(0,space/2 +(i * space),space,rectHeight);
      rect(0,-space/2 -(i * space),rectWidth,space);
    }
    if(analyzer.getLeftLevel()*amp > i){
      //rect(rectHeight,space/2 + (i * space),space,rectHeight);
      rect(rectWidth,-space/2 -(i * space),rectWidth,space);
    }
  }
  popStyle();
  popMatrix();
}

void drawAvg() {
  int space = 2;
  int size = 20;
  pushMatrix();
  pushStyle();
  stroke(0);
  translate(52,90);
  fill(255,0,0,255);
  for(int i = 0; i < analyzer.avgSize(); i++) {
    for(int j = 0; j < size; j++) {
      if(analyzer.getAvg(i)*size > size-j-1)rect(i*space,space*(j-size),space,space);
    }
  }
  popStyle();
  popMatrix();
}

void drawVolume()
{
  pushMatrix();
  pushStyle();
  translate(40,30);
  //fill(random(0,10),0,0);
  //noStroke();
  stroke(255);
  noFill();
  int size = width/4;
  int add = analyzer.bufferSize()/size;
  int amp = 100;
  float w = 1;
  
  beginShape();
  vertex(0,-analyzer.getRight(0)*amp);
  for(int i = 1; i < size; i++) {
    vertex(i*w,-analyzer.getRight(i)*amp);
  }
  endShape();
  
  translate(0,height/16);
  beginShape();
  vertex(0,-analyzer.getLeft(0)*amp);
  for(int i = 1; i < size; i++) {
    vertex(i*w,-analyzer.getLeft(i)*amp);
  }
  endShape();

  popStyle();
  popMatrix();
}

void drawSpectram()
{
  pushMatrix();
  pushStyle();
  stroke(255);
  fill(255);
  int size = width/4;
  int offset = analyzer.specSize()/size;
  int amp = 1;
  int w = 1;
  beginShape();
  vertex(0,0);
  for(int i = 0; i < size; i++) {
    vertex(i,-analyzer.getBand(i*offset)*amp);
  }
  vertex(0,0);
  endShape(CLOSE);
  popStyle();
  popMatrix();
}