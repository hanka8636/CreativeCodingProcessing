class Conventer { //<>// //<>// //<>//
  String text;
  String[] words;
  String[] numberWords;
  String numberString;
  int x =0;
  int y =48;
  int textH = 1;
  int a =10;
  Conventer(String text) {
    this.text = text;
    this.words = splitTokens(text, " ,.!:-?");
  }

  void convertOneliner() {
    for (int i=0; i<text.length(); i++) {
      numberString+= nf(text.codePointAt(i), 3);
    }
  }

  void convertWords() {
    numberWords = new String[words.length];
    for (int i=0; i<words.length; i++) {
      for (int j=0; j<words[i].length(); j++) {
        char a = words[i].charAt(j);
        String b = str(a);
        String c = nf(b.codePointAt(0), 3);
        if (j == 0) numberWords[i]= c;
        else
          numberWords[i]+= c;
      }
    }
  }

  void drawConvertedText() {


    for (int i=0; i<numberWords.length; i++) {
      String word = null;

      textSize(textH);
      // if ( word ==032)
      //rect(x,y,textWidth(word),textH);
      for (int j=3; j<numberWords[i].length(); j+=3) {
        word= numberWords[i].substring(j-3, j);
        text(word, x, y);
        // Move along the x-axis
        x += textWidth(word);
        // If x gets to the end, move y
        if (x > width-textWidth(word)) {
          x = 0;
          y += textH;
          // If y gets to the end, we're done
          if (y > height) {
            break;
            //textH -=10;
          }
        }
      }
      x += 10;
    }
    int len = text.length();
    int q =  int(map(len, 2, 1140, 200, 2));
    textH=constrain(a, 0, q);
    if (a<q)
      a++;
    else {
      a=q;
    }
    if ((x<width-q/2)&&(a==q)) { 
      noLoop();
    }
    y=q;
  }
}
