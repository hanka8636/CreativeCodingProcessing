class SplitAndDict {
  String text[];
  String textOneLine;
  String[] words;
  IntDict occurance;

  //Konstruktor
  SplitAndDict(String file) {
    try 
    {
      this.text = loadStrings(file);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  void lowerCase() {
    for (int i=0; i<text.length; i++)
    { 
      text[i] = text[i].toLowerCase();
    }
  }

  String[] getText() {
    return text;
  }

  //Metoda wrzuca cały tekst do jednej lini
  void createOneLiner() {
    textOneLine = join(text, " ").toLowerCase();
  }

  //Metoda rozdziela wczytane linijki tekstu na słowa zgodne z określonymi znakami
  void splitText() {
    words = splitTokens(textOneLine, " ,.!:-?");
  }

  //Metoda zwraca tablicę wszystkich słów z tekstu
  String[] getWords() {
    return words;
  }

  String[] splitThisText(String textt) {
    String[] words = splitTokens(textt, " ,.!:-?");

    return words;
  }

  //Metoda tworzy słownik słów i ich powtórzeń
  void createDict() {
    occurance =  new IntDict();
    for (int i=0; i<words.length; i++)
    {
      occurance.increment(words[i]);
    }
    occurance.sortValuesReverse();
    //occurance.sortValues();

    println(occurance);
  }

  //Metoda ustawiająca wszystkie niezbędne pola;
  void setAll() {
    createOneLiner();
    splitText();
    createDict();
    lowerCase();
  }

  //MEtoda zwraca tekst w jednej lini
  String getOneLiner() {
    return textOneLine;
  }
}
