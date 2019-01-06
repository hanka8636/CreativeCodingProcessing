import ddf.minim.*;  //<>// //<>// //<>// //<>// //<>//
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

//deklaracja bibliotek do odczytywania muzyki i z Szybka Transformata Fouriera (FFT) 
Minim minim;
AudioPlayer myAudio;
FFT fft;

int i =0;
float maxLast = 0;

AudioPlayer[] files;

//wysokosc i krok, pozniej uzaleznione od liczby wersow w tekscie 
float h = 0;
float step = 0;

//liczba przedzialow i maksymalna moc dzwieku
int audioRange = 12;
int audioMax = 100;

//domyslna wartosc amplitudy (pozniej uzalezniana od liczby wersow w tekscie),  indeks amplitudy i jej krok 
float audioAmp = 40.0;
float audioIndex = 0.3;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

//szerokosc pojedynczego spektrum amplitudy, margines, poczatkowe wartosci rysowania
int rectSize = 50;
int stageMargin;
int stageWidth;
float xStart = 100;
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
  background(lang, 80, 50);
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
  // line(0,50,width,50);
  // line(0,height-50,width,height-50);
  //  line(0,height-100,width,height-100);
  //  line(0,height-150,width,height-150);
  textSize(12);
  text(author, 50, height-125);
  text(title, 50, height-75);
  text(speaker, width/2+50, height-50);
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
  countMaxMargin();
  
  fill(255, 50);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -xStart, height-100);
  textSize(12);
  text(author, width -xStart, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, xStart, height-100);

}

void setup()
{
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

  //odtwarzanie kolejnych utworow, jesli poprzedni sie skonczyl
  if (!files[i].isPlaying()) {
    files[i = (i + 1) % files.length].play();

    String[] words = getLine(i);
    setMargin(words.length);
  }
  setFFTandDraw(i);

  audioIndexAmp = audioIndex;
}

//Wlaczenie szybiej transformaty Fouriera (FFT) dla konkretnej probki dzwieku
void setFFTandDraw(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
  fft.forward(files[i].mix);
  drawViz(50+step*i);
}

//wysrodowanie grafiki wersa w zaleznosci od jego dlugosci
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

//rysowanie grafik wersa
void drawViz(float y) {
  float maxtempIndxAvg =0;
  for (int i = 0; i < audioRange; i++)
  {
    // stroke(bgColor);
    noStroke();
    fill(genColor, 25);
    float tempIndxAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
    if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
    rect(xStart + (i* xSpacing), y+((step/4)*i), rectSize, tempIndxAvg);
    audioIndexAmp += audioIndexStep;
    // println(y);
  }
  maxLast = maxtempIndxAvg;
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

//zakonczenie odtwarzania
void stop() {
  files[text.length].close();
  minim.stop();
  super.stop();
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
