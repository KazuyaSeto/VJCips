class Scroll implements Drawer {
  int offsetX = 100;
  int offsetY = 100;
  
  int ellipseSize = 50;
  
  PVector acc = new PVector(0,5);
  PVector pos = new PVector(1,1);
  
  float kickValue = 0;
  float snareValue = 0;
  Ani kickAni;
  Ani snareAni;
  
  void UpsateScroll()
  {
    // ドットのスクロール
    pos.add(acc);
    if(pos.x > offsetX*2){
      pos.x = pos.x - offsetX*2;
    } else if(pos.x < -offsetX*2){
      pos.x = pos.x + offsetX*2;
    }
     
    if(pos.y > offsetY*2) {
       pos.y = pos.y - offsetY*2;
    } else if(pos.y < -offsetY*2){
      pos.y = pos.y + offsetY*2;
    }
  }
  
  void ChangeSituation(){
     acc = new  PVector(random(-5,5), random(-5,5));
  }
  
  void Setup(){
     kickAni = Ani.from(this, 0.5, "kickValue", 1.0, Ani.QUINT_IN_OUT);
     snareAni = Ani.from(this, 0.5, "snareAni", 1.0, Ani.QUINT_IN_OUT);
  }
  
  void UpdateIntroduction(){
    UpsateScroll();
  }
  
  void UpdateDevelopment(){
    // スプライトが出てくる
    UpsateScroll();
  }
  
  void UpdateTurn(){
    // 
  }
  
  void UpdateConclusion(){
  
  }
  
  void DrawIntroduction(){
    DrawCommon();
  }
  
  void DrawCommon()
  {
    pushStyle();
    noStroke();
    smooth();

    if(analyzer.isKick() && !kickAni.isPlaying()) {
      kickAni = Ani.from(this, 0.5, "kickValue", 1.0, Ani.QUINT_IN_OUT);
    }
    if(situation == Situation.Development) background(lerpColor(0,pallette.KeyColor(),kickValue));
    else background(0);
    ellipseMode(CENTER);
    int sizeX = width/offsetX + 6;
    int sizeY = height/offsetY + 6;

    if(analyzer.isSnare() && !snareAni.isPlaying()) {
      snareAni = Ani.from(this, 0.5, "snareValue", 1.0, Ani.QUINT_IN_OUT);
    }
    
    fill(lerpColor(0,pallette.SubColor(),snareValue));
    pushMatrix();
    translate(pos.x - offsetX*2,pos.y - offsetY*2);
    for(int y = 0; y < sizeY; y++){
      pushMatrix();
      if(y%2==0) translate(offsetX/2,0);
      for(int x = 0; x < sizeX; x++) {
        ellipse(0,0,ellipseSize,ellipseSize);
        translate(offsetX,0);
      }
      popMatrix();
      translate(0,offsetY);
    }
    popMatrix();
    popStyle();
  }
  
  void DrawDevelopment(){
     DrawCommon();
  }
  
  void DrawTurn(){
  
  }
  
  void DrawConclusion(){
  
  }
}