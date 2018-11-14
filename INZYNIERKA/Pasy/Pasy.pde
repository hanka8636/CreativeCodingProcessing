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

void setup() {
  frameRate(1);
  size(707, 1000);
  strokeWeight(1);
  file = "j.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  //col = color(0,score*0.5,score*0.8);
  stroke(0);
  background(0, 0, col);
  grid = new Grid("Pożegnanie", "Tadeusz Boy-Żelański","Exo-Regular.ttf", "Exo-Thin.ttf");
  println(score);
}

void draw() {
  color wh =color(0, 0, 0, 60);
  background(wh);
  //rect(width,height,width,height);
   
  //drawWords();
  // drawVerses();
  text =sad.getText();
  drawPas(text);
  grid.drawInBlankSpace(lastYb, lastYe, aplph, unit);
  //countTotalPointsForLetters();
  //if (a%2==0)
  //noLoop();
  // else
  // loop();
}

void drawPas(String[] s) {


  int tL = sad.text.length;
  float wLc = countWLc(tL);
   unit =random(wLc, 10*wLc);
  println("Unit:"+unit);
  stroke(255);
  strokeCap(PROJECT);
  float st =random(wLc, wLc*8);
  float pH = s[0].length()+unit;
  float a=random(2, 3.5);
  strokeWeight(st);
  line(0, a*s[0].length()+unit, a*s[0].length(), unit); 
  strokeWeight(1);
  line(0, a*s[0].length()+unit, a*s[0].length()+unit, 0); 
  for (int i=1; i<tL; i++) {
    int pL=s[i].length();
    //strokeWeight(3);
      strokeWeight(st);
    line(0, a*pH+unit, a*pL, a*(pH-pL)+unit);
    println(10*pH+unit);
    strokeWeight(1);
    if (i!=(tL-1))
 line(0, a*pH+unit, a*pL+650, a*(pH-pL)+unit-650);
      else {
     lastYb = a*pH+unit;
     line(0, a*pH+unit, a*pL+width/1.2, a*(pH-pL)+unit-(width/1.2));
     
   lastYe=a*(pH-pL)+unit-width;
   aplph=a*(pH-pL);
   
 }
    //text(s[i],0,a*pH+unit,a*pL,a*(pH-pL)+unit);
    pH+=unit;
    println("pH:" + pH);
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
