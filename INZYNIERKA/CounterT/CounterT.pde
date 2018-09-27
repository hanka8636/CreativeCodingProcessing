String[] text;
int score = 0;
ScrabblePoints  sp;
Splitter split;
WordCounter wc;
        
void setup() {
  colorMode(HSB);
  size(1063, 1500);
  background(0);//
  strokeWeight(2.5);
  fill(255);
  sp= new ScrabblePoints("pl");
  split = new Splitter("fragmentaI.txt");
  split.createDict();
  split.getDictKeys();
  
  wc = new WordCounter(split);
  //occurance.sortValues();

}

void draw() {

    wc.passThroughVerses();
 

 noLoop();
 //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 }
