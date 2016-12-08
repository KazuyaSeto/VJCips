class Swimer implements Drawer {
  PShape dlogoShape;
  PImage dlogImage;
  Swimer() {
    dlogoShape = loadShape("dlogo.svg");
    dlogImage = loadImage("d3.gif");
  }
  
  void ChangeSituation(){

  }
  
  void Setup(){

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
    shapeMode(CENTER);
    imageMode(CENTER);
    background(255);
    translate(width/2,height/2);
    //shape(dlogoShape,0,0);
    image(dlogImage,0,0);
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