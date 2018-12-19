import ddf.minim.*; //<>// //<>// //<>//
import ddf.minim.analysis.*;
import hype.*; 
import hype.extended.layout.HGridLayout;

Minim minim;
AudioPlayer myAudio;
FFT fft;

int audioRange = 11;
int audioMax = 100;
float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

float[] audioData = new float[audioRange];

HDrawablePool pool;
int poolMax = 25;

color[] palette = {#FF3300, #FF620C, #ff9519, #0095A8, #FFC725, #F8EF33, #FFFF33, #CCEA4A, #9AD561, #64BE7A, #2EA893, #453FF6};

void setup() {
  size(707, 1000);
  H.init(this).background(#000000).autoClear(false);

  minim = new Minim(this);
  myAudio = minim.loadFile("cialo.wav");
  myAudio.loop();

  fft = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);

  pool = new HDrawablePool(poolMax);
  pool.autoAddToStage()
    .add(new HRect(100).rounding(10))
    .layout (new HGridLayout().startX(50).startY(height/2).spacingX(25).cols(poolMax))
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      int ranIndex = (int)random(audioRange);
      HDrawable d = (HDrawable) obj;
      d.
        noStroke()
        .fill(palette[ranIndex], 15)
        .anchorAt(H.CENTER)
        .rotation(45)
        .extras(new HBundle().num("i", ranIndex));
    }
  }
  ).requestAll();
  //background(0);
}

void draw() {
  
  fft.forward(myAudio.mix);
  audioDataUpdate();
//  background(0);
  H.drawStage();

  for (HDrawable d : pool) {
    
    HBundle tempExtra = d.extras();
    int i = (int)tempExtra.num("i");
    d.alpha(0);
    int fftAlpha = (int)map(audioData[i], 0, audioMax, 0, 255);
    d.alpha(fftAlpha);
  }
}

void audioDataUpdate(){
for(int i =0; i< audioRange; ++i){
float tempIndexAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
float tempIndexCon = constrain(tempIndexAvg, 0, audioMax);
audioData[i] = tempIndexCon;
audioIndexAmp += audioIndexStep;
}
audioIndexAmp = audioIndex;
}

void stop(){
  myAudio.close();
  minim.stop();
  super.stop();

}
