void drawAudioParam()
{
  pushStyle();
  pushMatrix();
  colorMode(RGB,255,255,255,255);
  translate(0,200);
  textSize(10);
  text("- Audio -",10,10);
  drawDramPattern();
  drawLevel();
  drawAvg();
  drawVolume();
  popMatrix();
  popStyle();
}

void drawDramPattern()
{
  pushMatrix();
  pushStyle();
  textMode(CENTER);
  noStroke();
  textAlign(CENTER);
  textSize(10);
  translate(20,20);
  int size = 60;
  int ellipseSize = 7;
  fill(255,255,0,255);
  text("hat",0,15);
  if(analyzer.isHat()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  translate(0,25);
  fill(0,255,255,255); 
  text("snare",0,15);
  if(analyzer.isSnare()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  translate(0,25);
  fill(255,0,255,255);
  text("kick",0,15);
  if(analyzer.isKick()){
    ellipse(0,0,ellipseSize,ellipseSize);
  }
  popStyle();
  popMatrix();
}

void drawLevel() {
  pushMatrix();
  pushStyle();
  stroke(0);

  int rectWidth = 4;
  int space = 2;
  int size = 20;
  int amp = 5;
  translate(40,88);
  fill(0,255,0);
  for(int i = 0; i < size; i++){
    if(i>=size-3)fill(255,0,0);
    if(analyzer.getRightLevel()*amp > i){
      //rect(0,space/2 +(i * space),space,rectHeight);
      rect(0,-space/2 -(i * space),rectWidth,space);
    }
    if(analyzer.getLeftLevel()*amp > i){
      //rect(rectHeight,space/2 + (i * space),space,rectHeight);
      rect(rectWidth,-space/2 -(i * space),rectWidth,space);
    }
  }
  popStyle();
  popMatrix();
}

void drawAvg() {
  int space = 2;
  int size = 20;
  pushMatrix();
  pushStyle();
  stroke(0);
  translate(52,90);
  fill(255,0,0,255);
  for(int i = 0; i < analyzer.avgSize(); i++) {
    for(int j = 0; j < size; j++) {
      if(analyzer.getAvg(i)*size > size-j-1)rect(i*space,space*(j-size),space,space);
    }
  }
  popStyle();
  popMatrix();
}

void drawVolume()
{
  pushMatrix();
  pushStyle();
  translate(40,30);
  //fill(random(0,10),0,0);
  //noStroke();
  stroke(255);
  noFill();
  int size = width/4;
  int add = analyzer.bufferSize()/size;
  int amp = 100;
  float w = 1;
  
  beginShape();
  vertex(0,-analyzer.getRight(0)*amp);
  for(int i = 1; i < size; i++) {
    vertex(i*w,-analyzer.getRight(i)*amp);
  }
  endShape();
  
  translate(0,height/16);
  beginShape();
  vertex(0,-analyzer.getLeft(0)*amp);
  for(int i = 1; i < size; i++) {
    vertex(i*w,-analyzer.getLeft(i)*amp);
  }
  endShape();

  popStyle();
  popMatrix();
}

void drawSpectram()
{
  pushMatrix();
  pushStyle();
  stroke(255);
  fill(255);
  int size = width/4;
  int offset = analyzer.specSize()/size;
  int amp = 1;
  int w = 1;
  beginShape();
  vertex(0,0);
  for(int i = 0; i < size; i++) {
    vertex(i,-analyzer.getBand(i*offset)*amp);
  }
  vertex(0,0);
  endShape(CLOSE);
  popStyle();
  popMatrix();
}