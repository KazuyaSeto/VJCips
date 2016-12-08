class Rotater implements Drawer {
  class EllipseMotion extends Motion {
    PVector pos = new PVector(random(0,width),random(0,height));
    int num = 0;
    
    void Start(color c, int num) {
      this.c = c;
      this.num = num;
      super.Start();
    }
    
    void Draw()
    {
      fill(c,(1-value)*255*2);
      float size = 1.3 - (0.1 * num); 
      size = size < 0 ? 0.1 : size;
      ellipse(pos.x,pos.y,value*size*height,value*size*height);
    }
    
    Ani createAni() {
      Ani _ani = Ani.to(this, 1.5, "value", 1.0, Ani.QUINT_OUT,"onStart:OnStart, onEnd:OnEnd");
      return _ani;
    }
  }
  
  int size = 20;
  float value = 0;
  int index = 0;
  int drawnum = 0;
  Ani ani;
  color bgColor = 0;
  color rectColor = 0;
  boolean switchFlag = false;
  
  MotionSystem motionSystem = new MotionSystem();
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
      switchFlag = !switchFlag;
      value = 0;
      bgColor = rectColor;
      drawnum = (int)random(0,8);
      if(switchFlag) {
        index++;
        index = index%pallette.colors.size();
        rectColor = pallette.colors.get(index).Color;
      } else {
        rectColor = 0;
      }
      ani = Ani.to(this, 0.7, "value", 1.0, Ani.QUINT_OUT,"onStart:OnStart, onEnd:OnEnd");
    }
    background(bgColor);
    fill(rectColor);
    RandomDraw(drawnum);
    popMatrix();
    popStyle();
  }
  
  void RandomDraw(int number)
  {
    if(number == 0 ) {
      rect(0,0,value*width,height);
    }
    else if(number == 1 ) {
      rect(0,(1-value)*width,value*width,height);
    }
    else if(number == 2) 
    {
       ellipse(width/2,height/2,value*1.3*height,value*1.3*height);
    }
    else if(number == 3)
    {
      rect(0,0,value*width,value*height);
    }
    else if(number == 4)
    {
      rect(0,0,width,value*height);
    }
    else if(number == 5)
    {
      rect(0,(1-value)*height,width,value*height);
    }
    else if(number == 6)
    {
      for(int i = 0; i < size; i++) {
        if(i%2 == 0) {
          rect(i*width/size,0,width/size+2,value*height+2);
        } else {
          rect(i*width/size,(1-value)*height,width/size+2,value*height+1);
        }
      }
    }
    else {
      for(int i = 0; i < size; i++) {
        if(i%2 == 0) {
          rect(0,i*height/size,value*width+1,height/size+2);
        } else {
          rect((1-value)*width,i*height/size+1,value*width,height/size+2);
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
      drawnum = (int)random(6,8);
      size = (int)random(0,20);
      index++;
      index = index%pallette.colors.size();
      rectColor = pallette.colors.get(index).Color;
      ani = Ani.to(this, 0.7, "value", 1.0, Ani.EXPO_OUT,"onStart:OnStart, onEnd:OnEnd");
    }
    background(bgColor);
    fill(rectColor);
    RandomDraw(drawnum);
    popMatrix();
    popStyle();
  }
  
  void DrawTurn(){
    pushStyle();
    pushMatrix();
    noStroke();
    ellipseMode(CENTER);
    rectMode(CORNER);
    background(0);
    /*
    if(analyzer.isKick()) {
      Motion motion = new Motion();
      motion.Start();
      motionSystem.AddMotion(motion);
    }
    */
    if(analyzer.isSnare()) {
      EllipseMotion motion = new EllipseMotion();
      motion.Start(pallette.colors.get((int)random(0,pallette.colors.size())).Color, motionSystem.motions.size());
      motionSystem.AddMotion(motion);
    }
    motionSystem.Run();
    popMatrix();
    popStyle();
  }
  
  void DrawConclusion(){
    DrawDevelopment();
    pushStyle();
    pushMatrix();
    noStroke();
    ellipseMode(CENTER);
    rectMode(CORNER);
    //background(0);
    /*
    if(analyzer.isKick()) {
      Motion motion = new Motion();
      motion.Start();
      motionSystem.AddMotion(motion);
    }
    */
    if(analyzer.isSnare()) {
      EllipseMotion motion = new EllipseMotion();
      motion.Start(pallette.colors.get((int)random(0,pallette.colors.size())).Color, motionSystem.motions.size());
      motionSystem.AddMotion(motion);
    }
    motionSystem.Run();
    popMatrix();
    popStyle();
  }
}