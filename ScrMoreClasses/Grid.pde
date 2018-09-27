//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid{
String title;
String author;
//PFont font
  //Konstruktor tylko z tytułem
  Grid(String title){
  this.title = title;
  }
 
  Grid(String title, String author){
  this.title = title;
  this.author = author;
  }

void drawTitle(){
   fill(255);
  int x = int(random(500));
  int y = int(random(800,1280));
  textSize(64);
text(title, x, y);
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