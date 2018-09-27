class WordCounter{
String[] words;
  Splitter splitter;
  WordCounter(Splitter splitter){
this.splitter = splitter;
}

void passThroughVerses(){
  for(int i=0; i<splitter.getVersesLength(); i++){
  words = splitter.splitVerseToWords(i);
 int a= countInVerse();
  }

}


int countInVerse(){
    
        int s = 1;
    float x = 20;
  float y = 64;
    for (int j =0; j< words.length; j++)
    {
      String xval = words[j];
      for (int k = 0; k<splitter.getDictKeysLength(); k++)
      if (xval.equals(splitter.getKey(k))){
              String ka = splitter.getKey(k);
        int r =  splitter.getDictValue(splitter.getKey(k)); 
        println("val " + r);
       s = r;
      textSize(s*12);
       score +=s;
       
       println(words[j]);
      println(s);
      text(words[j], x, y);
        // Move along the x-axis
        if( x<width)
      x += textWidth(words[j] + " "); 
      else 
      x=20;
   }
      //<>//
      
      
    }
     y += 16;
     return s;
    }

}
