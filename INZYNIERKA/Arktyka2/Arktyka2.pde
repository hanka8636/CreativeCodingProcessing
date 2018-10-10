//Parametry, które można wizualizować: //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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

void setup() {
   textSize(32);
  frameRate(2);
  size(905, 1280);
  //strokeWeight(1);
 fill(255, 255, 255,20);
  file = "arktyka.txt";
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

void draw() {
  background(0);

  //drawWords();
  drawVerses();
  //countTotalPointsForLetters();
  //if (a%2==0)
  noLoop();
  // else
  // loop();
}

//Metoda rysuje Wizualizację słów w wersach
void drawVerses() {
  text = sad.getLines();
  int tL = text.length;
  float wLc = countWLc(tL);

  println("tL" + tL);
  int x = 20;
  int y = 20;
  int prevX = 200;
  int prevY = y; 
  int wLen = 0;
  int a = 0;
  //int prevI = 0;
  int maxA = 0;
int minY = 0, minX =  0;
int maxY = 0, maxX = 0;
  String[] vers = sad.getVerses();
  String[] lines = sad.getLines();
int y1 = int(random(height/2-50, height/2+50));
  for (int j =0; j<vers.length; j++) {

    String[] words = sad.getWordsFromTable(vers[j]);
      int h = vers[j].length();
    println(h);
    
    int len = vers.length;
    int low = j*(width/len);
    int max = low + width/len;
    int x1 = int(random(low+50, max/2-100));
    if(x1>prevX) x1=prevX - int(random(50));
    if ( j==0){
     minX = x1;
     minY = y1;}
    
    //int y1 = int(random((len*10 + 400), (len*10 + 600)));
    text("1", x1, y1);

    int x2 =  int(random(2*prevX/3-50, 2*prevX/3+50)*1.8);
    if(x2<x1) x2+=100;
    int y2 = int(random((len*10 + 400), (len*10 + 600)));
    text("2", x2, y2);
   if (j==vers.length-1)
     {
     maxX = x2;
     maxY = y1;  
 }
    
    int x3 = int(random(x1, x2));
    int y3 = int(random((h+10), (h-35)));
    text("3", x3, y3);
    
    triangle(x1, y1, x2, y1, x3, y3);
    // String s = words[j];
    // print("wers " + i + " " + s + " ");

    a = int(sp.countPoints(vers[j])*wLc);
    if (a>maxA) maxA = a;
    // println("punkty" + " " + words[j] + " " + a/5);
    //print(words[j] + " ");
    wLen = int(words[j].length()*15);  
    //println("litery" +wLen/5);
    // textSize(a/(2.5*tL));
    //text(words[j], x+30, y);
   
    //  rect(x, y, wLen, a);
    //if ((prevI != i)&&(j==0))
    // strokeWeight(2);
    // else
    //       strokeWeight(wLen/2);


    prevX = x2;
    prevY = y1;
   // prevX= wLen; //int(random(wLen*4));

    //println("x "+ x);
  }
  int dX = width-300;
  int dY = height-300;
  triangle(minX, minY, maxX, maxY, dX, dY);
  println();
  prevX = x;//+a;
  prevY = y+wLen;
  x= int(random(wLen/5));
  y+= maxA; //int(random(score/20))+
  // stroke(2);
  //stroke(a*3);
  //      line(prevX, prevY, x, y);
  maxA =0;


  a = 0; 
  wLen = 0;
  prevX =0; 
  prevY =0;
  x=0; 
  y=0;
}

//Metoda wizualizuje słowa, każde w kolejnej lini
void drawWords() {
  text = sad.getWords();
  int x = 10;
  int y = 30;

  for (int i=0; i<text.length; i++) {
    int a = sp.countPoints(text[i])*40;
    //println("punkty" + " " + text[i] + " " + a/5);

    int wLen = text[i].length()*5;  
    println("litery" +wLen/5);
    x= int(random(wLen*4));

    rect(x, y, wLen, a);
    // println("x "+ x);
    y+=i*int(random(wLen));// + wLen;
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
    saveFrame("#####.png");
    // noLoop();
    // drawVerses();
  }
}

float countWLc(int wl) {
  float calc = 0;
  if (wl<10) {
    calc =6*( 10 - wl);
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
