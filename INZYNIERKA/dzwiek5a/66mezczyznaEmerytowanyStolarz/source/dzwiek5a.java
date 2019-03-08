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

public class dzwiek5a extends PApplet {

 //<>// //<>// //<>// //<>// //<>//


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
float audioAmp = 40.0f;
float audioIndex = 0.2f;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35f;

//tablica na dane muzyki
float[] audioData = new float[audioRange];

//szerokosc pojedynczego spektrum amplitudy, margines, poczatkowe wartosci rysowania
int rectSize = 80;
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
int bgColor = 0xff333333;
//zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
int genColor;
// zmienne na ciagi znakow bedace autorem, tytulem, mowca
String author =null;
String title = null;
String speaker = null;

//przypisanie wartosci autorowi, tytulowi i mowcy 
public void setAuthorTitleSpeaker() {
    author = "Aldo Palazzeschi";
    title = "Oro doro odoro dodoro ";
    speaker = "mężczyzna, 66 lat, emerytowany stolarz";
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
    files[i] = minim.loadFile( "66m_" +(i+1) + ".wav");
  }
}

//podstawowe operacje by tekst byl przydatny
public void setAllConectedWithText() {
  file = "oro.txt";
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
  PFont pFont1 = createFont("Barlow-Thin.ttf", 12);
  
  fill(255);
  textFont(pFont1);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -maxX, height-100);
  textSize(12);
  text(author, width -maxX, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, maxX, height-100);

}

public void setup()
{
  frameRate(5);
    
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

public void draw()
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

public void setFFTandDraw(int i) {
  fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
  fft.linAverages(audioRange);
  fft.window(FFT.GAUSS);
  fft.forward(files[i].mix);
  drawViz((step)*i+100);
  
}

public void setMargin(int a) {
  audioRange = a;
  stageMargin = (width - (rectSize * audioRange))/2;
  if (stageMargin < 0) {
    rectSize /= 1.75f;
    stageMargin = (width - (rectSize * audioRange))/2;
    xSpacing = rectSize;
  }
  xStart = stageMargin;
}
public void countMaxMargin() {
  for (int i=0; i<text.length; i++) {
    String[] words = getLine(i);
    if (maxMargin< words.length)
      maxMargin=words.length;
  }

  setMargin(maxMargin);
}

public float[] calcTempAvg(){
  float tempIndxAvg[] = new float[audioRange];
 for (int i = 0; i < audioRange; i++)
  {
   
   // noStroke();
   // fill(255-(y*2), 255, 255, 25);
     tempIndxAvg[i] = (fft.getAvg(i) * audioAmp) * audioIndexAmp;}
     return tempIndxAvg;
}


public void drawViz(float y) {
  float[] tempIndxAvg =calcTempAvg();
  for (int i = 0; i < audioRange; i++)
  {
    
    float temp = tempIndxAvg[(int)random(audioRange-1)];
   println("TEMP "+temp); //<>//
   // noStroke();
   // fill(255-(y*2), 255, 255, 25);
   // if (maxtempIndxAvg < tempIndxAvg)
     // maxtempIndxAvg = tempIndxAvg;
     // rect(xStart + (i* xSpacing), y, rectSize, tempIndxAvg);
       strokeWeight(2);
       stroke(genColor, 60+temp*3);
     // line(xStart + (i* xSpacing), y, xStart + (i* xSpacing)+rectSize, tempIndxAvg+y);
     // line(prevX, prevY, xStart + (i* xSpacing), y+(tempIndxAvg));
      
      float ran =random(50,25);
pushMatrix();
translate(xStart + (i* xSpacing)+rectSize/2,y);// bring zero point to the center 

//stroke(0);
noFill();
 ran =random((step)-15,(step)+5);
// println("temp+rectSize"+(rectSize+(temp)*ran));
line(0,0, sin(radians(rectSize+(temp)*ran))*ran,cos(radians(rectSize+(temp)*ran))*ran);
ellipse (sin(radians(rectSize+(temp)*ran))*ran,cos(radians(rectSize+(temp)*ran))*ran,5,5);
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
public void countHAmplitudeStep(int wl) {
  float th = map(wl-5, wl, wl+30, (height - 350), (height -150)); 
  println("TH" + th);
  step = (((height-th)+300)/(wl-1));
  println("STEP "+step);
  h=(th/(wl));
  audioAmp = h;
}

public void stop() {
  files[12].close();
  minim.stop();
  super.stop();
}

public void countDistY() {
  y += maxLast; 
  if (y>height)
    y =0;
}


//Metoda liczy ile w tekście jest punktów za daną literę
public void countTotalPointsForLetters() {
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




public String[] getLine(int i) {
  String[] words = splitTokens(text[i], " ,.!:-?");

  return words;
}
//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {
  PFont pFont1;
  PFont pFont2;

  String[] titleSplit;  
  String title;
  int titleSize;
  String author;
  //PFont font
  //Konstruktor tylko z tytułem
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
class SplitAndDict {
  String text[];
  String textOneLine;
  String[] words;
  IntDict occurance;
  String[] keys;
  IntDict letters;
  String[] lettersKeys;

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
    String[] appletArgs = new String[] { "dzwiek5a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
