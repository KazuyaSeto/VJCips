class Swimer implements Drawer {
  class Particle {
     PVector pos;
     PImage img;
     float value = 1.0;
     float s = 1;
     Ani ani;
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
       tint(lerpColor(pallette.KeyColor(),color(0,0,100),value));
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
  PShape shape;
  PVector acc = new PVector(1.0,2.0);
  ParticleSystem particleSystem = new ParticleSystem();
  Swimer() {
    dlogoShape = loadShape("sakana.svg");
    dlogImage = loadImage("sakana.png");
  }
  
  void ChangeSituation(){

  }
  
  void Setup(){

  }
  float xoff = 0.01;
  void UpdateIntroduction(){
    xoff += 0.001;
    acc.x = (1-noise(xoff)*2)*10;
    acc.y = (1-noise(xoff + 100)*2)*10;
    if(analyzer.isKick()) {
      for(int i = 0; i < 3; i++) {
        particleSystem.Add(new Particle(dlogImage,analyzer.getLeftLevel()));
      }
    }
    particleSystem.Update();
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
    background(0);
    particleSystem.Draw();
    imageMode(CENTER);
    translate(width/2,height/2);
    rotateZ(PI*sin(PI*xoff*10)/30);
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