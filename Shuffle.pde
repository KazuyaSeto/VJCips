class Shuffle implements Drawer {
  int i = 0;
  char c = ' ';
  String text = "";
  String shuffleText = "SHUFFLE!!";
  
  Ani ani;
  float value = 0;
  float delta = 0.0;
  void ChangeSituation(){

  }
  
  void Setup(){

  }
  
  void UpdateIntroduction(){

  }
  
  void UpdateDevelopment(){
    delta += 0.05;
  }

  void UpdateTurn(){

  }
  
  void UpdateConclusion(){
  
  }
  
  void DrawIntroduction(){
    pushMatrix();
    pushStyle();
    noSmooth();
    textMode(CENTER);
    textAlign(CENTER, CENTER);
    background(0);
    strokeWeight(2.0);
    strokeCap(ROUND);
    stroke(255);
    translate(width/2,height/2);
    fill(255);
    textSize(64);

    if(i < shuffleText.length()) 
    {
      text(text + c,0,0);  
      if(shuffleText.charAt(i) == c) {
        i++;
        text += c;
        c = ' ';
      }
      c++;
    } else {
     text(text,0,0);
     if(ani == null) ani = Ani.to(this, 1.0, "value", 1.0, Ani.QUINT_IN_OUT);
    }
    text("#開始",(1-value)*width,64);
    
    popStyle();
    popMatrix();
  }
  
  void DrawDevelopment(){
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    tint( 255,240 );
    pushMatrix();
    translate(width/2,height/2);
    //rotate(angle);
    scale(value2);
    background(0);
    image(imgBuff,loopx,loopy, width, height);
    popMatrix();
    noSmooth();
    textMode(CENTER);
    textAlign(CENTER, CENTER);
    //background(0);
    strokeWeight(2.0);
    strokeCap(ROUND);
    stroke(255);
    translate(width/2,height/2);
    textSize(64);
    fill(pallette.KeyColor(),(sin(delta)+1)*124);
    text(shuffleText,0,64);
    fill(pallette.SubColor(),(sin(delta)+1)*124);
    text(shuffleText,0,-64);
    fill(255,(sin(delta)+1)*124);
    text(shuffleText,0,0);
    //scale(analyzer.getLeftLevel()*0.5+1);
    //text(shuffleText,0,0);
    
    popStyle();
    popMatrix();    
    UpdateImageBuffer();
  }
  
  void DrawTurn(){
  }
  
  void DrawConclusion(){
  
  }
}