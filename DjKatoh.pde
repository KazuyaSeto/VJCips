class DJKatoh implements Drawer {
  PShape dlogoShape;
  PImage katohImage;
  PImage houseBgImage;
  PImage morningImage;
  PImage afterNoonImage;
  PImage nightBgImage;
  
  float scroll = 0;
  DJKatoh() {
    //dlogoShape = loadShape("katoh.png");
    katohImage = loadImage("katoh.png");
    houseBgImage = loadImage("bg_house.jpg");
    morningImage = loadImage("bg_house.jpg");
    afterNoonImage = loadImage("bg_house.jpg");
    nightBgImage = loadImage("bg_house.jpg");
  }
  
  void ChangeSituation(){

  }
  
  void Setup(){

  }
  
  void DrawScroolBg() {
    pushMatrix();
    scroll -= 0.5;
    translate(scroll,0);
    scale(height/(float)houseBgImage.height);
    image(houseBgImage,0,0);
    translate(houseBgImage.width,0);
    rotateY(180);
    image(houseBgImage,houseBgImage.width,0);
    image(houseBgImage,-houseBgImage.width,0);
    popMatrix();
  }
  
  void UpdateIntroduction(){
    
  }
  
  void UpdateDevelopment(){

  }
  
  void UpdateTurn(){
    
  }
  
  void UpdateConclusion(){
  
  }
  
  void DrawIntroduction(){
    pushMatrix();
    pushStyle();
    DrawScroolBg();
    shapeMode(CENTER);
    imageMode(CENTER);
    //background(255);
    translate(width/2,height/2);
    image(katohImage,0,0);
    //shape(dlogoShape,0,0);
    //image(dlogImage,0,0);
    popMatrix();
    popStyle();
  }
    
  void DrawDevelopment(){
     
  }
  
  void DrawTurn(){
  
  }
  
  void DrawConclusion(){
  
  }
}