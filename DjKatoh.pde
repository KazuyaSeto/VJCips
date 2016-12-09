class DJKatoh implements Drawer {
  PShape dlogoShape;
  PImage katohImage;
  PImage houseBgImage;
  PImage morningImage;
  PImage afterNoonImage;
  PImage lunchImage;
  PImage nightBgImage;
  PImage heartImage;
  PImage[] ramenImages;
  PImage[] sigotoImages;
  Object[] objs = new Object[2];
  class Object {
    PVector pos = new PVector(random(width),random(height));
    PVector acc = new PVector(random(width),random(height));
    PImage img;

    void Init(PImage _img, PVector _acc) {
        img = _img;
        acc = _acc;
        //pos = new PVector(random(width),random(height));
    }

    void Update() {
        pos.add(acc);
        if(img==null) return;
        if(pos.x + img.width/2 < 0) {
          pos.x = pos.x + width + img.width/2;
          img = getImage();
          pos.y = random(height);
        }
        if(pos.x - img.width/2 > width) {
          pos.x = pos.x - width - img.width/2;
          img = getImage();
          pos.y = random(height);
        }
        if(pos.y + img.height/2 < 0) {
          pos.y = pos.y + height + img.height/2;
          img = getImage();
          pos.x = random(width);
        }
        if(pos.y - img.height/2 > height) {
          pos.y = pos.y - height - img.height/2;
          img = getImage();
          pos.x = random(width);
        }
    }

    void Draw() {
        pushMatrix();
        pushStyle();
        imageMode(CENTER);
        translate(pos.x, pos.y);
        scale(0.8);
        if(img != null)image(img,0,0);
        popStyle();
        popMatrix();
    }
  }
  float scroll = 0;
  DJKatoh() {
    katohImage = loadImage("katoh.png");
    houseBgImage = loadImage("bg_house.jpg");
    morningImage = loadImage("bg_outside_jutaku.jpg");
    lunchImage = loadImage("tatemono_raamen.png");
    afterNoonImage = loadImage("bg_outside_buildings.jpg");
    nightBgImage = loadImage("bg_outside_jutaku_yoru.jpg");
    ramenImages = new PImage[5];
    ramenImages[0] = loadImage("food_kaedama.png");
    ramenImages[1] = loadImage("ramen_tonkotsu.png");
    ramenImages[2] = loadImage("ramen_tenin.png");
    ramenImages[3] = loadImage("ramen_moyashi.png");
    ramenImages[4] = loadImage("ramen_syouyu.png");
    sigotoImages = new PImage[3];
    sigotoImages[0] = loadImage("document_kuronuri_kimitsu.png");
    sigotoImages[1] = loadImage("envelop_paper.png");
    sigotoImages[2] = loadImage("music_record_disc.png");
    heartImage = loadImage("valentinesday_heart.png");
    for(int i = 0; i < objs.length; i++) {
        objs[i] = new Object();
    } 
  }
  
  void ChangeSituation(){
    if(situation == Situation.Development) {
      for(int i = 0; i < objs.length; i++) {
          objs[i].Init(getImage(), new PVector(random(2,4),0));
      }
    }
    
    if(situation == Situation.Turn)
    {
      for(int i = 0; i < objs.length; i++) {
          objs[i].Init(getImage(), new PVector(random(2,4),0));
      }
    }
    if(situation == Situation.Conclusion)
    {
      for(int i = 0; i < objs.length; i++) {
        objs[i].Init(getImage(), new PVector(0, random(-4,-2)));
      }
    }
  }
  
  PImage getImage() {
    if(situation == Situation.Development) {
      return sigotoImages[(int)random(sigotoImages.length)];
    }
    
    if(situation == Situation.Turn)
    {
      return ramenImages[(int)random(ramenImages.length)];
    }
    if(situation == Situation.Conclusion)
    {
      return heartImage;
    }
    return null;
  }
  
  void Setup(){

  }
  
  void DrawScroolBg(PImage img,int add) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2,height/2,0);
    float s = height/(float)img.height;
    scale(s);
    scroll += add;
    if(-scroll > (float)img.width*1.5) {
      scroll += (float)img.width*2;
    } else if(scroll > (float)img.width*1.5){
      scroll -= (float)img.width*2;
    }
    translate(scroll,0);
    translate(-img.width-img.width/2,0);
    for(int i = 0; i < 4; i++) {
      scale(-1,1);
      image(img,0,0);
      int t = (i%2 == 0) ? -1 : 1;
      translate(t*img.width,0);
    }
    popMatrix();
  }
  
  void UpdateIntroduction(){
    
  }
  
  void UpdateDevelopment(){
    UpdateObj();
  }
  
  void UpdateTurn(){
    UpdateObj();
  }
  
  void UpdateConclusion(){
    UpdateObj();
  }
  
  void DrawIntroduction(){
    DrawCommon(houseBgImage,5);
  }
    
  void DrawDevelopment(){
     DrawCommon(afterNoonImage,10);
     DrawObj();
  }
  
  void DrawTurn(){
    DrawCommon(lunchImage,10);
    DrawObj();
  }
  
  void DrawConclusion(){
    DrawCommon(nightBgImage,-30);
    DrawObj();
  }

  void UpdateObj()
  {
      for(int i = 0; i < objs.length; i++) {
        objs[i].Update();
      }
  }
  
  void DrawObj()
  {
      for(int i = 0; i < objs.length; i++) {
        objs[i].Draw();
      }
  }
  
  void DrawCommon(PImage bg, int speed)
  {
    pushMatrix();
    pushStyle();
    background(0);
    DrawScroolBg(bg,speed);
    shapeMode(CENTER);
    imageMode(CENTER);
    translate(width/2,height-katohImage.height/2.2);
    if(speed < 0) scale(-1,1);
    image(katohImage,0,sin(scroll/(float)speed)*10);
    popMatrix();
    popStyle();
  }
}