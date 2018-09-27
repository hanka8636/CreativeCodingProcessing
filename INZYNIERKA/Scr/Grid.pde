//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid{
String title;
//PFont font
  //Konstruktor tylko z tytułem
  Grid(String title){
  this.title = title;
  }

void drawTitle(){
  int x = 20;
  int y = 20;
  
text(title, x, y);
}
}
