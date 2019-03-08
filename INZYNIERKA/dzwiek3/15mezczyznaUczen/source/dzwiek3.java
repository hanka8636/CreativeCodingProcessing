import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class dzwiek3 extends PApplet {

 //<>// //<>// //<>// //<>// //<>//

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
int col =0;
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
float audioAmp = 40.0f;
float audioIndex = 0.2f;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35f;

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
int bgColor = 0xff333333;
//zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
int genColor;
// zmienne na ciagi znakow bedace autorem, tytulem, mowca
String author =null;
String title = null;
String speaker = null;

float maxW = 0; 
//przypisanie wartosci autorowi, tytulowi i mowcy 
public void setAuthorTitleSpeaker() {
  author = "Aldo Palazzeschi";
  title = "Zaspana baba";
  speaker = "mężczyzna, 15 lat, uczeń";
}

//obliczenie i przypisanie wartosci koloru tla w zaleznosci od jezyka oryginalu
public void setBackgroundColorByLanguage(String l) {
 int lastAscii = l.charAt(0);
    for (int i =0; i<l.length(); i++) {
      int ascii = l.charAt(i);
      if (i!=0)
        lastAscii -=ascii;
      lang+=ascii;
    }
    lang+=3*lastAscii;
    background(315-abs(lang), 80, 50);
}

//obliczenie i przypisanie wartosci koloru grafiki gdzie autor odpowiada za Hue (odcien), a tytul za Brightness (jasnosc)
public void setDrawingColorByAuthorAndTitle() {
  String[] nameSurname = sad.splitThisText(author);
    int asciiN=0, asciiS=0;
    for (int i =0; i<nameSurname.length; i++) {
      for (int j =0; j<nameSurname[i].length(); j++) {
        if (i%2==0)
          asciiN += nameSurname[i].charAt(j);
        else
          asciiS += nameSurname[i].charAt(j);
      }
    }
    String[] titleWords = sad.splitThisText(title);
    int titleNum = titleWords.length;
    genColor =color(author.length()+abs(asciiS-asciiN)/
    (author.length()-nameSurname[0].length()), 
      255, 255-(titleNum*title.length()));
}

//pozniej do usuniecia
public void drawTestMargins() {
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
public void loadFiles() {
  files = new AudioPlayer[text.length];

  for (int i = 0; i < files.length; i++) {
    files[i] = minim.loadFile( "15mu" +(i+1) + ".wav");
  }
}

//podstawowe operacje by tekst byl przydatny
public void setAllConectedWithText() {
  file = "zaspana.txt";
  sad = new SplitAndDict(file);
  // sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  //score = sp.countPoints(textLine);
  text =sad.getText();
}

public void drawTexts(){
  //drawTestMargins();
  countMaxMargin();
  PFont pFont1 = createFont("Barlow-Thin.ttf", 12);
    textFont(pFont1);
  fill(255);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -50, height-100);
  textSize(12);
  text(author, width -50, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, 50, height-100);
  noFill();

}

public void setup()
{
  
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
  audioDataUpdate();
//drawViz(65+step*(i), words.length);
}

public void draw()
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
     //  drawOnlyTextPicture(words); //<>//

    setFFTandDraw(i); //<>//
    audioDataUpdate();
    drawViz(words);

    audioIndexAmp = audioIndex;
   
 
}


public void setFFTandDraw(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate()); //<>//
  fft.linAverages(audioRange); //<>//
  fft.getAvg(audioRange-1);
  fft.window(FFT.GAUSS); //<>//
  fft.forward(files[i].mix); //<>//
  
}

public void setMargin(int a) {
  //audioRange = a;
  stageMargin = (width - (letterWidth * a))/2;
  if (stageMargin < 0) {
    letterWidth /= 1.75f;
    stageMargin = (width - (letterWidth * a))/2;
    xSpacing = rectSize;
  }
  xStart = stageMargin;
}

public void countMaxMargin() {
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

public void countMargin(String[] words) {
       int sum = 0;
    for(int j=0; j<words.length; j++){

   sum+=words[j].length();
    
    }

  setMargin(sum);
}

public void drawOnlyTextPicture(String[] wordsInLine){
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

public void countLetterWidth(int longest) {
   letterWidths =width-100;
   letterWidth = letterWidths/longest; //to daje nam budulec do każdego słowa - wartość jednej literki to letterWidth 
  // letterWidth=letterWidth/2;
 //  startDrawingPosition = 
  
  }

public void drawViz(String[] wordsInLine) {
 countMargin(wordsInLine);
  float prevX=xStart;
  setDrawingColorByAuthorAndTitle();
noFill();
      strokeWeight(3);
      int fftAlpha = 0;
   
     
for (int q=0; q<wordsInLine.length; q++) {
  int sum =0;
  int audRan = (int)random(audioData.length-1);
 // audioDataUpdate();
  fftAlpha=(int)audioData[audRan]*10; //<>//
  stroke(genColor,fftAlpha/10); 
    float sf = wordsInLine[q].length()*letterWidth;
    sum+=wordsInLine[q].length();
//ellipseMode(CORNER); 
float ran =random(25);
rect(prevX+ran,50+(i*step), sf-ran, step- ran);
prevX+=wordsInLine[q].length()*letterWidth;
}

  
}
//}

 //vl - dlugosc najdluzszego wersu
  //word - dlugosc najdluzszego slowa w tekscie
  //words - liczba slow w najdluzszym wersie w tekscie
  public void defineMaxBrickLength(int vl, int words){
  float maxV = map(vl,0, width-200,0, width*2);
   maxW = maxV/words;
  }

public float defineBrickLength(int word){
  float brickLength = map(word, 1, 30, 10, maxW*50); //<>//
  return brickLength;
  }

public void audioDataUpdate(){
  
for(int j =0; j< audioRange; ++j){ //<>//
float tempIndexAvg = (fft.getAvg(j) * audioAmp) * audioIndexAmp; //<>//
float tempIndexCon = constrain(tempIndexAvg, 0, audioMax); //<>//
audioData[j] = tempIndexCon; //<>//
audioIndexAmp += audioIndexStep; //<>//
}
audioIndexAmp = audioIndex;
}

//liczenie wysokosci slupka, amplitudy i kroku miedzy wersami
public void countHAmplitudeStep(int wl) {
  float th = map(wl-5, wl, wl+3, (height - 350), (height -150 )); 
  println("TH" + th);
  step = (((height-th)+25)/(wl-1));
  println("STEP "+step);
  h=(th/(wl));
  audioAmp = h;
}

public void stop() {
  files[text.length].close();
  minim.stop();
  super.stop();
}

public void countDistY() {
  y += maxLast; 
  if (y>height)
    y =0;
}

public void keyPressed() {
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


public void mousePressed() {
  if (mouseButton == LEFT)
    grid.drawTitleM();
  if (mouseButton == RIGHT)
    grid.drawAuthorM();
}

public String[] getLine(int i) {
  String[] words = splitTokens(text[i], " ,.!:-?");

  return words;
}

public int[] getAllLinesLength(){
  int[] a = new int[text.length];
  for(int i = 0; i<text.length; i++){
  a[i] = getLine(i).length;
  }
return a;
}
//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {
  PFont pFont1;
  PFont pFont2;
float letterWidths;
float letterWidth;
  String[] titleSplit;  
  String title;
  int titleSize;
  String author;
  //PFont font
  //Konstruktor tylko z tytułem
  
  float startDrawingPosition;
  Grid(String title) {
    this.title = title;
  }

  Grid(String title, String author) {
    this.title = title;
    this.author = author;
  }

  Grid(String title, String author, String font1, String font2) {
    this.title = title;
    titleSplit = splitTokens(title, " ,.!:-?");
    this.author = author;
    pFont1 = createFont(font1, 64);
    pFont2 = createFont(font2, 24);
  }

  public void drawDistortedTitle(float a) {
    textFont(pFont1);
    //fill(0);
    textSize(160);
    int prevX =PApplet.parseInt(a+80);
    int x =20;
    int y =20;
    for (int i = 0; i<titleSplit.length; i++) {
      for (int j =0; j<titleSplit[i].length(); j++)
      {
        x=PApplet.parseInt(random(prevX+40, (j+1)*(width/titleSplit[i].length())-40-a));
        y=PApplet.parseInt(random(((height/titleSplit.length)*i)+160, ((i+1)*(height/titleSplit.length)-80)));
        fill(255-(i*25));
        text(titleSplit[i].charAt(j), x, y);
        prevX=x;
      }
      prevX=0;
    }
  }

  public void drawAuthorFont() {
    int xa = PApplet.parseInt(random(60, width-60));
    int ya = PApplet.parseInt(random(60, height-60));
    fill(255);
    textFont(pFont2);
    textSize(40);
    text(author, xa, ya);
  }
  
   public void countLetterWidth(int longest) {
   letterWidths =width-100;
   letterWidth = letterWidths/longest; //to daje nam budulec do każdego słowa - wartość jednej literki to letterWidth 
   letterWidth=letterWidths/2;
 //  startDrawingPosition = 
  
  }


  public void drawInBlankSpace(float min, float max, float aplph, float unit) {
    titleSize=64;
    println("MIN:" + min);
    println("MAX:" + max);
    int ya = PApplet.parseInt(random(min, max));
    println("YA:" + ya);
    int xa = PApplet.parseInt(ya-(aplph)+3*unit);

    fill(255);
    textFont(pFont1);
    textSize(titleSize);
    text(title, xa+150, ya-150);
    
     textFont(pFont2);
    textSize(titleSize/3);
    text(author, xa-50, ya);
  }

  public void drawTitle() {
    fill(255);
    int x = PApplet.parseInt(random(500));
    int y = PApplet.parseInt(random(800, 1280));
    textSize(64);
    text(title, x, y);
  }

  public void drawTitleM() {
    fill(255);
    textSize(32);
    text(title, mouseX, mouseY);
  }

  public void drawAuthorM() {
    fill(255);
    textSize(24);
    text(author, mouseX, mouseY);
  }
}
//klasa odpowiada za przypiaywanie punktów za literki zgodnie z punktacją gry Scrabble
class ScrabblePoints {
  IntDict points;
  String[] keys;

  //Konstruktor
  ScrabblePoints(String lang) {
    if (lang == "PL" || lang == "pl") {
      points = new IntDict();
      //jedynki
      points.set("a", 1);
      points.set("e", 1);
      points.set("i", 1);
      points.set("n", 1);
      points.set("o", 1);
      points.set("r", 1);
      points.set("s", 1);
      points.set("w", 1);
      points.set("z", 1);
      //dwojki
      points.set("c", 2);
      points.set("d", 2);
      points.set("k", 2);
      points.set("l", 2);
      points.set("m", 2);
      points.set("p", 2);
      points.set("t", 2);
      points.set("y", 2);
      //trojki
      points.set("b", 3);
      points.set("g", 3);
      points.set("h", 3);
      points.set("j", 3);
      points.set("ł", 3);
      points.set("u", 3);
      //piatki
      points.set("ą", 5);
      points.set("ę", 5);
      points.set("f", 5);
      points.set("ó", 5);
      points.set("ś", 5);
      points.set("ż", 5);
      //szostki
      points.set("ć", 6);
      //siodemki
      points.set("ń", 7);
      //dziewiatki
      points.set("ź", 9);
    }
  }

  //Metoda liczy i zwraca policzone punkty za dany ciąg znaków
  public int countPoints(String text) {
    int score = 0;
    for (int i = 0; i<text.length(); i++) {
      String letter = str(text.charAt(i));
      if (points.hasKey(letter) == true)
      {
        score += points.get(letter);
      }
    }
    return score;
  }

  //Metoda zwraca słownik scrabblowy
  public IntDict getDict() {
    return points;
  }

  //Metoda zwraca tablicę kluczy słownika scrabble'owego
  public String[] getKeys() {
    keys = points.keyArray();
    return keys;
  }
}
class Sound{


}
class SplitAndDict {
  String text[];
  String textOneLine;
  String[] words;
  IntDict occurance;
  String[] keys;
  IntDict letters;
  String[] lettersKeys;
    int countLongest;

  //Konstruktor
  SplitAndDict(String file) {
    this.text = loadStrings(file);
  }
  public void lowerCase() {
    for (int i=0; i<text.length; i++)
    { 
      text[i] = text[i].toLowerCase();
    }
  }
public String[] splitThisText(String textt) {
    String[] words = splitTokens(textt, " ,.!:-?");

    return words;
  }
public String[] getText(){
return text;
}

public int getLengthOfTheLongest(){
    int theLongest = 0;
    int a =0;
  for(int i=0; i<text.length; i++){
    if (text[i].length() > theLongest){
    theLongest = text[i].length();
    a=i;
  }
  }
   String[] wordsL = splitTokens(text[a], " ,.!:-?");
   countLongest=wordsL.length;
return theLongest;
  }
  
    public int getLengthOfTheLongestWords(){
    int theLongest = 0;
    int a =0;
  for(int i=0; i<text.length; i++){
   String[] line = splitTokens(text[i], " ,.!:-?");
   int sum =0;
   for(int j=0; j<line.length; j++){
   
   sum+=line[j].length();
   
   }
    if (sum > theLongest){
    theLongest = sum;
    a=i;
  }
  }
  return theLongest;}

  //Metoda wrzuca cały tekst do jednej lini
  public void createOneLiner() {
    textOneLine = join(text, " ").toLowerCase();
  }

  //Metoda rozdziela wczytane linijki tekstu na słowa zgodne z określonymi znakami
  public void splitText() {
    words = splitTokens(textOneLine, " ,.!:-?");
  }

  //Metoda zwraca tablicę wszystkich słów z tekstu
  public String[] getWords() {
    return words;
  }

  //Metoda zwraca tablicę wersów
  public String[] getVerses() {
    return text;
  }

  //Metoda tworzy słownik słów i ich powtórzeń
  public void createDict() {
    occurance =  new IntDict();
    for (int i=0; i<words.length; i++)
    {
      occurance.increment(words[i]);
    }
    //occurance.sortValues();
    keys = occurance.keyArray();
    println(occurance);
  }

  //Metoda ustawiająca wszystkie niezbędne pola;
  public void setAll() {
    createOneLiner();
    splitText();
    createDict();
    lowerCase();
  }

  //MEtoda zwraca tekst w jednej lini
  public String getOneLiner() {
    return textOneLine;
  }

  //Metoda tworzy słownik liter z tekstu
  public void createLettersDict() {
    letters =  new IntDict();
    for (int i=0; i<textOneLine.length(); i++) {
      String s = str(textOneLine.charAt(i));

      if ((s != " ")&&(s != ",")&&(s != " ")&&(s != "-")&&(s != "?")&&(s != "!")&&(s != ".")&&(s != ":")&&(s != ".")) {
        letters.increment(s);
      }
      letters.sortKeys();
      lettersKeys = letters.keyArray();
     // println("literki" + letters);
    }
  }

  //Metoda zwraca tablicę kluczy ze słownika liter
  public String[] getKeysLetters() {
    createLettersDict();
    return lettersKeys;
  }

  //Metoda zwraca słownik liter
  public IntDict getDictLeters() {
    return letters;
  }
}
  public void settings() {  size(707, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "dzwiek3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
