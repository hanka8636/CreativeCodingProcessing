//klasa odpowiada za przypiaywanie punktów za literki zgodnie z punktacją gry Scrabble
class ScrabblePoints {
  IntDict points;
  String[] keys;

  //Konstruktor
  ScrabblePoints(String lang) {
    if (lang == "PL" || lang == "pl") {
      points = new IntDict();
      //jedynki
      points.set("a", 1);
      points.set("e", 1);
      points.set("i", 1);
      points.set("n", 1);
      points.set("o", 1);
      points.set("r", 1);
      points.set("s", 1);
      points.set("w", 1);
      points.set("z", 1);
      //dwojki
      points.set("c", 2);
      points.set("d", 2);
      points.set("k", 2);
      points.set("l", 2);
      points.set("m", 2);
      points.set("p", 2);
      points.set("t", 2);
      points.set("y", 2);
      //trojki
      points.set("b", 3);
      points.set("g", 3);
      points.set("h", 3);
      points.set("j", 3);
      points.set("ł", 3);
      points.set("u", 3);
      //piatki
      points.set("ą", 5);
      points.set("ę", 5);
      points.set("f", 5);
      points.set("ó", 5);
      points.set("ś", 5);
      points.set("ż", 5);
      //szostki
      points.set("ć", 6);
      //siodemki
      points.set("ń", 7);
      //dziewiatki
      points.set("ź", 9);
    }
  }

  //Metoda liczy i zwraca policzone punkty za dany ciąg znaków
  int countPoints(String text) {
    int score = 0;
    for (int i = 0; i<text.length(); i++) {
      String letter = str(text.charAt(i));
      if (points.hasKey(letter) == true)
      {
        score += points.get(letter);
      }
    }
    return score;
  }

  //Metoda zwraca słownik scrabblowy
  IntDict getDict() {
    return points;
  }

  //Metoda zwraca tablicę kluczy słownika scrabble'owego
  String[] getKeys() {
    keys = points.keyArray();
    return keys;
  }
}
