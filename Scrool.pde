class Scroll implements Drawer {
  int offsetX = 100;
  int offsetY = 100;
  float xoff = 0.0;
  int ellipseSize = 50;
  
  PVector acc = new PVector(0,5);
  PVector pos = new PVector(1,1);
  
  float kickValue = 0;
  float snareValue = 0;
  Ani kickAni;
  Ani snareAni;
  int amp = 2;
  int avgOffset = 11;
  color turnColor;
  
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
     if(situation == Situation.Conclusion) {
         offsetX = 50;
         offsetY = 50;
         pos = new PVector(1,1);
     } else {
         offsetX = 100;
         offsetY = 100;       
     }
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
  int index = 0;
  void UpdateTurn(){
    UpsateScroll();
    if(analyzer.isKick()) {
      turnColor = pallette.colors.get((int)random((float)pallette.colors.size())).Color;
    }
  }
  
  void UpdateConclusion(){
    xoff += 0.1;
    avgOffset = (int)random(0,12);
    //index = index%analyzer.avgSize();
    //UpsateScroll();
  }
  
  void DrawIntroduction(){
    background(0);
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
        if(situation == Situation.Conclusion) {
          if(analyzer.isKick()) {
            fill(lerpColor(0,pallette.KeyColor(),analyzer.getAvg((sizeX*y+x*avgOffset)%analyzer.avgSize())*amp));
          } else {
            fill(lerpColor(0,pallette.AccentColor(),analyzer.getAvg((sizeX*y+x*avgOffset)%analyzer.avgSize())*amp));
          }
        }
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
     background(lerpColor(0,pallette.KeyColor(),kickValue));
     DrawCommon();
  }
  
  void DrawTurn(){
    int sizeX = width/offsetX + 6;
    int sizeY = height/offsetY + 6;
    pushMatrix();
    pushStyle();
    noStroke();
    translate(pos.x - offsetX*2,pos.y - offsetY*2);
    for(int y = 0; y < sizeY; y++){
      pushMatrix();
      if(y%2==0) translate(offsetX/2,0);
      for(int x = 0; x < sizeX; x++) {
        fill(turnColor);
        //fill(lerpColor(0,pallette.SubColor(),analyzer.getAvg((sizeX*y+x)%analyzer.avgSize())));
        ellipse(0,0,ellipseSize,ellipseSize);
        translate(offsetX,0);
      }
      popMatrix();
      translate(0,offsetY);
    }
    popMatrix();
    popStyle();
  }
  
  void DrawConclusion(){
    pushMatrix();
    pushStyle();
    noStroke();
    fill(0,32);
    rect(0,0,width,height);
    popMatrix();
    popStyle();
    DrawCommon();
  }
}