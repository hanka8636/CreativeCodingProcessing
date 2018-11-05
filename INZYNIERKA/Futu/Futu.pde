//t wersy
//m najczesciej wystepujace

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

void setup(){
    size(707,1000);
  background(0);
  stroke(255);
  strokeWeight(3);
  noFill();
  frameRate(5);
 //noLoop();
  
    file = "do.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  col = color(0, score*0.5, score*0.8);
  stroke(col);
  noStroke();
  background(0, 0, col);
  grid = new Grid("Arktyka", "Republika");
  println(score);
}

void draw(){
  background(0);
    text = sad.getLines();
      String[] vers = sad.getVerses();
  int tL = text.length;
      int len = vers.length;
    int t[] = new int[len]; 
  for (int j =0; j<vers.length; j++) {
    println(vers.length);
   // String[] words = sad.getWordsFromTable(vers[j]);
           t[j] = vers[j].length();;
  }
  int[] m = sad.getDictValues(5);

  Futura futu = new Futura(t,m);
  futu.radSetup();
  futu.futura();
  futu.drawMostCommon();
  
}

//Parametry, które można wizualizować: //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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




 
void keyPressed() {
  if (key == ' ') {
    a++;
    println("SPACJA");
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
