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
  file = "26.txt";
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
     con = new Conventer(textLine);
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

float countWLc(int wl) {
  float calc = 0;
  if (wl<10) {
    calc =5.85*( 10 - wl);
  }
  if ((wl>=10)&&(wl<20)) {
    calc = (20 - wl) *1.2;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=20)&&(wl<30)) {
    calc = (30 - wl) *0.85;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=30)&&(wl<40)) {
    calc = (40 - wl) *0.5;
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
