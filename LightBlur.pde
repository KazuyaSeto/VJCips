public class Test1 implements Drawer {
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
  void Setup(){}
  void UpdateIntroduction(){
    angle = angle + 1;
  }
  void UpdateDevelopment(){}
  void UpdateTurn(){}
  void UpdateConclusion(){}
  void DrawIntroduction(){
    draw();
  }
  void DrawDevelopment(){}
  void DrawTurn(){}
  void DrawConclusion(){}
  
  void draw()
  {
    imageMode(CENTER);
    rectMode(CENTER);
    ellipseMode(CENTER);
    tint( 255, 254 );
    pushMatrix();
    translate(width/2+loopx,height/2+loopy);
    rotate(0.01);
    scale(1.04);
    //image(imgBuff,0,0, width, height);
    popMatrix();
    
    drawVolume();
  }
  
  void drawVolume()
  {
    if(analyzer.isKick())background(pallette.colors.get(2).Color);
  pushMatrix();
  pushStyle();
  translate(width/2,height/2);
  rotate(angle);
  //fill(random(0,10),0,0);
  //fill(0,0,0);
  noStroke();
  //stroke(0,255,255);
  //noFill();
  int size = analyzer.bufferSize()/3;
  int amp = 1000;
  float w = (float)width/(float)size;
  //if(analyzer.isKick())fill(255,255,random(0,10));
  if(analyzer.isHat())fill(pallette.colors.get(0).Color);
  //beginShape();
  //vertex(0,-analyzer.getRight(0)*amp);
  for(int i = 1; i < size; i++) {
    //vertex(i*w,-analyzer.getRight(i)*amp);
    rotate(360/(float)size);
    //if(analyzer.isSnare())fill(0,255,random(255));

    if(analyzer.isSnare())fill(pallette.colors.get(1).Color);
    ellipse(0,50-analyzer.getLeft(i)*amp,10,10);
  }
  //endShape();
  translate(0,height/2);
  fill(255,0,255);
  //beginShape();
  //vertex(0,-analyzer.getLeft(0)*amp);
  for(int i = 1; i < size; i++) {
    //vertex(i*w,-analyzer.getLeft(i)*amp);
    //ellipse(i*w,-analyzer.getLeft(i)*amp,5,5);
  }
  //endShape();

  popStyle();
  popMatrix();
}

}