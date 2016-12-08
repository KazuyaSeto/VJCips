class DLogo implements Drawer {
  PShape dlogoShape;
  PImage dlogImage;
  
  float delta = 0;
  DLogo() {
    dlogoShape = loadShape("dlogo.svg");
    dlogImage = loadImage("d3.png");
    //dlogImage.mask(loadImage("d3_mask.png"));
  }
  
  void ChangeSituation(){

  }
  
  void Setup(){

  }
  
  void UpdateIntroduction(){
    delta += 0.10;
  }
  
  void UpdateDevelopment(){
    delta += 0.10;
  }
  
  void UpdateTurn(){
    delta += 0.05;
  }
  
  void UpdateConclusion(){
  
  }
  
  void DrawIntroduction(){
    background(pallette.KeyColor());
    DrawDlog(1,1,dlogImage,false);
  }
    
  void DrawDevelopment(){
    background(pallette.SubColor());
    DrawDlog((int)(value0*3)+1,(int)(value1*6)+1,dlogImage,false);
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
      DrawDlog((int)(value0*3)+1,(int)(value1*6)+1,dlogImage,true);
  }
  
  void DrawConclusion(){
  
  }
}