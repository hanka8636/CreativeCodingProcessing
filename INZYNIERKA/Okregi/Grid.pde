//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid{
    PFont pFont1;
  PFont pFont2;
String title;
String author;
//PFont font
  //Konstruktor tylko z tytułem
  Grid(String title){
  this.title = title;
  }
 
  Grid(String title, String author, String font1, String font2){
  this.title = title;
  this.author = author;
  pFont1 = createFont(font1, 64);
    pFont2 = createFont(font2, 24);
  }
  
  void drawTitleAndAuthor(float a){
   fill(255);
  int x = int(random(25,a-title.length()));
  int y = int(random(0,height/4));
  textFont(pFont2);
  textSize(20);
text(author, x, y);
textFont(pFont1);
 textSize(20);
text(title, x, y+20+5);
noFill();
}

void drawTitle(){
   fill(255);
  int x = int(random(500));
  int y = int(random(800,1280));
  textSize(12);
text(title, x, y);
}

void drawAuthor(){
   fill(255);
  int x = int(random(20, 220));
  int y = int(random(20, height-100));
  textSize(12);
text(author, x, y);
}

void drawTitleM(){
   fill(255);
  textSize(32);
text(title, mouseX, mouseY);
}

void drawAuthorM(){
   fill(255);
  textSize(24);
text(author, mouseX, mouseY);
}
}
