String[] tokens;
IntDict occurance;
String[] text;
String[] keys;
int score = 0;
ScrabblePoints  sp;
        
void setup() {
  colorMode(HSB);
  size(1063, 1500);
  background(0);//
  strokeWeight(2.5);
  fill(255);
  
  text = loadStrings("zapytaj.txt");
  String textOneLine = join(text, " ").toLowerCase();
  tokens = splitTokens(textOneLine, " ,.!:-?");
  occurance =  new IntDict();
  sp= new ScrabblePoints("pl");
  for(int i=0; i<tokens.length; i++)
  {
    occurance.increment(tokens[i]);
  }
  //occurance.sortValues();
  keys = occurance.keyArray();
  println(occurance);
}

void draw() {
  int s = 1;
    float x = 20;
  float y = 64;
  for (int i = 0; i<text.length; i++)
  { //<>//
    String[] words;
    words = splitTokens(text[i].toLowerCase(), " ,.!:-?");
    for (int j =0; j< words.length; j++)
    { //<>//
      String xval = words[j];
      for (int k = 0; k<keys.length; k++)
      if (xval.equals(keys[k])){ //<>//
              String ka = keys[k];
        int r =  occurance.get(keys[k]);
        println("val " + r); //<>//
       s = r;
      textSize(s*12);
       score +=s; //<>//
       println(words[j]);
      println(s); //<>//
      text(words[j], x, y); //<>//
        // Move along the x-axis
        if( x<width)
      x += textWidth(words[j] + " "); 
      else 
      x=20;
   }
      //<>// //<>//
      
      
    }
     y += 16;
 }
 noLoop();
}
