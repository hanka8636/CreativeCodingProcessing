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
  
  void drawTitleAndAuthor(){
   fill(50);
  int x = int(random(20,80));
  int y = int(random(50,height-50));
  textSize(12);
text(title, x, y);
 textSize(10);
text(author, x, y-20);
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
