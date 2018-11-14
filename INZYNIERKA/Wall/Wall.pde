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

import peasy.*; //<>// //<>//
Wall3D wall;
PeasyCam cam;
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
float depth =0;
Grid grid;

void setup() {
  colorMode(HSB);
 depth =1800;
  cam = new PeasyCam(this, width/2, height/2, depth/2, depth*1.25); //generate the camera
  size(707, 1000, P3D);
  noFill();
 
  setupCamera();
  strokeWeight(10);

  stroke(255);
  //fill(255, a+(wLen));
  noFill();
  file = "26.txt";
  sad = new SplitAndDict(file);
  sp = new ScrabblePoints("pl");
  sad.setAll();
  textLine = sad.getOneLiner();
  sad.createLettersDict();
  score = sp.countPoints(textLine);
  count = textLine.length();
  
   wall = new Wall3D(sad.getLengthOfTheLongest(),sad.countLongest,sad.text.length);
  col = color(0, score*0.5, score*0.8);
  stroke(col);
  background(0, 0, col);
  grid = new Grid("Jakże ja się uspokoję", "Stanisław Wyspiański", "Montserrat-Regular.ttf", "Montserrat-Light.ttf");
  println(score);
}

void draw() {
  background(0,50);
 
  //drawWords();
  pushMatrix();
  drawVerses();
  popMatrix();
  //grid.drawDistortedTitle();
 // grid.drawAuthorFont();
  //countTotalPointsForLetters();
  //if (a%2==0)
  // noLoop();
  // else
  // loop();
  rotateCamera();
}

//Metoda rysuje Wizualizację słów w wersach
void drawVerses() {
//  drawNoise();
//  fill(180, 255, 255, 25);
 // rect(0, 0, width, height);
  text = sad.getVerses();
  int tL = text.length;
  float wLc = countWLc(tL)*5;
  noFill();
  stroke(200,255,255);
  strokeWeight(1.5);

  println("tL" + tL);

  for (int i=(text.length-1); i>=0; i--) { //<>//
    String[] words = splitTokens(text[i], " ,.!:-?"); //<>//

  //  Bricks o = new Bricks(words, wLc);
  pushMatrix();
wall.drawBricks(words,0);
popMatrix();
translate(0,0,wall.brickHeight);
  //  o.countSum();


   // o.drawBricks(i);
  }
}


void drawNoise()
{
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float detail = map(random(count, score+50), 0, width, 0.9, 0.01);
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
      pixels[x+y*width] = color(bright-200);
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
    grid.drawTitleM();
  println("tytuł");
  noFill();
  if (key == 'a') {
    grid.drawAuthorM();
    println("autor");
    noFill();
  }
  if (key == 'd') {
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
  if ((wl>=10)&&(wl<20)) {
    calc = (20 - wl) *3.15;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=20)&&(wl<30)) {
    calc = (30 - wl) *1.9;
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
    calc = (80 - wl) *0.87;
    // calc = 50*(1/(wl - 8));
  }
  return calc;
}

void setupCamera() {

  cam.rotateY(radians(90));
  cam.rotateZ(radians(-90));
}

void rotateCamera() {
  cam.rotateY(radians(1));
}

void mousePressed() {
  if (mouseButton == LEFT)
    grid.drawTitleM();
  if (mouseButton == RIGHT)
    grid.drawAuthorM();
}
