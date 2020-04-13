class Letters {
  IntDict vowel ;
  IntDict  consonant  ;
  int cv =40;
  char[] vowels =  {'a', 'e', 'i', 'o', 'y','u', 'ą', 'ę', 'ó', 'A', 'E', 'I', 'O', 'Y','U', 'Ą', 'Ę', 'Ó'};
  char[] alphabeat ={'a','ą','b','c','ć','d','e','ę','f','g','h','i','j','k','l','ł','m','n','ń','o','ó','p','q','r','s','ś','t','u','v','w','x','y','z','ż','ź'};
  Letters() {



//    vowel = new IntDict();
//    //jedynki
//    vowel.set("a", (int)"a");
//    vowel.set("e", Integer.parseInt("e")/2);
//    vowel.set("i", Integer.parseInt("i")/2);
//    vowel.set("o", Integer.parseInt("o")/2);
//    vowel.set("y", Integer.parseInt("y")/2);
//    vowel.set("u", Integer.parseInt("u")/2);
//    vowel.set("ą", Integer.parseInt("ą")/2);
//    vowel.set("ę", Integer.parseInt("ę")/2);
//    vowel.set("ó", Integer.parseInt("ó")/2);
//    vowel.set("A", Integer.parseInt("A")/2);
//    vowel.set("E", Integer.parseInt("E")/2);
//    vowel.set("I", Integer.parseInt("I")/2);
//    vowel.set("O", Integer.parseInt("O")/2);
//    vowel.set("Y", Integer.parseInt("Y")/2);
//    vowel.set("U", Integer.parseInt("U")/2);
//    vowel.set("Ą", Integer.parseInt("Ą")/2);
//    vowel.set("Ę", Integer.parseInt("Ę")/2);
//    vowel.set("Ó", Integer.parseInt("Ó")/2);

//consonant = new IntDict();
//    consonant.set("n", Integer.parseInt("n")/2+cv);
//    consonant.set("r", Integer.parseInt("r")/2+cv);
//    consonant.set("s", Integer.parseInt("s")/2+cv);
//    consonant.set("w", Integer.parseInt("w")/2+cv);
//    consonant.set("z", Integer.parseInt("z")/2+cv);
//    consonant.set("c", Integer.parseInt("c")/2+cv);
//    consonant.set("d", Integer.parseInt("d")/2+cv);
//    consonant.set("k", Integer.parseInt("k")/2+cv);
//    consonant.set("l", Integer.parseInt("l")/2+cv);
//    consonant.set("m", Integer.parseInt("m")/2+cv);
//    consonant.set("p", Integer.parseInt("p")/2+cv);
//    consonant.set("t", Integer.parseInt("t")/2+cv);
//    consonant.set("b", Integer.parseInt("b")/2+cv);
//    consonant.set("g", Integer.parseInt("g")/2+cv);
//    consonant.set("h", Integer.parseInt("h")/2+cv);
//    consonant.set("j", Integer.parseInt("j")/2+cv);
//    consonant.set("ł", Integer.parseInt("ł")/2+cv);
//    consonant.set("f", Integer.parseInt("f")/2+cv);
//    consonant.set("ś", Integer.parseInt("ś")/2+cv);
//    consonant.set("ż", Integer.parseInt("ż")/2+cv);
//    consonant.set("ć", Integer.parseInt("ć")/2+cv);
//    consonant.set("ń", Integer.parseInt("ń")/2+cv);
//    consonant.set("ź", Integer.parseInt("ź")/2+cv);
//    consonant.set("N", Integer.parseInt("N")/2+cv);
//    consonant.set("R", Integer.parseInt("R")/2+cv);
//    consonant.set("S", Integer.parseInt("S")/2+cv);
//    consonant.set("W", Integer.parseInt("W")/2+cv);
//    consonant.set("Z", Integer.parseInt("Z")/2+cv);
//    consonant.set("C", Integer.parseInt("C")/2+cv);
//    consonant.set("D", Integer.parseInt("D")/2+cv);
//    consonant.set("K", Integer.parseInt("K")/2+cv);
//    consonant.set("L", Integer.parseInt("L")/2+cv);
//    consonant.set("M", Integer.parseInt("M")/2+cv);
//    consonant.set("P", Integer.parseInt("P")/2+cv);
//    consonant.set("T", Integer.parseInt("T")/2+cv);
//    consonant.set("B", Integer.parseInt("B")/2+cv);
//    consonant.set("G", Integer.parseInt("G")/2+cv);
//    consonant.set("H", Integer.parseInt("H")/2+cv);
//    consonant.set("J", Integer.parseInt("J")/2+cv);
//    consonant.set("Ł", Integer.parseInt("Ł")/2+cv);
//    consonant.set("F", Integer.parseInt("F")/2+cv);
//    consonant.set("Ś", Integer.parseInt("Ś")/2+cv);
//    consonant.set("Ż", Integer.parseInt("Ż")/2+cv);
//    consonant.set("Ć", Integer.parseInt("Ć")/2+cv);
//    consonant.set("Ń", Integer.parseInt("Ń")/2+cv);
//    consonant.set("Ź", Integer.parseInt("Ź")/2+cv);
  }

  int countPoints(String text) {
    int score = 0;
    for (int i = 0; i<text.length(); i++) {
      String letter = str(text.charAt(i));
      //if (points.hasKey(letter) == true)
      //{
      //  score += points.get(letter);
      //}
    }
    return score;
  }
  int countLettersRects( char letter){
    int num =0;
    for (int i=0; i<alphabeat.length; i++)
    if (alphabeat[i] ==letter)
    num =i+1;
    boolean  lett =false;
    for (int i=0; i<vowels.length; i++){
      if (vowels[i] == letter)
      lett =true;
  
      
    //int textWidth = canWidth-1/4*canWidth;
    //int brandLength = brand.length();
    //int letterWidth = textWidth/brandLength;
    //for (int i=0; i<brandLength; i++){
    
    //}
    
  }
  if (lett)
       return (int)(5*letter)/8+num;
       else
        return (int)((5*letter)/8+cv+num);
}
}
