class Motion {
    Ani ani;
    float value = 0.0;
    color c = color(random(255),random(255),random(255));
    void Start()
    {
        ani = createAni();
    }
    
    boolean IsActive()
    {
      if(ani == null) return false;
      return ani.isPlaying();
    }
    
    Ani createAni() {
      return Ani.to(this, 1.0, "value", 1.0, Ani.QUINT_OUT,"onStart:OnStart, onEnd:OnEnd");
    }
    
    void Run() {
      Update();
      Draw();
    }
    
    void Update()
    {
      
    }
    
    void Draw()
    {
      fill(c);
      rect(0,0,width,value*height);
    }
    
    void OnStart()
    {
      
    }
    
    void OnEnd()
    {
      
    }
  }
  
class MotionSystem {
    ArrayList<Motion> motions;
    MotionSystem()
    {
       motions = new ArrayList<Motion>(); 
    }
    
    void AddMotion(Motion motion) {
      motions.add(motion);
    }

    void Run() {
      for (int i = 0; i < motions.size(); i++) {
        Motion p = motions.get(i);
        p.Run();
        if (!p.IsActive()) {
          motions.remove(i);
        }
      }
    }
  }