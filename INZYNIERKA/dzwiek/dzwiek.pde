import ddf.minim.*;
import ddf.minim.analysis.*;
 
 //połączenia tego samego słowa w kolejnych wersach
float maxX = 0;
float lastYb =0;
float lastYe =0;
float aplph =0;
 float unit =0;
int a = 0;
String[] text;
String textLine;
SplitAndDict sad;
ScrabblePoints sp;
String file;
int score;
IntDict totalPointsForLetter;
color col =0;
Grid grid;

 
Minim minim;
AudioPlayer myAudio;
FFT fft;

int i =0;
float maxLast = 0;

AudioPlayer[] files;
int[] nums = {7,6,9,5,4,12,7,5,8,10,4,7,9,6};

int audioRange = 4;
int audioMax = 100;

float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

int rectSize = 50;
int stageMargin;
int stageWidth = (audioRange*rectSize) + (stageMargin*2);
float xStart;
float yStart =50;

float y = yStart;
int xSpacing = rectSize;

color bgColor = #333333;

void setup()
{
  file = "cialo.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  //col = color(0,score*0.5,score*0.8);
  stroke(0);
  background(0, 0, col);
  grid = new Grid("Pożegnanie", "Tadeusz Boy-Żelański","Exo-Regular.ttf", "Exo-Thin.ttf");
  text =sad.getText();
  
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
    files[i=(i+1) % text.length].play();
    String[] words = getLine(i);
    audioRange = words.length;
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
      fill(255-(y*2), 255, 255,25);
      float tempIndxAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
      if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
    if (i%2==0)  
      rect(xStart + (noise(40)*i* xSpacing), y, rectSize, tempIndxAvg);
      else
      rect(width-(xStart + (noise(40)*i* xSpacing)), y, rectSize, tempIndxAvg);
    //line(i, height, i, height - fft.getBand(i)*20);
    audioIndexAmp += audioIndexStep;
    println(tempIndxAvg);
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
 if (y>height-150)
 y =50;

}


//Metoda liczy ile w tekście jest punktów za daną literę
void countTotalPointsForLetters() {
  IntDict sadD = sad.getDictLeters();
  totalPointsForLetter=sp.getDict();
  String[] as = sp.getKeys();
  for (int i=0; i<totalPointsForLetter.size(); i++) {
    String letter = as[i];
    if (sadD.hasKey(letter) == true)
    {
      totalPointsForLetter.set(letter, totalPointsForLetter.get(letter)*sadD.get(letter));
    }
    //  println(totalPointsForLetter);
  }
}

void keyPressed() {
  if (key == ' ') {
    a++;
    println("SPACJA");
   // grid.drawDistortedTitle(maxX);
  // grid.drawInBlankSpace(lastYb, lastYe, aplph);
  //  grid.drawAuthorFont();
    saveFrame("#####.png");
    // noLoop();
    // drawVerses();
  }
}

float countWLc(int wl) {
  float calc = 0;
  if (wl<10) {
    calc =( 10 - wl);
  }
  if ((wl>=10)&&(wl<20)) {
    calc = (20 - wl) *1.2;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=20)&&(wl<30)) {
    calc = (30 - wl) *0.5;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=30)&&(wl<40)) {
    calc = (40 - wl) *1.5;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=40)&&(wl<50)) {
    calc = (50 - wl) *0.35;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=50)&&(wl<60)) {
    calc = (60 - wl) *0.3;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=60)&&(wl<70)) {
    calc = (70 - wl) *0.65;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=70)&&(wl<80)) {
    calc = (80 - wl) *0.4;
    // calc = 50*(1/(wl - 8));
  }
  return calc;
}


void mousePressed() {
  if (mouseButton == LEFT)
    grid.drawTitleM();
  if (mouseButton == RIGHT)
    grid.drawAuthorM();
}

String[] getLine(int i){
    String[] words = splitTokens(text[i], " ,.!:-?");

return words;
}
