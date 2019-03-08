//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {
  PFont pFont1;
  PFont pFont2;

  String[] titleSplit;  
  String title;
  int titleSize;
  String author;
  String speaker;
  
  //maksymalna liczba slow w wersie, sluzaca do ustalenia marginesow dla tekstu
int maxMargin; 
  //PFont font
  //Konstruktor tylko z tytułem
  Grid(String title) {
    this.title = title;
  }

  Grid(String title, String author, String speaker) {
    this.title = title;
    this.author = author;
    this.speaker = speaker;
  }

  Grid(String title, String author, String font1, String font2) {
    this.title = title;
    titleSplit = splitTokens(title, " ,.!:-?");
    this.author = author;
    pFont1 = createFont(font1, 64);
    pFont2 = createFont(font2, 24);
  }
  
  void countMaxMargin(String[] text) {
  for (int i=0; i<text.length; i++) {
    String[] words = getLine(i);
    if (maxMargin< words.length)
      maxMargin=words.length;
  }

  setMargin(maxMargin);
}
  
  void drawTexts(){
  drawTestMargins();

  
  fill(255, 50);
  textSize(12);
  textAlign(RIGHT, BOTTOM);
  text(title, width -xStart, height-100);
  textSize(12);
  text(author, width -xStart, height-80);
  textAlign(LEFT, BOTTOM);
  textSize(8);
  text(speaker, xStart, height-100);

}

  void drawDistortedTitle(float a) {
    textFont(pFont1);
    //fill(0);
    textSize(160);
    int prevX =int(a+80);
    int x =20;
    int y =20;
    for (int i = 0; i<titleSplit.length; i++) {
      for (int j =0; j<titleSplit[i].length(); j++)
      {
        x=int(random(prevX+40, (j+1)*(width/titleSplit[i].length())-40-a));
        y=int(random(((height/titleSplit.length)*i)+160, ((i+1)*(height/titleSplit.length)-80)));
        fill(255-(i*25));
        text(titleSplit[i].charAt(j), x, y);
        prevX=x;
      }
      prevX=0;
    }
  }

  void drawAuthorFont() {
    int xa = int(random(60, width-60));
    int ya = int(random(60, height-60));
    fill(255);
    textFont(pFont2);
    textSize(40);
    text(author, xa, ya);
  }


  void drawInBlankSpace(float min, float max, float aplph, float unit) {
    titleSize=64;
    println("MIN:" + min);
    println("MAX:" + max);
    int ya = int(random(min, max));
    println("YA:" + ya);
    int xa = int(ya-(aplph)+3*unit);

    fill(255);
    textFont(pFont1);
    textSize(titleSize);
    text(title, xa+150, ya-150);
    
     textFont(pFont2);
    textSize(titleSize/3);
    text(author, xa-50, ya);
  }

  void drawTitle() {
    fill(255);
    int x = int(random(500));
    int y = int(random(800, 1280));
    textSize(64);
    text(title, x, y);
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
