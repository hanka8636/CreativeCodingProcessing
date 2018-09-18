//Parametry, które można wizualizować: //<>// //<>// //<>// //<>//
// a - liczba punktów za słowo
//wLen - długość słowa
//occurance w SplitAndDict - liczba wystąpień słowa w tekście
//score - całkowita liczba punktów za wiersz
//sadD - liczba poszczególnych liter w wierszu
//totalPointsForLetter - suma punktów za wszystkie wystąpienia danej litery

//Do dodania
//liczba liter w wersie
//liczba liter w całym wierszu
//liczba spółgłosek/samogłosek

//połączenia tego samego słowa w kolejnych wersach


String[] text;
String textLine;
SplitAndDict sad;
ScrabblePoints sp;
String file;
int score;
IntDict totalPointsForLetter;

void setup() {
  //frameRate(5);
  size(905, 1280);
  file = "pawlikowska.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  background(score*0.6);

  println(score);
}

void draw() {
  //background(score*0.6);

  //drawWords();
  drawVerses();
  countTotalPointsForLetters();
  noLoop();
}

//Metoda rysuje Wizualizację słów w wersach
void drawVerses() {
  text = sad.getVerses();
  int x = 10;
  int y = 0;
  int wLen = 0;
  for (int i=0; i<text.length; i++) {
    String[] words = splitTokens(text[i], " ,.!:-?");

    for (int j =0; j<words.length; j++) {
      String s = words[j];
      print("wers " + i + " " + s + " ");

      int a = sp.countPoints(words[j])*10;
      // println("punkty" + " " + words[j] + " " + a/5);
      //print(words[j] + " ");
      wLen = words[j].length()*5;  
      //println("litery" +wLen/5);
      textSize(a/20);
      text(words[j], x+30, y);
      rect(x, 2*y, a, wLen);
      x+= a; //int(random(wLen*4));

      //println("x "+ x);
    }
    println();
    x= int(random(wLen*4));
    y+=i*random(0.25*wLen/5) + wLen;
  }
}

//Metoda wizualizuje słowa, każde w kolejnej lini
void drawWords() {
  text = sad.getWords();
  int x = 10;
  int y = 0;
  for (int i=0; i<text.length; i++) {
    int a = sp.countPoints(text[i])*40;
    println("punkty" + " " + text[i] + " " + a/5);

    int wLen = text[i].length()*5;  
    println("litery" +wLen/5);
    x= int(random(wLen*4));
    rect(x, y, a, wLen);
    println("x "+ x);
    y+=i*random(0.25*wLen/5) + wLen;
  }
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
    println(totalPointsForLetter);
  }
}
