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
float maxRad =0;
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
  size(808, 1101);
  strokeWeight(10);
    
      stroke(255);
      //fill(255, a+(wLen));
      noFill();
  file = "14.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  col = color(0,score*0.5,score*0.8);
  stroke(col);
  background(0,0,col);
  grid = new Grid("Jasna gwiazdo", "John Keats","Lato-Regular.ttf","Lato-Light.ttf");
  println(score);
}
 //<>//
void draw() {
 background(0);

  //drawWords(); //<>//
  drawVerses();
  grid.drawTitleAndAuthor(width-maxRad);
  //countTotalPointsForLetters();
  //if (a%2==0)
// noLoop();
 // else
 // loop();
}

//Metoda rysuje Wizualizację słów w wersach
void drawVerses() {
  text = sad.getVerses();
    int tL = text.length;
    float wLc = countWLc(tL)*5;
    strokeWeight(wLc/20);

println("tL" + tL);
 //<>//
  for (int i=0; i<text.length; i++) {
    String[] words = splitTokens(text[i], " ,.!:-?");

    Okrag o = new Okrag(words, wLc);
    o.countSpaces(180);
   float rad = o.drawCircle(i);
    
     if (rad > maxRad)
     maxRad = rad;
    
    }

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
  if (key == 's')
grid.drawTitle();
println("tytuł");
  noFill();
if (key == 'a'){
grid.drawAuthor();
println("autor");
  noFill();
}
  if (key == 'd'){
  //grid.drawTitleAndAuthor();
  println("tytuł i autor");
  noFill();
  }
}

float countWLc(int wl) {
  float calc = 0;
  if (wl<10) {
     calc =6*( 10 - wl);
  }
     if ((wl>=10)&&(wl<20)){
       calc = (20 - wl) *2.52;
      // calc = 50*(1/(wl - 8));
  }
   if ((wl>=20)&&(wl<30)){
       calc = (30 - wl) *1.9;
      // calc = 50*(1/(wl - 8));
  }
   if ((wl>=30)&&(wl<40)){
       calc = (40 - wl) *0.5;
      // calc = 50*(1/(wl - 8));
  }
  if ((wl>=40)&&(wl<50)){
       calc = (50 - wl) *0.58;
      // calc = 50*(1/(wl - 8));
  }
    if ((wl>=50)&&(wl<60)){
       calc = (60 - wl) *0.3;
      // calc = 50*(1/(wl - 8));
  }
      if ((wl>=60)&&(wl<70)){
       calc = (70 - wl) *0.65;
      // calc = 50*(1/(wl - 8));
  }
  if ((wl>=70)&&(wl<80)){
       calc = (80 - wl) *0.4;
      // calc = 50*(1/(wl - 8));
  }
  return calc;
}


void mousePressed(){
  if (mouseButton == LEFT)
grid.drawTitleM();
 if (mouseButton == RIGHT)
grid.drawAuthorM();
}
