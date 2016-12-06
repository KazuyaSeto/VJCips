public class Rotater implements Drawer {
  float value = 0;
  int index = 0;
  Ani ani;
  color bgColor = 0;
  color rectColor = 0;
  void ChangeSituation(){

  }
  
  void Setup(){
      bgColor = color(random(255),random(255),random(255));
      rectColor = color(random(255),random(255),random(255));
      ani = Ani.to(this, 0.5, "value", 1.0, Ani.QUINT_IN_OUT,"onStart:OnStart, onEnd:OnEnd");
  }
  
  void UpdateIntroduction(){
      angle += 0.01;
  }
  
  void UpdateDevelopment(){

  }
  
  void UpdateTurn(){
    
  }
  
  void UpdateConclusion(){
  
  }
  
  void DrawIntroduction(){
    pushStyle();
    pushMatrix();
    noStroke();
    ellipseMode(CENTER);
    rectMode(CORNER);
    if(!ani.isPlaying() && analyzer.isKick()) {
      value = 0;
      bgColor = rectColor;
      index++;
      index = index%pallette.colors.size();
      rectColor = pallette.colors.get(index).Color;
      ani = Ani.to(this, 0.7, "value", 1.0, Ani.QUINT_OUT,"onStart:OnStart, onEnd:OnEnd");
    }
    background(bgColor);
    fill(rectColor);
    RandomDraw(index);
    popMatrix();
    popStyle();
  }
  
  void RandomDraw(int number)
  {
    if(number == 0 ) {
      rect(0,0,value*width,height);
      // rect(0,0,value*width,value*height);
    }
    else if(number == 1) 
    {
       ellipse(width/2,height/2,value*1.3*height,value*1.3*height);
    }
    else {
      int size = 5;
      for(int i = 0; i < size; i++) {
        if(i%2 == 0) {
          rect(0,i*height/size,value*width,height/size);
        } else {
          rect((1-value)*width,i*height/size,value*width,height/size);
        }
      }
    }
  }
  
  void OnStart()
  {
    
  }

  void OnEnd(Ani _ani)
  {
     value = 0;

  }
  
  void DrawDevelopment(){
    pushStyle();
    pushMatrix();
    noStroke();
    rectMode(CORNER);
    if(!ani.isPlaying() && analyzer.isKick()) {
      value = 0;
      bgColor = rectColor;
      index++;
      index = index%pallette.colors.size();
      rectColor = pallette.colors.get(index).Color;
      ani = Ani.to(this, 0.7, "value", 1.0, Ani.EXPO_OUT,"onStart:OnStart, onEnd:OnEnd");
    }
    background(bgColor);
    fill(rectColor);
    int size = 5;
    for(int i = 0; i < size; i++) {
      if(i%2 == 0) {
        rect(0,i*height/size,value*width,height/size);
      } else {
        rect((1-value)*width,i*height/size,value*width,height/size);
      }
    }
    popMatrix();
    popStyle();
  }
  
  void DrawTurn(){
  
  }
  
  void DrawConclusion(){
  
  }
}