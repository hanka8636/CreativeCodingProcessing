class Conventer { //<>// //<>// //<>//
  String text;
  String[] words;
  String[] numberWords;
  String numberString;
  int x =0;
  PFont pFont1;

  int textH = 10;
    int y =textH;
  int a =10;
  Conventer(String text, String font1) {
    this.pFont1 = createFont(font1, 64);
    textFont(pFont1);
    this.text = text;
    this.words = splitTokens(text, " ,.!:-?");
    convertOneliner();
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
        if ((i==0)&&(j==3)) x=0;
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
      x += 3;
    }
    int len = text.length();
    int nsl = numberString.length();
   float wlc= countWLc(nsl);
   int mp = int(200*wlc*0.01);
    int q =  int(map(nsl, 2, 1200*wlc, mp, 2)); //<>//
    textH=constrain(a, 0, q);
    if (a<q)
      a++;
    else {
      a=q;
    }
    if ((x<width-q/2)&&(a==q)) { 
      noLoop();
    }
    y=a;
  }
}

float countWLc(int wl) {
  float calc = 0;
  if (wl<500) {
    calc =0.05*( 500 - wl);
  }
   if ((wl>=500)&&(wl<1000)) {
    calc = (100 - wl) *0.04;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=1000)&&(wl<1500)) {
    calc = (1500 - wl) *0.08;
    // calc = 50*(1/(wl - 8));
  }
   if ((wl>=1500)&&(wl<2000)) {
    calc = (2000 - wl) *0.064;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=2000)&&(wl<2500)) {
    calc = (2500 - wl) *0.039;
    // calc = 50*(1/(wl - 8));
  }
   if ((wl>=2500)&&(wl<3000)) {
    calc = (3000 - wl) *0.17;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=3000)&&(wl<3500)) {
    calc = (3500 - wl) *0.0385;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=3500)&&(wl<4000)) {
    calc = (4000 - wl) *0.0625;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=4000)&&(wl<4500)) {
    calc = (4500 - wl) *0.045;
    // calc = 50*(1/(wl - 8));
  }
   if ((wl>=4500)&&(wl<5000)) {
    calc = (50 - wl) *0.35;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=5000)&&(wl<5500)) {
    calc = (5500 - wl) *0.035;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=5500)&&(wl<6000)) {
    calc = (6000 - wl) *0.3;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=6000)&&(wl<7000)) {
    calc = (7000 - wl) *100.65;
    // calc = 50*(1/(wl - 8));
  }
  if ((wl>=7000)&&(wl<8000)) {
    calc = (8000 - wl) *100.4;
    // calc = 50*(1/(wl - 8));
  }
  return calc;
}
