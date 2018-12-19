import ddf.minim.*; //<>// //<>// //<>// //<>// //<>// //<>//
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


int audioRange = 5;
int audioMax = 100;

float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

float[] audioData = new float[audioRange];

int rectSize = 50;
int stageMargin;
int stageWidth = (audioRange*rectSize) + (stageMargin*2);
float xStart;
float yStart;

float y = yStart;
int xSpacing = rectSize+10;

color bgColor = #333333;

void setup()
{
  colorMode(HSB);
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
  grid = new Grid("Pożegnanie", "Tadeusz Boy-Żelański", "Exo-Regular.ttf", "Exo-Thin.ttf");
  text =sad.getText();

  size(707, 1000);

  xStart = stageMargin;
  yStart = 50;
  background(bgColor);
  // always start Minim first!
  minim = new Minim(this);
  files = new AudioPlayer[13];
  for (int i = 0; i < files.length; i++) {
    files[i] = minim.loadFile( "c" +(i+1) + ".wav");
  }
  setFFT(0);
  files[0].play();
  String[] words = getLine(0);
  setMargin(words.length);




}

void setFFT(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
  fft.forward(files[i].mix);
  
}

void setMargin(int a) {
  //audioRange = a;
  stageMargin = (width - (rectSize * a))/2;
  if (stageMargin < 0) {
    rectSize /= 1.75;
    stageMargin = (width - (rectSize * a))/2;
    xSpacing = rectSize;
  }
  xStart = stageMargin;
}
void draw()
{
    int[] a = getAllLinesLength();
  int num  = text.length;

  if (i<num-2) {
    if (!files[i].isPlaying()) {
      files[i=(i+1)].play();
      String[] words = getLine(i);
      a[i] = words.length;
      setMargin(words.length);
    }

    setFFT(i);
    audioDataUpdate();
    drawViz(50*(i+1), a[i]);

    audioIndexAmp = audioIndex;
  } else {
    if (!files[i-1].isPlaying()) {
      files[i].play();
      String[] words = getLine(i);
      setMargin(words.length);
    }

    setFFT(i);

    audioIndexAmp = audioIndex;
    stop();
  }
}

void drawViz(int y, int wl) {
  float maxtempIndxAvg =0;
  for (int i = 0; i < wl; i++)
  {
    //stroke(0);
    noStroke();
    

      noFill();
      strokeWeight(3);
      int fftAlpha = (int)map(audioData[(int)random(audioData.length-1)], 0, audioMax, 0, 255);
    
     stroke(255, 255, 255,fftAlpha/10); 
     //rectMode(CENTER);
    rect(xStart + (i* xSpacing), y, rectSize, rectSize);
    //line(i, height, i, height - fft.getBand(i)*20);
   
    println(y);
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

void stop() {
  files[12].close();
  minim.stop();
  super.stop();
}

void countDistY() {
  y += maxLast; 
  if (y>height)
    y =0;
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

String[] getLine(int i) {
  String[] words = splitTokens(text[i], " ,.!:-?");

  return words;
}

int[] getAllLinesLength(){
  int[] a = new int[text.length];
  for(int i = 0; i<text.length; i++){
  a[i] = getLine(i).length;
  }
return a;
}
