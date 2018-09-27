class Splitter {
  String[] verses;
  String[] tokens;
  IntDict occurance;
  String[] keys;
  String[] words;


  Splitter(String file) {
    //wczytane wiersze
     verses = loadStrings(file);
  }

  void createDict() {
    String versesOneLine = join(verses, " ").toLowerCase();
    tokens = splitTokens(versesOneLine, " ,.!:-?");
    occurance =  new IntDict();
    for (int i=0; i<tokens.length; i++)
    {
      occurance.increment(tokens[i]);
    }
  }

  void getDictKeys() {
    keys = occurance.keyArray();
    println(occurance);
  }

  int getDictValue(String t) {
    int r =  occurance.get(t);
    return r;
  }

  String[] splitVerseToWords(int i) {
      words = splitTokens(verses[i].toLowerCase(), " ,.!:-?");
 
    return words;
  }
  
  int getDictKeysLength(){
    return keys.length;
  }
  
  String getKey(int i){
  return keys[i];
  }
  
  int getVersesLength(){
  return verses.length;
  }
}
