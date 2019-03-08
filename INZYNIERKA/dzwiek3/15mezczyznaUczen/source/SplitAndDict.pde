class SplitAndDict {
  String text[];
  String textOneLine;
  String[] words;
  IntDict occurance;
  String[] keys;
  IntDict letters;
  String[] lettersKeys;
    int countLongest;

  //Konstruktor
  SplitAndDict(String file) {
    this.text = loadStrings(file);
  }
  void lowerCase() {
    for (int i=0; i<text.length; i++)
    { 
      text[i] = text[i].toLowerCase();
    }
  }
String[] splitThisText(String textt) {
    String[] words = splitTokens(textt, " ,.!:-?");

    return words;
  }
String[] getText(){
return text;
}

int getLengthOfTheLongest(){
    int theLongest = 0;
    int a =0;
  for(int i=0; i<text.length; i++){
    if (text[i].length() > theLongest){
    theLongest = text[i].length();
    a=i;
  }
  }
   String[] wordsL = splitTokens(text[a], " ,.!:-?");
   countLongest=wordsL.length;
return theLongest;
  }
  
    int getLengthOfTheLongestWords(){
    int theLongest = 0;
    int a =0;
  for(int i=0; i<text.length; i++){
   String[] line = splitTokens(text[i], " ,.!:-?");
   int sum =0;
   for(int j=0; j<line.length; j++){
   
   sum+=line[j].length();
   
   }
    if (sum > theLongest){
    theLongest = sum;
    a=i;
  }
  }
  return theLongest;}

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

  //Metoda zwraca tablicę wersów
  String[] getVerses() {
    return text;
  }

  //Metoda tworzy słownik słów i ich powtórzeń
  void createDict() {
    occurance =  new IntDict();
    for (int i=0; i<words.length; i++)
    {
      occurance.increment(words[i]);
    }
    //occurance.sortValues();
    keys = occurance.keyArray();
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

  //Metoda tworzy słownik liter z tekstu
  void createLettersDict() {
    letters =  new IntDict();
    for (int i=0; i<textOneLine.length(); i++) {
      String s = str(textOneLine.charAt(i));

      if ((s != " ")&&(s != ",")&&(s != " ")&&(s != "-")&&(s != "?")&&(s != "!")&&(s != ".")&&(s != ":")&&(s != ".")) {
        letters.increment(s);
      }
      letters.sortKeys();
      lettersKeys = letters.keyArray();
     // println("literki" + letters);
    }
  }

  //Metoda zwraca tablicę kluczy ze słownika liter
  String[] getKeysLetters() {
    createLettersDict();
    return lettersKeys;
  }

  //Metoda zwraca słownik liter
  IntDict getDictLeters() {
    return letters;
  }
}
