//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {

  PFont pFont1;
  PFont pFont2;

  String[] titleSplit;  
  String title;
  String author;
  //PFont font
  //Konstruktor tylko z tytułem
  Grid(String title) {
    this.title = title;
  }

  Grid(String title, String author) {
    this.title = title;
    this.author = author;
  }

  Grid(String title, String author, String font1, String font2) {
    this.title = title;
    titleSplit = splitTokens(title, " ,.!:-?");
    this.author = author;
    pFont1 = createFont(font1, 64);
    pFont2 = createFont(font2, 24);
  }
  
  void showTextInHUD() {
  // A small 2D HUD for text in the
  // upper left corner. 
  // This func may only be called a the very end of draw() afaik.
  camera();
  hint(DISABLE_DEPTH_TEST);
 // noLights();
  textMode(SHAPE);
  smooth();
  textSize(40);
  float x = random(80, width-100);
  float y = random(80,height-100);
    text(title, x, y);
   textSize(28); 
   fill(200,255,255);
   text(author, x, y+40);
  hint(ENABLE_DEPTH_TEST);
} // func 

  void drawDistortedTitle() {
    textFont(pFont1);
    //fill(0);
    textSize(160);
    int prevX =0;
    int x =20;
    int y =20;
    for (int i = 0; i<titleSplit.length; i++) {
      for (int j =0; j<titleSplit[i].length(); j++)
      {
        x=int(random(prevX+40, (j+1)*(width/titleSplit[i].length())-40));
        y=int(random(((height/titleSplit.length)*i)+120, ((i+1)*(height/titleSplit.length)-80)));
        fill(120+10*i,255,255);
        text(titleSplit[i].charAt(j), x, y);
        prevX=x;
      }
      prevX=0;
    }
  }

  void drawAuthorFont() {
    int xa = int(random(60, width-60));
    int ya = int(random(60, height-60));
    fill(100);
    textFont(pFont2);
    textSize(40);
    text(author, xa, ya);
  }


  void drawTitleAndAuthor() {
    fill(50);
    int x = int(random(20, 80));
    int y = int(random(50, height-50));
    textSize(12);
    text(title, x, y);
    textSize(10);
    text(author, x, y-20);
  }

  void drawTitle() {
    fill(255);
    int x = int(random(500));
    int y = int(random(800, 1280));
    textSize(12);
    text(title, x, y);
  }

  void drawAuthor() {
    fill(255);
    int x = int(random(20, 220));
    int y = int(random(20, height-100));
    textSize(12);
    text(author, x, y);
  }

  void drawTitleM() {
    fill(255);
    textSize(32);
    text(title, mouseX, mouseY);
  }

  void drawAuthorM() {
    fill(255);
    textSize(24);
    text(author, mouseX, mouseY);
  }
}
