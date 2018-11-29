class Autonomy{
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
int b =36; 
Autonomy (){
  file = "77.txt";
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
     con = new Conventer(textLine,"Arvo-Regular.ttf", sad.occurance);
     con.countWordAlpha();
     con.convertWords();
b= int(random(0,2)); //<>//
}

void daw(){
  
con.drawConvertedText(b); //<>//
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
}
