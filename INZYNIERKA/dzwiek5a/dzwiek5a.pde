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

float prevX =0;
float prevY = 0;

//deklaracja bibliotek do odczytywania muzyki i z Szybka Transformata Fouriera (FFT)
Minim minim;
FFT fft;

int i =0;
float maxLast = 0;

AudioPlayer[] files;

//wysokosc i krok, pozniej uzaleznione od liczby wersow w tekscie 
float h = 0;
float step = 0;

//liczba przedzialow i maksymalna moc dzwieku
int audioRange = 5;
int audioMax = 100;

//domyslna wartosc amplitudy (pozniej uzalezniana od liczby wersow w tekscie),  indeks amplitudy i jej krok 
float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

//tablica na dane muzyki
float[] audioData = new float[audioRange];

//szerokosc pojedynczego spektrum amplitudy, margines, poczatkowe wartosci rysowania
int rectSize = 50;
int stageMargin;
int stageWidth = (audioRange*rectSize) + (stageMargin*2);
float xStart;
float yStart;

//maksymalna liczba slow w wersie, sluzaca do ustalenia marginesow dla tekstu
int maxMargin; 

//y - wysokosc na ktorej powinien sie zaczynac wers, xSpacing - odstepy miedzy zakresami w X
float y = yStart;
int xSpacing = rectSize;

//domyslna wartosc koloru tla, pozniej definniowana w zaleznosci od jezyka oryginalu
color bgColor = #333333;
//zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
color genColor;
// zmienne na ciagi znakow bedace autorem, tytulem, mowca
String author =null;
String title = null;
String speaker = null;

//przypisanie wartosci autorowi, tytulowi i mowcy 
void setAuthorTitleSpeaker() {
  author = "Bolesław Leśmian";
  title = " Jak niewiele ma znaków to ubogie ciało";
  speaker = "kobieta, 22 lata, studentka";
}

//obliczenie i przypisanie wartosci koloru tla w zaleznosci od jezyka oryginalu
void setBackgroundColorByLanguage(String l) {
  for (int i =0; i<l.length(); i++) {
    int ascii = l.charAt(i);
    lang+=ascii;
  }
  bgColor =color(lang, 80, 50);
  background(bgColor);
}

//obliczenie i przypisanie wartosci koloru grafiki gdzie autor odpowiada za Hue (odcien), a tytul za Brightness (jasnosc)
void setDrawingColorByAuthorAndTitle() {
  float temp = 255-(3*author.length());
  println("TEP" +temp);
  genColor =color(255-(2*author.length()), 255, 255-(3*title.length()));
}

//pozniej do usuniecia
void drawTestMargins() {
  stroke(255);
   line(0,50,width,50);
  // line(0,height-50,width,height-50);
  //  line(0,height-100,width,height-100);
    line(0,height-150,width,height-150);
 // textSize(12);
  //text(author, 50, height-125);
 // text(title, 50, height-75);
 // text(speaker, width/2+50, height-50);
  noStroke();
}

//wczytanie plikow dzwiekowych z wersami
void loadFiles() {
  files = new AudioPlayer[text.length];

  for (int i = 0; i < files.length; i++) {
    files[i] = minim.loadFile( "c" +(i+1) + ".wav");
  }
}

//podstawowe operacje by tekst byl przydatny
void setAllConectedWithText() {
  file = "cialo.txt";
  sad = new SplitAndDict(file);
  // sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  //score = sp.countPoints(textLine);
  text =sad.getText();
}

void drawTexts(){
  //drawTestMargins();
  
  
  fill(255, 50);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -maxX, height-100);
  textSize(12);
  text(author, width -maxX, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, maxX, height-100);

}

void setup()
{
  frameRate(5);
    size(707, 1000);
  colorMode(HSB);
  setAllConectedWithText();

  countHAmplitudeStep(text.length);
  println(h);

  setAuthorTitleSpeaker();

  //obliczanie wartosci jezyka jako suma kodow ASCII
  setBackgroundColorByLanguage("PL");
  println("LANG"+lang);

  setDrawingColorByAuthorAndTitle();
  //col = color(0,score*0.5,score*0.8);
  stroke(0);

  grid = new Grid(title, author, "Exo-Regular.ttf", "Exo-Thin.ttf");
//drawTestMargins();
countMaxMargin();
maxX=xStart;
drawTexts();

  // always start Minim first!
  minim = new Minim(this);

  loadFiles();
  //odtworzenie i wykonanie operacji na pierwszym pliku dzwiekowym
  files[0].play();
  String[] words = getLine(0);
  setMargin(words.length);

  setFFTandDraw(0);

}

void draw()
{
  //background(bgColor);
  int num  = text.length;

    if (!files[i].isPlaying()) {
      files[i=(i+1) % files.length].play();
      String[] words = getLine(i);
      setMargin(words.length);
    }
//drawTestMargins();
    setFFTandDraw(i);
//drawTexts();
    audioIndexAmp = audioIndex;
  
}

void setFFTandDraw(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
  fft.forward(files[i].mix);
  drawViz((step)*i+75);
  
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
void countMaxMargin() {
  for (int i=0; i<text.length; i++) {
    String[] words = getLine(i);
    if (maxMargin< words.length)
      maxMargin=words.length;
  }

  setMargin(maxMargin);
}

float[] calcTempAvg(){
  float tempIndxAvg[] = new float[audioRange];
 for (int i = 0; i < audioRange; i++)
  {
   
   // noStroke();
   // fill(255-(y*2), 255, 255, 25);
     tempIndxAvg[i] = (fft.getAvg(i) * audioAmp) * audioIndexAmp;}
     return tempIndxAvg;
}


void drawViz(float y) {
  float[] tempIndxAvg =calcTempAvg();
  for (int i = 0; i < audioRange; i++)
  {
    
    float temp = tempIndxAvg[(int)random(audioRange-1)];
   println("TEMP "+temp); //<>// //<>//
   // noStroke();
   // fill(255-(y*2), 255, 255, 25);
   // if (maxtempIndxAvg < tempIndxAvg)
     // maxtempIndxAvg = tempIndxAvg;
     // rect(xStart + (i* xSpacing), y, rectSize, tempIndxAvg);
       stroke(genColor, 25+temp*20);
     // line(xStart + (i* xSpacing), y, xStart + (i* xSpacing)+rectSize, tempIndxAvg+y);
     // line(prevX, prevY, xStart + (i* xSpacing), y+(tempIndxAvg));
      
      float ran =random(50,25);
pushMatrix();
translate(xStart + (i* xSpacing)+rectSize/2,y);// bring zero point to the center 

//stroke(0);
noFill();
 ran =random((step)-15,(step)+5);
// println("temp+rectSize"+(rectSize+(temp)*ran));
line(0,0, sin(radians(rectSize+(temp)*ran))*ran,cos(radians(rectSize+(temp)*ran))*ran); //<>//
ellipse (sin(radians(rectSize+(temp)*ran))*ran,cos(radians(rectSize+(temp)*ran))*ran,5,5); //<>//
//println("SIn"+sin(radians(rectSize+(temp)*ran)));
popMatrix();      
   // line(prevX, prevY, xStart + (i* xSpacing), y+(tempIndxAvg));
  //  line((i+1)*20, prevY, (i+2)*40, prevY + fft.getBand(i)*20);
    audioIndexAmp += audioIndexStep;
   // prevX +=xStart + ((i+20)* xSpacing);
   prevX =xStart + (i* xSpacing);
    prevY += y+(temp);
    
    noStroke();
   // fill(bgColor);
  //  rect(0,height-150, width,height);
    noFill();
    println(y);
 }
 // maxLast = maxtempIndxAvg;
}
//liczenie wysokosci slupka, amplitudy i kroku miedzy wersami
void countHAmplitudeStep(int wl) {
  float th = map(wl-5, wl, wl+30, (height - 350), (height -150)); 
  println("TH" + th);
  step = (((height-th)+350)/(wl-1));
  println("STEP "+step);
  h=(th/(wl));
  audioAmp = h;
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
