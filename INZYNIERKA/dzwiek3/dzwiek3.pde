import ddf.minim.*; //<>// //<>// //<>// //<>// //<>//
import ddf.minim.analysis.*;
float letterWidth=0;
float letterWidths=0;
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
int audioRange = 13;
int audioMax = 100;

//domyslna wartosc amplitudy (pozniej uzalezniana od liczby wersow w tekscie),  indeks amplitudy i jej krok 
float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

//tablica na dane muzyki
float[] audioData = new float[audioRange];

//szerokosc pojedynczego spektrum amplitudy, margines, poczatkowe wartosci rysowania
float rectSize = letterWidth;
float stageMargin;
float stageWidth = (audioRange*rectSize) + (stageMargin*2);
float xStart;
float yStart =100;

//maksymalna liczba slow w wersie, sluzaca do ustalenia marginesow dla tekstu
int maxMargin; 

//y - wysokosc na ktorej powinien sie zaczynac wers, xSpacing - odstepy miedzy zakresami w X
float y = yStart;
float xSpacing = rectSize;

//domyslna wartosc koloru tla, pozniej definniowana w zaleznosci od jezyka oryginalu
color bgColor = #333333;
//zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
color genColor;
// zmienne na ciagi znakow bedace autorem, tytulem, mowca
String author =null;
String title = null;
String speaker = null;

float maxW = 0; 
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
  countMaxMargin();
  
  fill(255, 50);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -50, height-100);
  textSize(12);
  text(author, width -50, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, 50, height-100);

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
drawTestMargins();

;
countLetterWidth(sad.getLengthOfTheLongestWords());
drawTexts();

  // always start Minim first!
  minim = new Minim(this);

  loadFiles();
  //odtworzenie i wykonanie operacji na pierwszym pliku dzwiekowym
  files[0].play();
  String[] words = getLine(0);
    int sum = 0;
    for(int j=0; j<words.length; j++){

   sum+=words[j].length();
    
    }
    
  
  setMargin(sum);

  setFFTandDraw(0);
//drawViz(65+step*(i), words.length);
}

void draw()
{
  //background(0);
    //int[] a = getAllLinesLength();

    if (!files[i].isPlaying()) {
      files[i=(i+1) % files.length].play();
      String[] words = getLine(i);
      // drawOnlyTextPicture(words);
     // a[i] = words.length;
      setMargin(words.length);
    }
    String[] words = getLine(i);
     //  drawOnlyTextPicture(words);

    setFFTandDraw(i); //<>//
    audioDataUpdate();
    drawViz(words); //<>//

    audioIndexAmp = audioIndex;
   
 
}


void setFFTandDraw(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate()); //<>//
  fft.linAverages(audioRange); //<>//
  fft.getAvg(audioRange-1);
  fft.window(FFT.GAUSS); //<>//
  fft.forward(files[i].mix); //<>//
  
}

void setMargin(int a) {
  //audioRange = a;
  stageMargin = (width - (letterWidth * a))/2;
  if (stageMargin < 0) {
    letterWidth /= 1.75;
    stageMargin = (width - (letterWidth * a))/2;
    xSpacing = rectSize;
  }
  xStart = stageMargin;
}

void countMaxMargin() {
  for (int i=0; i<text.length; i++) {
    String[] words = getLine(i);
       int sum = 0;
    for(int j=0; j<words.length; j++){

   sum+=words[j].length();
    
    }
    if (maxMargin< sum)
      maxMargin=sum;
  }

  setMargin(maxMargin);
}

void countMargin(String[] words) {
       int sum = 0;
    for(int j=0; j<words.length; j++){

   sum+=words[j].length();
    
    }

  setMargin(sum);
}

void drawOnlyTextPicture(String[] wordsInLine){
  countMargin(wordsInLine);
  float prevX=xStart;
  
  noFill();
  stroke(255);
  strokeWeight(2);
for (int q=0; q<wordsInLine.length; q++) {
  int sum =0;
    float sf = wordsInLine[q].length()*letterWidth;
    sum+=wordsInLine[q].length();
ellipseMode(CORNER); 

ellipse(prevX,50+(i*step), sf, step);
prevX+=wordsInLine[q].length()*letterWidth;
}

prevX=50;
  }

void countLetterWidth(int longest) {
   letterWidths =width-100;
   letterWidth = letterWidths/longest; //to daje nam budulec do każdego słowa - wartość jednej literki to letterWidth 
  // letterWidth=letterWidth/2;
 //  startDrawingPosition = 
  
  }

void drawViz(String[] wordsInLine) {
 countMargin(wordsInLine);
  float prevX=xStart;
  
noFill();
      strokeWeight(3);
      int fftAlpha = 0;
    
     
for (int q=0; q<wordsInLine.length; q++) {
  int sum =0;
  int audRan = (int)random(audioData.length-1);
  audioDataUpdate();
  fftAlpha=(int)audioData[audRan]*10; //<>//
  stroke(genColor-5*i,fftAlpha); 
    float sf = wordsInLine[q].length()*letterWidth;
    sum+=wordsInLine[q].length();
ellipseMode(CORNER); 
float ran =0;//random(25);
ellipse(prevX+ran,50+(i*step), sf-ran, step);
prevX+=wordsInLine[q].length()*letterWidth;
}

  
}
//}

 //vl - dlugosc najdluzszego wersu
  //word - dlugosc najdluzszego slowa w tekscie
  //words - liczba slow w najdluzszym wersie w tekscie
  void defineMaxBrickLength(int vl, int words){
  float maxV = map(vl,0, width-200,0, width*2);
   maxW = maxV/words;
  }

float defineBrickLength(int word){
  float brickLength = map(word, 1, 30, 10, maxW*50);
  return brickLength;
  } //<>//

void audioDataUpdate(){
  
for(int j =0; j< audioRange; ++j){ //<>//
float tempIndexAvg = (fft.getAvg(j) * audioAmp) * audioIndexAmp; //<>//
float tempIndexCon = constrain(tempIndexAvg, 0, audioMax); //<>//
audioData[j] = tempIndexCon; //<>//
audioIndexAmp += audioIndexStep; //<>//
}
audioIndexAmp = audioIndex;
}

//liczenie wysokosci slupka, amplitudy i kroku miedzy wersami
void countHAmplitudeStep(int wl) {
  float th = map(wl-5, wl, wl+3, (height - 350), (height -150)); 
  println("TH" + th);
  step = (((height-th)+50)/(wl-1));
  println("STEP "+step);
  h=(th/(wl));
  audioAmp = h;
}

void stop() {
  files[text.length].close();
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
