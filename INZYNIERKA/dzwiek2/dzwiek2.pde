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
int lang;

Minim minim;
AudioPlayer myAudio;
FFT fft;

int i =0;
float maxLast = 0;

AudioPlayer[] files;

float h = 0;
float step = 0;

int audioRange = 12;
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
int xSpacing = rectSize;

color bgColor = #333333;

String author =null;
String title = null;
String speaker = null;
 color genColor;
void setup()
{
    size(707, 1000);
  file = "cialo.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
   text =sad.getText();
  //TU!
  countHandStep(text.length);
  println(h);
  audioAmp = h;
 colorMode(HSB);
  author = "Bolesław Leśmian";
  title = "Jak niewiele ma znaków to ubogie ciało";
  speaker = "kobieta, 22 lata, studentka"; 
  String l = "PL";
  for (int i =0; i<l.length();i++){
  int ascii = l.charAt(i);
  lang+=ascii;
  }
  println("LANG"+lang);
  float temp = 255-(3*author.length());
  println("TEP" +temp);
   genColor =color(255-(2*author.length()), 255, 255-(3*title.length())); //<>//
  //col = color(0,score*0.5,score*0.8);
  stroke(0);
  background(lang, 80, 50);
  grid = new Grid(title, author, "Exo-Regular.ttf", "Exo-Thin.ttf");
 stroke(255);
  line(0,50,width,50);
   line(0,height-50,width,height-50);
    line(0,height-100,width,height-100);
    line(0,height-150,width,height-150);
    textSize(12);
    text(author,50, height-125);
    text(title,50, height-75);
    text(speaker,width/2+50, height-50);
    noStroke();

  stageMargin = (width - (rectSize * audioRange))/2;
  if (stageMargin < 0) {
    rectSize /= 1.75;
    stageMargin = (width - (rectSize * audioRange))/2;
    xSpacing = rectSize;
  }

  xStart = stageMargin;
  yStart = 100;
  //background(bgColor);
  // always start Minim first!
  minim = new Minim(this);

  files = new AudioPlayer[text.length-1];


  for (int i = 0; i < files.length; i++) {
    files[i] = minim.loadFile( "c" +(i+1) + ".wav");
  }


  files[0].play();
  String[] words = getLine(0);
  setMargin(words.length);



  setFFT(0);
}

void setFFT(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
  fft.forward(files[i].mix);
  drawViz(50+step*i);
}

void setMargin(int a) {
  audioRange = a;
  stageMargin = (width - (rectSize * audioRange))/2;
  if (stageMargin < 0) {
    rectSize /= 1.75;
    stageMargin = (width - (rectSize * audioRange))/2;
    xSpacing = rectSize;
  }
  xStart = stageMargin;
}
void draw()
{
  int num  = text.length;
  if (i<num-1) {
    if (!files[i].isPlaying()) {
      files[i=(i+1)].play();
      String[] words = getLine(i);
      setMargin(words.length);
    }

    setFFT(i);

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

void drawViz(float y) {
  float maxtempIndxAvg =0;
  for (int i = 0; i < audioRange; i++)
  {
    //stroke(0);
    noStroke();
    fill(genColor, 25);
    float tempIndxAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
    if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
    rect(xStart + (i* xSpacing), y+((step/4)*i), rectSize, tempIndxAvg);
    //line(i, height, i, height - fft.getBand(i)*20);
    audioIndexAmp += audioIndexStep;
   // println(y);
  }
  maxLast = maxtempIndxAvg;
}

void stop() {
  files[text.length-1].close();
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

void countHandStep(int wl){
float th = map(wl-5, wl, wl+30, (height - 350),(height -150)); 
println("TH" + th);
step = (((height-th)+300)/(wl-1));
println("STEP "+step);
h=(th/(wl));

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
