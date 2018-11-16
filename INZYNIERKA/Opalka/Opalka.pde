//Parametry, które można wizualizować: //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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
Conventer con;

void setup() {
  frameRate(5);
  size(707, 1000);
  strokeWeight(1);
  file = "fragmentaI.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  col = color(0, score*0.5, score*0.8);
  stroke(col);
  background(0, 0, col);
  grid = new Grid("Ach, to nie było warte...", "Maria Pawlikowska-Jasnorzewska", "ebrima.ttf", "ebrimabd.ttf");
  println(score);
     con = new Conventer(textLine,"Arvo-Regular.ttf");
     con.convertWords();
}

void draw() {
  println("ą: "+"A".codePointAt(0)+" ę" + "c".codePointAt(0));
    background(0,90);
  noStroke();
  fill(0, 90);
  rect(0, 0, width, height);
  //drawWords();
  fill(255);
con.drawConvertedText();

  //countTotalPointsForLetters();
  //if (a%2==0)
 // noLoop();
  // else
  // loop();
}


void keyPressed() {
  if (key == ' ') {
    a++;
    grid.drawTitle();
    // grid.drawDistortedTitle();
    grid.drawAuthorFont();
    println("SPACJA");
    saveFrame("#####.png");
    noLoop();
    // drawVerses();
  }
}




void mousePressed() {
  if (mouseButton == LEFT)
    grid.drawTitleM();
  if (mouseButton == RIGHT)
    grid.drawAuthorM();
}
