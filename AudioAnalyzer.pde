import ddf.minim.analysis.*;
import ddf.minim.*;

public class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioInput source;
  
  BeatListener(BeatDetect beat, AudioInput source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

public class AudioAnalyzer {
  Minim        minim;
  AudioInput   in;
  BeatListener beatListener;
  BeatDetect   beat;
  FFT          fft;
  int          AVG_SIZE = 128;
  FloatList    volumes;
  float amp = 1.0;
  
  // setup
  AudioAnalyzer(PApplet pApplet)
  {
    minim = new Minim(pApplet);
    volumes = new FloatList();
    in = minim.getLineIn();
    fft = new FFT(in.bufferSize(), in.sampleRate());
    
    beat = new BeatDetect(in.bufferSize(), in.sampleRate());
    beat.setSensitivity(1);
    beatListener = new BeatListener(beat, in); 
    //fft.linAverages(AVG_SIZE);
    //fft.logAverages( 22, 9 );
    fft.logAverages( 22, 3 );
    
    for( int index = 0; index <  fft.avgSize(); ++index ) {
      volumes.append(0);
    }

  }
  
  public void forward(float levelAmp) {
    amp = 1/levelAmp;
    fft.forward(in.mix);
    for( int index = 0; index < volumes.size(); ++index ) {
      volumes.set(index, (float)((volumes.get(index)*4+fft.getAvg(index))/5));
    }
  }
  
  public int bufferSize() {
    return in.bufferSize();
  }
  
  public float getLeft(int index) {
    return in.left.get(index); 
  }
  
  public float getRight(int index) {
    return in.right.get(index);
  }
  
  public float getLeftLevel() {
    return map(in.left.level(),0,amp,0,1); 
  }
  
  public float getRightLevel() {
    return map(in.right.level(),0,amp,0,1); 
  }
  
  // get spectrum size
  public int specSize() {
    return fft.specSize();
  }
  
  // get spectrum
  public float getBand(int index) {
    return fft.getBand(index);
  }
  
  // get average size
  public int avgSize () {
    return fft.avgSize();
  }
  
  // get avarage
  public float getAvg(int index) {
    return fft.getAvg(index)/30;
    //return (fft.getAvg(index)*2+volumes.get(index)*3)/5/30;
  }
  
  public boolean isKick() {
    return beat.isKick();
  }
  
  public boolean isSnare() {
    return beat.isSnare(); 
  }
  
  public boolean isHat() {
    return beat.isHat();
  }
  
  public boolean isOnset() {
    return beat.isOnset();
  }

}