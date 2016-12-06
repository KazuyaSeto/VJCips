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
  
  float angle = 0.1;
  void ChangeSituation(){}
  void Setup(){}
  void UpdateIntroduction(){
    angle = angle + 1;
  }
  void UpdateDevelopment(){}
  void UpdateTurn(){}
  void UpdateConclusion(){}
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
  void DrawTurn(){}
  void DrawConclusion(){}
  
  void rdraw()
  {
    pushStyle(); 
    colorMode(RGB,255);
    imageMode(CENTER);
    rectMode(CENTER);
    ellipseMode(CENTER);
    tint( 255, 254 );
    pushMatrix();
    translate(width/2,height/2);
    rotate(0.01);
    scale(1.06);
    background(0);
    image(imgBuff,loopx,loopy, width, height); 
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
  int amp = 500;
  float w = (float)width/(float)size;
  if(analyzer.isHat())fill(pallette.colors.get(0).Color);
  if(analyzer.isSnare())fill(pallette.colors.get(1).Color);
  for(int i = 1; i < size; i++) {
    rotate(360/(float)size);
    ellipse(0,50-analyzer.getLeft(i)*amp,10,10);
  }

  popStyle();
  popMatrix();
}

}