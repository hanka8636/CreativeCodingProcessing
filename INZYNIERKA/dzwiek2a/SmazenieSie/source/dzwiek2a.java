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

public class dzwiek2a extends PApplet {

  //<>// //<>// //<>// //<>// //<>//


//grupa dzwiekowa
Audio audio;

//grupa tekstowa
SplitAndDict sad;
String file;
Grid grid;

//grupa generacyjna
int i =0;
float h = 0;
float step = 0;
float xStart;
float yStart;
int rectSize = (int)random(75, 85);
int stageMargin;

//pozniej do usuniecia
public void drawTestMargins() {
  stroke(255);
  line(0, 50, width, 50);
  line(0, height-50, width, height-50);
  line(0, height-100, width, height-100);
  line(0, height-150, width, height-150);

  textSize(12);
  // text(author, 50, height-125);
  // text(title, 50, height-75);
  // text(speaker, width/2+50, height-50);
  noStroke();
}

//podstawowe operacje by tekst byl przydatny
public void setAllConnectedWithText() {
  file = "smazenie.txt";
  sad = new SplitAndDict(file);
  sad.setAll();
  sad.text =sad.getText();
}

public void setup() {
  
  colorMode(HSB);
  audio = new Audio(this);
  grid = new Grid("Barlow-Thin.ttf");
  setAllConnectedWithText();

  //obliczanie wartosci jezyka jako suma kodow ASCII
  grid.setBackgroundColorByLanguage("PL");

  grid.setDrawingColorByAuthorAndTitle();

  countHAmplitudeStep(sad.text.length);
  grid.countHighestWordsNumber(sad.text);
  grid.drawTexts();

  audio.loadFiles();
  audio.playFirst();
  String[] words = sad.splitThisText(sad.text[0]);
  audio.audioRange = words.length;
  grid.setMargin(words.length);
}

public void draw()
{
  audio.playAudio();
  audio.setFFT(i);
  drawViz(grid.upMargin+step*i);

  audio.audioIndexAmp = audio.audioIndex;
}


//rysowanie grafik wersa
public void drawViz(float y) {
  noStroke();
  float maxtempIndxAvg =0;
  for (int i = 0; i < audio.audioRange; i++)
  {
    fill(grid.genColor, 25);
    float tempIndxAvg = (audio.fft.getAvg(i) * audio.audioAmp) * audio.audioIndexAmp;
    if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
    rect(xStart + (i* rectSize), y+((step/4)*i), rectSize, tempIndxAvg);
    audio.audioIndexAmp += audio.audioIndexStep;
  }
}

//liczenie wysokosci slupka, amplitudy i kroku miedzy wersami
public void countHAmplitudeStep(int wl) {
  float th = map(wl-1, wl, wl+30, (height - 350), (height-150)); 

  step = (((height-th)+400)/(wl-1));

  h=(th/(wl));
  audio.audioAmp = h;
}

public void keyPressed() {
  if (key == ' ') {
    // a++;
    println("SPACJA");
    saveFrame("#####.png");
  }
}

class Audio {
  //deklaracja bibliotek do odczytywania muzyki i z Szybka Transformata Fouriera (FFT) 
  Minim minim;
  AudioPlayer myAudio;
  FFT fft;

  AudioPlayer[] files;

  //wysokosc i krok, pozniej uzaleznione od liczby wersow w tekscie 


  //liczba przedzialow i maksymalna moc dzwieku
  int audioRange = 12;
  int audioMax = 100;

  //domyslna wartosc amplitudy (pozniej uzalezniana od liczby wersow w tekscie),  indeks amplitudy i jej krok 
  float audioAmp = 40.0f;
  float audioIndex = 0.3f;
  float audioIndexAmp = audioIndex;
  float audioIndexStep = 0.35f;

  Audio(PApplet p) {
    // always start Minim first!
    minim = new Minim(p);
  }

  //wczytanie plikow dzwiekowych z wersami
  public void loadFiles() {
    files = new AudioPlayer[sad.text.length];

    for (int i = 0; i < files.length; i++) {
      files[i] = minim.loadFile( "22ms" +(i+1) + ".wav"); //<>//
    }
  }

  public void playFirst() {
    //odtworzenie i wykonanie operacji na pierwszym pliku dzwiekowym
    files[0].play();
  }

  public void playAudio() {
    //odtwarzanie kolejnych utworow, jesli poprzedni sie skonczyl

    if (!files[i].isPlaying()) {

      files[i = (i + 1) % files.length].play();



      String[] words = sad.splitThisText(sad.text[i]);
      audio.audioRange = words.length;
      grid.setMargin(words.length);
    }
    ;
  }

  //Wlaczenie szybiej transformaty Fouriera (FFT) dla konkretnej probki dzwieku
  public void setFFT(int i) {
    fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
    fft.linAverages(audioRange);
    fft.window(FFT.GAUSS);
    fft.forward(files[i].mix);
    //drawViz(50+step*i);
  }

  //zakonczenie odtwarzania
  public void stop() {
    files[sad.text.length].close();
    minim.stop();
    // super.stop();
  }
}
//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {
  PFont pFont1;
  PFont pFont2;

  String title;
  String author;
  String speaker;

  int lang;
  float upMargin = height/20;

  //domyslna wartosc koloru tla, pozniej definniowana w zaleznosci od jezyka oryginalu
  int bgColor = 0xff333333;
  //zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
  int genColor;

  //maksymalna liczba slow w wersie, sluzaca do ustalenia marginesow dla tekstu
  int highestWordsNumber; 

  //Konstruktor tylko z tytułem
  Grid() {
    setAuthorTitleSpeaker();
  }

  Grid(String font1) {
    setAuthorTitleSpeaker();
    try {
      pFont1 = createFont(font1, 12);
      println("Font in");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  Grid(String title, String author, String speaker) {
    this.title = title;
    this.author = author;
    this.speaker = speaker;
  }

  Grid(String title, String author, String speaker, String font1) {
    this.title = title;
    this.author = author;
    this.speaker = speaker;
    try {
      pFont1 = createFont(font1, 12);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  Grid(String title, String author, String speaker, String font1, String font2) {
    this.title = title;

    this.author = author;
    pFont1 = createFont(font1, 12);
    pFont2 = createFont(font2, 12);
  }



  //przypisanie wartosci autorowi, tytulowi i mowcy 
  public void setAuthorTitleSpeaker() {
    author = "Luciano Folgore";
    title = "Smażenie";
    speaker = "męzczyzna, 22 lata, student";
  }

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

  public void setMargin(int a) {

    stageMargin = (width - (rectSize *a))/2;
    if (stageMargin < 0) {
      rectSize /= 1.75f;
      stageMargin = (width - (rectSize * a))/2;
      //xSpacing = step;
    }
    xStart = stageMargin;
  }

  public void countHighestWordsNumber(String[] text) {
    for (int i=0; i<text.length; i++) {
      String[] words = sad.splitThisText(text[i]);
      if (highestWordsNumber< words.length)
        highestWordsNumber=words.length;
    }

    setMargin(highestWordsNumber);
  }

  public void drawTexts() {
   // drawTestMargins();
    fill(255);
    textFont(pFont1);
    textSize(12);
    textAlign(RIGHT, BOTTOM);
    text(title, width -xStart, height-2*upMargin);
    textSize(12);
    text(author, width -xStart, height-2*upMargin-20);
    textAlign(LEFT, BOTTOM);
    textSize(8);
    text(speaker, xStart, height-2*upMargin);
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

  //Konstruktor
  SplitAndDict(String file) {
    try 
    {
      this.text = loadStrings(file);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public void lowerCase() {
    for (int i=0; i<text.length; i++)
    { 
      text[i] = text[i].toLowerCase();
    }
  }

  public String[] getText() {
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

  public String[] splitThisText(String textt) {
    String[] words = splitTokens(textt, " ,.!:-?");

    return words;
  }

  //Metoda tworzy słownik słów i ich powtórzeń
  public void createDict() {
    occurance =  new IntDict();
    for (int i=0; i<words.length; i++)
    {
      occurance.increment(words[i]);
    }
    occurance.sortValuesReverse();
    //occurance.sortValues();

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
}
  public void settings() {  size(707, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "dzwiek2a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
