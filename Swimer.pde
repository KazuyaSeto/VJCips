class Swimer implements Drawer {
  class Particle {
     PVector pos;
     PImage img;
     float value = 1.0;
     float s = 1;
     Ani ani;
     Particle() {}
     Particle(PImage _img, float s) {
       img = _img;
       s = random(0.1,s);
       ani = Ani.to(this, 3.0, "value", 0.0, Ani.LINEAR);
       pos = new PVector(random(width),random(height));
     }
     
     boolean IsActive() { 
       if(pos.x<-img.width/2) {
         return false;
       }
       if(pos.x>width+img.width/2) {
         return false;
       }
       if(pos.y<-img.height/2) {
         return false;
       }
       if(pos.y>height+img.height/2) {
         return false;
       }
       return true;
       //if(ani == null) return false;
       //return ani.isPlaying();
     }
     
     void Update() {
       pos.sub(acc);
     }
     
     void Draw() {
       pushMatrix();
       pushStyle();
       imageMode(CENTER);
       translate(pos.x,pos.y);
       scale(s*value);
       rotateZ(-value*PI*2);
       colorMode(HSB,360,100,100,100);
       if(situation != Situation.Conclusion) {
         tint(lerpColor(pallette.KeyColor(),color(0,0,100),value));
       } else {
         tint(lerpColor(pallette.AccentColor(),pallette.SubColor(),value));
       }
       image(img,0,0);
       popStyle();
       popMatrix();
     }
  }
  
  class Bubble extends Particle {
     Bubble(PImage _img, float _s) {
       img = _img;
       s = 0.01;
       //ani = Ani.to(this, 3.0, "value", 0.0, Ani.LINEAR);
       pos = new PVector(random(-img.width/2,width+img.width/2),random(-img.height/2,height+img.height/2));
     }
     
     boolean IsActive() { 
       return true;
     }
     
     void Update() {
       pos.x -= acc.x * 0.8;
       pos.y -= acc.y * 0.8;
       if(pos.x<-img.width/2) {
         pos.x += width + img.width;
       }
       if(pos.x>width+img.width/2) {
         pos.x -= width + img.width;
       }
       if(pos.y<-img.height/2) {
         pos.y += height + img.height;
       }
       if(pos.y>height+img.height/2) {
         pos.y -= height + img.height;
       }
     }
     
     void Draw() {
       pushMatrix();
       pushStyle();
       imageMode(CENTER);
       translate(pos.x,pos.y);
       scale(0.2);
       colorMode(HSB,360,100,100,100);
       if(white) {
         tint(color(0,0,100));
       }else { 
         tint(lerpColor(pallette.KeyColor(),color(0,0,100),analyzer.getRightLevel()));
       }
       image(img,0,0);
       popStyle();
       popMatrix();
     }
  }
  
  class ParticleSystem {
    ArrayList<Particle> particles;
    ParticleSystem()
    {
      particles = new ArrayList<Particle>();
    }
    void Add(Particle p){
      particles.add(p);
    }
    
    void Update() {
      for (int i = 0; i < particles.size(); i++) {
        Particle p = particles.get(i);
        p.Update();
        if (!p.IsActive()) {
          particles.remove(i);
        }
      }
    }
    
    void Draw() {
      for (int i = 0; i < particles.size(); i++) {
        Particle p = particles.get(i);
        p.Draw();
        if (!p.IsActive()) {
          particles.remove(i);
        }
      }
    }
  }
  
  PShape dlogoShape;
  PImage dlogImage;
  PImage bubbleImage;
  PImage ikaImage;
  PImage manbouImage;
  PImage ebiImage;
  PImage huguImage;
  PImage sangoImage;
  PImage transitionImage = ikaImage;
  PShape shape;
  
  boolean white = false;
  PVector acc = new PVector(1.0,2.0);
  ParticleSystem particleSystem = new ParticleSystem();
  ParticleSystem bubbles = new ParticleSystem();
  
  Ani ani;
  float value = 0;
  
  boolean transition = false;
  Swimer() {
    dlogoShape = loadShape("sakana.svg");
    dlogImage = loadImage("sakana.png");
    bubbleImage = loadImage("bubble.png");
    ikaImage = loadImage("ika.png");
    manbouImage = loadImage("manbou.png");
    ebiImage = loadImage("ebi.png");
    huguImage = loadImage("hugu.png");
    sangoImage = loadImage("sango.png");
    transitionImage = ikaImage;
    for(int i = 0; i < 100; i++) {
      bubbles.Add(new Bubble(bubbleImage,0.1));
    }
  }
  
  void ChangeSituation(){
    transition  = true;
    value = 1.0;
    ani = Ani.to(this, 2.0, "value", 0.0, Ani.LINEAR);
    if((int)random(0,2) == 0) {
      transitionImage = ikaImage;
    } else {
      transitionImage = manbouImage;
    }
  }
  
  void Setup(){
    
  }
  
  float xoff = 0.01;
  void UpdateXoff()
  {
    xoff += 0.001;
    acc.x = (1-noise(xoff)*2)*10;
    acc.y = (1-noise(xoff + 100)*2)*10;
  }
  
  void UpdateIntroduction(){
    white = true;
    UpdateXoff();
    bubbles.Update();
  }
  
  void UpdateDevelopment(){
    UpdateXoff();
    bubbles.Update();
    if(analyzer.isKick()) {
      for(int i = 0; i < 3; i++) {
        particleSystem.Add(new Particle(dlogImage,analyzer.getLeftLevel()));
      }
    }
    particleSystem.Update();
  }
  
  void UpdateTurn(){
    white = true;
    UpdateXoff();
    bubbles.Update();
    if(analyzer.isKick()) {
      particleSystem.Add(new Particle(dlogImage,analyzer.getLeftLevel()));
    }
    particleSystem.Update();
  }
  
  void UpdateConclusion(){
    UpdateXoff();
    bubbles.Update();
    if(analyzer.isKick()) {
      particleSystem.Add(new Particle(huguImage,analyzer.getLeftLevel()));
    }
    if(analyzer.isHat()) {
      particleSystem.Add(new Particle(ebiImage,analyzer.getRightLevel()));
    }
    if(analyzer.isSnare()) {
      particleSystem.Add(new Particle(sangoImage,random(1,3.0)));
    }
    particleSystem.Update();  
  }
  
  void DrawTranstion()
  {
    if(ani != null && ani.isPlaying()) {
      pushMatrix();
      imageMode(CENTER);
      translate(width/2,0);
      scale(2);
      translate(0,(height+ikaImage.height)*value - ikaImage.height/2);
      image(transitionImage,0,0);
      popMatrix();
    }
    if(value < 0.5) transition = false;
  }
  
  void DrawPlayer(boolean colorflag) {
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    translate(width/2,height/2);
    PVector norm = acc.normalize();
    pushMatrix();
    translate(5,5);
    rotateZ(norm.heading()+PI);
    tint(0,128);
    image(dlogImage,0,0);
    popMatrix();
    rotateZ(norm.heading()+PI);
    if(colorflag) {
      tint(lerpColor(color(255),pallette.AccentColor(),analyzer.getLeftLevel()));
    }else {
      tint(255);
    }
    image(dlogImage,0,0);
    popMatrix();
    popStyle();
  }
  
  void DrawIntroduction(){
    background(0);
    bubbles.Draw();
    DrawPlayer(false);
    DrawTranstion();
  }
    
  void DrawDevelopment(){
    pushMatrix();
    pushStyle();
    background(0);
    bubbles.Draw();
    DrawPlayer(true);
    if(!transition)particleSystem.Draw();
    DrawTranstion();
    popMatrix();
    popStyle();
  }
  
  void DrawTurn(){
    white = true;
    pushMatrix();
    pushStyle();
    background(0);
    bubbles.Draw();
    DrawPlayer(false);
    scale(5);
    if(!transition)bubbles.Draw();
    popMatrix();
    popStyle();
    DrawTranstion();
  }
  
  void DrawConclusion(){
    pushMatrix();
    pushStyle();
    background(0);
    bubbles.Draw();
    DrawPlayer(true);
    if(!transition)particleSystem.Draw();
    DrawTranstion();
    popMatrix();
    popStyle(); 
  }
}