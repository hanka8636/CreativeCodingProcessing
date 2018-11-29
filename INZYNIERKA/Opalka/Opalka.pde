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
Autonomy aut;


void setup() {
  frameRate(5);
  size(707, 1000);
  strokeWeight(1);
aut = new Autonomy();
}

void draw() {
  println("ą: "+"A".codePointAt(0)+" ę" + "c".codePointAt(0));
    background(0);
  noStroke();
  fill(0, 90);
  fill(255,50);
  textSize(24);

  
aut.daw();

  //countTotalPointsForLetters();
  //if (a%2==0)
 // noLoop();
  // else
  // loop();
}
