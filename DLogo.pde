class DLogo implements Drawer {
  PShape dlogoShape;
  PImage dlogImage;
  PImage aImage;
  PImage bImage;
  PImage bobImage;
  PImage bgImage;
  float delta = 0;
  DLogo() {
    //dlogoShape = loadShape("dlogo.svg");
    aImage = loadImage("d3.png");
    bImage = loadImage("RecordRed.png");
    bobImage = loadImage("bob.png");
    bgImage = loadImage("ginga.jpg");
    //dlogImage.mask(loadImage("d3_mask.jpg"));
  }
  
  void ChangeSituation(){

  }
  
  void Setup(){

  }
  
  void Switching() {
    if(sliders[0] < 0.33) {
      dlogImage = aImage;
    } else if( sliders[0] < 0.66){
      dlogImage = bImage;
    } else {
      dlogImage = bobImage;
    }
  }
  
  void UpdateIntroduction(){
    Switching();
    delta += 0.20 * values[2];
  }
  
  void UpdateDevelopment(){
    Switching();
    delta += 0.20 * values[2];
  }
  
  void UpdateTurn(){
    Switching();
    delta += 0.05 * values[2];
  }
  
  void UpdateConclusion(){
    Switching();
    delta += 0.40 * values[2];
  }
  
  void DrawIntroduction(){
    background(pallette.KeyColor());
    DrawDlog(1,1,dlogImage,false);
  }
    
  void DrawDevelopment(){
    background(pallette.SubColor());
    DrawDlog((int)(values[0]*3)+1,(int)(values[1]*6)+1,dlogImage,false);
  }
  
  void DrawDlog(int sizeX, int sizeY, PImage img, boolean rotateOnly)
  {
    pushMatrix();
    pushStyle();
    shapeMode(CENTER);
    imageMode(CENTER);
    int offsetX = width/sizeX;
    int offsetY = height/sizeY;
    float s = 1.5*1/((sizeX>sizeY) ? (float)sizeX : (float)sizeY);
    translate(offsetX/2, offsetY/2,-100);
    for(int j = 0; j < sizeX; j++) {
      for(int i = 0; i < sizeY; i++) {
        pushMatrix();
        translate(offsetX*j,offsetY*i);
        if(!rotateOnly) {
          translate(img.width*s*sin(delta)*0.5,0);
          rotateY((sin(delta)));
          rotateZ((sin(delta)*0.5));
        } else {
          rotateY(delta);
        }
        scale(s);
        image(img,0,0);
        popMatrix();
      }
    }
    popMatrix();
    popStyle();
  }
  
  void DrawTurn(){
      background(128);
      if(toggle) {
        background(0);
        pushMatrix();
        imageMode(CENTER);
        translate(width/2,height/2,-500);
        scale(0.7);
        image(bgImage,0,0);
        popMatrix();
      }

      DrawDlog((int)(values[0]*3)+1,(int)(values[1]*6)+1,dlogImage,true);
  }
  
  void DrawConclusion(){
      background(128);
      if(toggle) {
        background(0);
        pushMatrix();
        imageMode(CENTER);
        translate(width/2,height/2,-500);
        scale(0.7);
        image(bgImage,0,0);
        popMatrix();
      }
      DrawDlog((int)(values[0]*3)+1,(int)(values[1]*6)+1,dlogImage,true);
  }
}