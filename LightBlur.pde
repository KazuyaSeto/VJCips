// ビデオ用のインターフェイ
interface Drawer {
  void ChangeSituation();
  abstract void Setup();
  abstract void UpdateIntroduction();
  abstract void UpdateDevelopment();
  abstract void UpdateTurn();
  abstract void UpdateConclusion();
  abstract void DrawIntroduction();
  abstract void DrawDevelopment();
  abstract void DrawTurn();
  abstract void DrawConclusion();
}


public class Test1 implements Drawer {
  void ChangeSituation(){}
  void Setup(){}
  void UpdateIntroduction(){}
  void UpdateDevelopment(){}
  void UpdateTurn(){}
  void UpdateConclusion(){}
  void DrawIntroduction(){}
  void DrawDevelopment(){}
  void DrawTurn(){}
  void DrawConclusion(){}
}

public class Test2 implements Drawer {
  void ChangeSituation(){}
  void Setup(){}
  void UpdateIntroduction(){}
  void UpdateDevelopment(){}
  void UpdateTurn(){}
  void UpdateConclusion(){}
  void DrawIntroduction(){}
  void DrawDevelopment(){}
  void DrawTurn(){}
  void DrawConclusion(){}
}

public class LightBlur implements Drawer {
  int r = 50;
  int amp = 100;
  int fade = 250;
  float s = 1.06;
  float angle = 0.01;
  boolean clear = false;
  void ChangeSituation(){
    if(situation == Situation.Turn) clear = true;
  }
  void Setup(){}
  void UpdateIntroduction(){
    r = 50;
    amp = 100;
    fade = 250;
    s = 1.06;
    angle = 0.01;
  }
  void UpdateDevelopment(){
    r = 50;
    amp = 100;
    fade = 250;
    s = 1.06;
    angle = 0.01;
  }
  void UpdateTurn(){
    r = 150;
    amp = 200;
    fade = 253;
    s = 0.98;
    angle = -0.05;
  }
  void UpdateConclusion(){
    r = 50;
    amp = 100;
    fade = 250;
    s = 1.02;
    angle = 0.01;
  }
  
  void DrawIntroduction(){
    pushStyle();
    blendMode(BLEND);
    rdraw();
    popStyle();
  }
  void DrawDevelopment(){
    pushStyle();
    blendMode(ADD);
    rdraw();
    popStyle();
  }
  
  void DrawTurn(){
    pushStyle();
    blendMode(ADD);
    rdraw();
    popStyle();
  }
  void DrawConclusion(){
    pushStyle();
    blendMode(ADD);
    rdraw();
    popStyle();
  }
  
  void rdraw()
  {
    pushStyle(); 
    colorMode(RGB,255);
    imageMode(CENTER);
    rectMode(CENTER);
    ellipseMode(CENTER);
    tint( 255, fade );
    pushMatrix();
    translate(width/2,height/2);
    rotate(angle);
    scale(s);
    background(0);
    if(!clear)
    {
      image(imgBuff,loopx,loopy, width, height);
    }
    else {
      clear = false;
    }
    popMatrix();
    drawVolume();
    UpdateImageBuffer();
    popStyle();
  }
  
  void drawVolume()
  {
    pushMatrix();
    pushStyle();
    translate(width/2,height/2);
    rotate(angle);
    fill(0);
    noStroke();
    int size = analyzer.bufferSize()/3;
    float w = (float)width/(float)size;
    if(analyzer.isHat())fill(pallette.colors.get(0).Color);
    if(analyzer.isSnare())fill(pallette.colors.get(1).Color);
    for(int i = 1; i < size; i++) {
      rotate(360/(float)size);
      if(situation != Situation.Conclusion) {
        ellipse(0,r-analyzer.getLeft(i)*amp,10,10);
      }
      else {
        ellipse(analyzer.getRight(i)*amp,r-analyzer.getLeft(i)*amp,10,10);
      }
    }
  
    popStyle();
    popMatrix();
  }

}