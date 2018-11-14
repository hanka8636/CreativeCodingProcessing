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
  float increment = 0.02;
int a = 0;
String[] text;
String textLine;
SplitAndDict sad;
ScrabblePoints sp;
String file;
int score, count;
IntDict totalPointsForLetter;
color col =0;
Grid grid;

void setup() {
  colorMode(HSB);
  frameRate(10);
  size(707, 1000);
  strokeWeight(10);
    
      stroke(255);
      //fill(255, a+(wLen));
      noFill();
  file = "jak.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  count = textLine.length();
  col = color(0,score*0.5,score*0.8);
  stroke(col);
  background(0,0,col);
  grid = new Grid("Jakże ja się uspokoję", "Stanisław Wyspiański","octin spraypaint free.ttf","Lucznik1303Plus.ttf");
  println(score);
}
 //<>//
void draw() {
 background(0);

  //drawWords(); //<>//
  drawVerses();
  grid.drawDistortedTitle();
  grid.drawAuthorFont();
  //countTotalPointsForLetters();
  //if (a%2==0)
// noLoop();
 // else
 // loop();
}

//Metoda rysuje Wizualizację słów w wersach
void drawVerses() {
      drawNoise();
  text = sad.getVerses();
    int tL = text.length;
    float wLc = countWLc(tL)*5;
    strokeWeight(wLc/35);

println("tL" + tL);
 //<>//
  for (int i=0; i<text.length; i++) {
    String[] words = splitTokens(text[i], " ,.!:-?");

    Bricks o = new Bricks(words, wLc);

    o.countSum();


             o.drawBricks(i);
    
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

  void drawNoise()
{
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float detail = map(random(count, score+50), 0, width, 0.9, 0.5);
  noiseDetail(8, detail);

  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff

      // Calculate noise and scale by 255
      float bright = noise(xoff, yoff) * 255;

      // Try using this line instead
      //float bright = random(0,255);

      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(140,255,bright-300);
    }
  }

  updatePixels();
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
  grid.drawTitleAndAuthor();
  println("tytuł i autor");
  noFill();
  }
}

float countWLc(int wl) {
  float calc = 0;
  if (wl<10) {
     calc =8.3*( 10 - wl);
  }
     if ((wl>=10)&&(wl<20)){
       calc = (20 - wl) *3.15;
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
       calc = (50 - wl) *0.35;
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
       calc = (80 - wl) *0.87;
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
