import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer myAudio;
FFT fft;

int i =0;
float maxLast = 0;

AudioPlayer[] files;
int[] nums = {7,6,9,5,4,12,7,5,8,10,4,7,9,6};

int audioRange = 12;
int audioMax = 100;

float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

int rectSize = 50;
int stageMargin;
int stageWidth = (audioRange*rectSize) + (stageMargin*2);
float xStart;
float yStart;

float y = yStart;
int xSpacing = rectSize;

color bgColor = #333333;

void setup()
{
  
  size(707, 1000);
  stageMargin = (width - (rectSize * audioRange))/2;
  if (stageMargin < 0){
    rectSize /= 1.75;
  stageMargin = (width - (rectSize * audioRange))/2;
  xSpacing = rectSize;
  }
  
  xStart = stageMargin;
 yStart = 50;
 background(bgColor);
  // always start Minim first!
  minim = new Minim(this);
  
  files = new AudioPlayer[13];
  //nums = new int[13];
  
  

  // Load 5 soundfiles from a folder in a for loop. By naming 
  // the files 1., 2., 3., [...], n.aif it is easy to iterate 
  // through the folder and load all files in one line of code.
  for (int i = 0; i < files.length; i++) {
    files[i] = minim.loadFile( "c" +(i+1) + ".wav");
  }
  
 
  // specify 512 for the length of the sample buffers
  // the default buffer size is 1024
  myAudio = minim.loadFile("cialo.wav");
  //myAudio.play();
 
  // an FFT needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
  fft = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
}
 
void draw()
{
     if (!files[i].isPlaying()) {
    files[i=(i+1) % 13].play();
    audioRange = nums[i];
      stageMargin = (width - (rectSize * audioRange))/2;
  if (stageMargin < 0){
    rectSize /= 1.75;
  stageMargin = (width - (rectSize * audioRange))/2;
  xSpacing = rectSize;
  }
  
  xStart = stageMargin;
    }

 fft = new FFT(myAudio.bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
   fft.forward(files[i].mix);
      drawViz(); //<>//
  //<>//
  //y=yStart;
  
  // first perform a forward fft on one of myAudio's buffers
  // I'm using the mix buffer
  //  but you can use any one you like
  fft.forward(myAudio.mix);
  
 

  // draw the spectrum as a series of vertical lines
  // I multiple the value of getBand by 4 
  // so that we can see the lines better
  //for(int i = 0; i < fft.specSize(); i++)
//drawViz();
 audioIndexAmp = audioIndex;
 /* stroke(255);
  // I draw the waveform by connecting 
  // neighbor values with a line. I multiply 
  // each of the values by 50 
  // because the values in the buffers are normalized
  // this means that they have values between -1 and 1. 
  // If we don't scale them up our waveform 
  // will look more or less like a straight line.
  for(int i = 0; i < myAudio.left.size() - 1; i++)
  {
    line(i, 50 + myAudio.left.get(i)*50, i+1, 50 + myAudio.left.get(i+1)*50);
    line(i, 150 + myAudio.right.get(i)*50, i+1, 150 + myAudio.right.get(i+1)*50);
    
  }
  */
   countDistY();
}

void drawViz(){
  float maxtempIndxAvg =0;
  for(int i = 0; i < audioRange; i++)
  {
      //stroke(0);
      noStroke();
      fill(255-(y*5), 255, 255,50);
      float tempIndxAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
      if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
      rect(xStart + (i* xSpacing), y, rectSize, tempIndxAvg);
    //line(i, height, i, height - fft.getBand(i)*20);
    audioIndexAmp += audioIndexStep;
    println(y);
  }
  maxLast = maxtempIndxAvg; //<>//
}

void stop(){
myAudio.close();
minim.stop();
super.stop();

}

void countDistY(){
 y += maxLast;  //<>//
 if (y>height)
 y =0;

}
