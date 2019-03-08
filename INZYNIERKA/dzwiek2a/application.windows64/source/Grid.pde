//Klasa odpowiadająca za typowo plakatowe informacje - tytuł, logo itp

class Grid {
  PFont pFont1;
  PFont pFont2;

  String title;
  String author;
  String speaker;

  int lang;
  float upMargin = height/20;

  //domyslna wartosc koloru tla, pozniej definniowana w zaleznosci od jezyka oryginalu
  color bgColor = #333333;
  //zmienna na kolor rysowanej grafiki, pozniej definiowana w zaleznosci od tytulu i autora 
  color genColor;

  //maksymalna liczba slow w wersie, sluzaca do ustalenia marginesow dla tekstu
  int highestWordsNumber; 

  //Konstruktor tylko z tytułem
  Grid() {
    setAuthorTitleSpeaker();
  }

  Grid(String font1) {
    setAuthorTitleSpeaker();
    try {
      pFont1 = createFont(font1, 12);
      println("Font in");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  Grid(String title, String author, String speaker) {
    this.title = title;
    this.author = author;
    this.speaker = speaker;
  }

  Grid(String title, String author, String speaker, String font1) {
    this.title = title;
    this.author = author;
    this.speaker = speaker;
    try {
      pFont1 = createFont(font1, 12);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  Grid(String title, String author, String speaker, String font1, String font2) {
    this.title = title;

    this.author = author;
    pFont1 = createFont(font1, 12);
    pFont2 = createFont(font2, 12);
  }



  //przypisanie wartosci autorowi, tytulowi i mowcy 
  void setAuthorTitleSpeaker() {
    author = "Luciano Folgore";
    title = "Smażenie";
    speaker = "męzczyzna, 22 lata, student";
  }

  void setBackgroundColorByLanguage(String l) {
    int lastAscii = l.charAt(0);
    for (int i =0; i<l.length(); i++) {
      int ascii = l.charAt(i);
      if (i!=0)
        lastAscii -=ascii;
      lang+=ascii;
    }
    lang+=3*lastAscii;
    background(315-abs(lang), 80, 50);
  }

  //obliczenie i przypisanie wartosci koloru grafiki gdzie autor odpowiada za Hue (odcien), a tytul za Brightness (jasnosc)
  void setDrawingColorByAuthorAndTitle() {
    String[] nameSurname = sad.splitThisText(author);
    int asciiN=0, asciiS=0;
    for (int i =0; i<nameSurname.length; i++) {
      for (int j =0; j<nameSurname[i].length(); j++) {
        if (i%2==0)
          asciiN += nameSurname[i].charAt(j);
        else
          asciiS += nameSurname[i].charAt(j);
      }
    }
    String[] titleWords = sad.splitThisText(title);
    int titleNum = titleWords.length;
    genColor =color(author.length()+abs(asciiS-asciiN)/
    (author.length()-nameSurname[0].length()), 
      255, 255-(titleNum*title.length()));
  }

  void setMargin(int a) {

    stageMargin = (width - (rectSize *a))/2;
    if (stageMargin < 0) {
      rectSize /= 1.75;
      stageMargin = (width - (rectSize * a))/2;
      //xSpacing = step;
    }
    xStart = stageMargin;
  }

  void countHighestWordsNumber(String[] text) {
    for (int i=0; i<text.length; i++) {
      String[] words = sad.splitThisText(text[i]);
      if (highestWordsNumber< words.length)
        highestWordsNumber=words.length;
    }

    setMargin(highestWordsNumber);
  }

  void drawTexts() {
   // drawTestMargins();
    fill(255);
    textFont(pFont1);
    textSize(12);
    textAlign(RIGHT, BOTTOM);
    text(title, width -xStart, height-2*upMargin);
    textSize(12);
    text(author, width -xStart, height-2*upMargin-20);
    textAlign(LEFT, BOTTOM);
    textSize(8);
    text(speaker, xStart, height-2*upMargin);
  }
}
