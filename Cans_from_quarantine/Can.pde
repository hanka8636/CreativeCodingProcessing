public class Can { //<>// //<>// //<>// //<>//
  String name;
  String brand;

  float canWidth;
  float canHeight;

  int maxCanHeightPix =height/2;

  int maxCanHeightmm;
  int canHeightPix;
  int canWidthPix;
  int insideProductHeightPix;

  int weight;
  int weightProduct;

  int energy;
  int kcal;

  long barCode;

  int days ;
  int months;
  int years;

  PShape ringPull;
  PShape bean;

  int getBgColor() {
    int col=0;
    int sum = 0;
    for ( int i = 0; i < name.length(); i++) {
      sum += (int)name.charAt(i);
    }
    col = (int)(random(1)*sum/name.length())+(int)(0.5*kcal);
    return col;
  }

  void drawCan() {
    pushMatrix();
    translate(0, -50);
    drawCanBody();
    drawTopCap();
    drawBottomCap();
    drawCanBodyFill();
    drawFillElements();
    drawFillEllipse();
    fill(100, 20, 180);
    drawLetters();
    popMatrix();
    createText();
    writeTimeLasting();
    //  ellipse(width/2,height/2-canHeightPix/2, canWidthPix-canWidthPix/12, canHeightPix/12);
  }

  void drawCanBody() {

    maxCanHeightmm =105;
    canHeightPix = (int)map(canHeight, 0, maxCanHeightmm, 0, maxCanHeightPix);
    canWidthPix = (int)map(canWidth, 0, maxCanHeightmm, 0, maxCanHeightPix);
    noStroke();
    fill(countCanColor(), 180, 200);
    rect(width/2, height/2, canWidthPix, canHeightPix);
  }
  void drawCanBodyFill() {
    insideProductHeightPix = (int)map(weightProduct, 0, weight, 0, canHeightPix);
    fill(countCanFillColor(), 150, 200);
    rect(width/2, height/2+((canHeightPix -insideProductHeightPix)/2), canWidthPix, insideProductHeightPix-40);
    ellipse(width/2, height/2+canHeightPix/2-20, canWidthPix, canHeightPix/4);
    fill(countCanFillColor(), 80, 200);
    ellipse(width/2, (height/2-((canHeightPix -insideProductHeightPix)/2))+(insideProductHeightPix-40)/8+canHeightPix/20, canWidthPix, canHeightPix/8);
  }

  void drawFillEllipse() {
    fill(countCanFillColor(), 80, 200, 100);
    ellipse(width/2, (height/2-((canHeightPix -insideProductHeightPix)/2))+(insideProductHeightPix-40)/8+canHeightPix/20, canWidthPix, canHeightPix/8);
  }
  void drawFillElements() {
    int rows, cols;
    int countElements = (int)weightProduct/(int)(kcal*0.25);    
    if (insideProductHeightPix>canWidthPix) {
      rows =ceil(sqrt(countElements));
      cols =floor(sqrt(countElements));
    } else {
      rows =floor(sqrt(countElements));
      cols =ceil(sqrt(countElements));
    }
    int cellWidth = canWidthPix/cols;
    int cellHeight = insideProductHeightPix/rows;
    int cellXpos = (int)(width-canWidthPix)/2;
    int cellYpos = (int)(height/2-((canHeightPix -insideProductHeightPix))+cellHeight*2);
    stroke(5);
    noStroke();
    // shapeMode(CENTER);
    color beanCTop =  color(hue((int)(getSVGBeanColor("top")+(energy-kcal)*random(0.1, 0.15))), saturation(getSVGBeanColor("top")), brightness(getSVGBeanColor("top")));
    color beanCFront =  color(hue((int)(getSVGBeanColor("front")+(energy-kcal)*random(0.1, 0.15))), saturation(getSVGBeanColor("front")), brightness(getSVGBeanColor("front")));
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {

        bean.translate(cellXpos, cellYpos);

        pushMatrix();
        shapeMode(CENTER);
        bean.translate(i*cellWidth, j*cellHeight);
        bean.rotate(random(TWO_PI));            
        bean.scale(countElements*0.2);
        bean.disableStyle();
        int beanPosX=(int)(3*cellWidth/4 +random(-cellWidth/8, cellWidth/8));
        int beanPosY=(int)(cellHeight/2+random(-cellHeight/4, cellHeight/4));
        fill(beanCTop);
        shape(bean, beanPosX-5, beanPosY-5);  
        fill(beanCFront);
        shape(bean, beanPosX, beanPosY); 
        popMatrix();
        bean.resetMatrix();
      }
    }

    println("elem" + countElements);
  }
  void drawTopCap() {

    fill(100, 20, 180); //caps
    ellipse(width/2, height/2-canHeightPix/2, canWidthPix, canHeightPix/8);
    noStroke();
    fill(100, 20, 165); //caps
    ellipse(width/2, height/2-canHeightPix/2 + canHeightPix/72, canWidthPix-canWidthPix/36, canHeightPix/10);
    strokeWeight(7);
    stroke(100, 20, 150);
    noFill();
    ellipse(width/2, height/2-canHeightPix/2+10, canWidthPix/4, canHeightPix/32);
    ellipse(width/2, height/2-canHeightPix/2+10, canWidthPix/2, canHeightPix/16);

    //   readSVGPull();

    stroke(100, 20, 200);
    strokeWeight(15);
    ellipse(width/2, height/2-canHeightPix/2, canWidthPix, canHeightPix/8);

    noStroke();
  }
  void drawBottomCap() {
    fill(100, 20, 200); //caps
    ellipse(width/2, height/2+canHeightPix/2, canWidthPix, canHeightPix/4);
  }


  int countCanColor() {
    int bar = (int)barCode;
    int sum = 0;
    while (bar > 0) {
      sum = sum + (int)bar % 10;
      bar = bar / 10;
    }

    return (int)(random(1)*(sum/2));
  }
  int countCanFillColor() {
    int sum =(int)map(weightProduct, 0, weight, 0, 255)+countCanColor();
    println("col "+ (random(0.5, 1)*(sum/2)));
    return (int)(random(0.5, 1)*sum/2);
  }

  int countElementSize(int insideProductHeightPix) {
    int maxEnergy = 550;
    int sum =(int)map(weightProduct, 0, weight, 0, 255)-countCanColor();
    println("elem size" +sum/2);

    return sum/4;
  }

  void readSVGPull() {
    ringPull = loadShape("cap.svg");
    // shape(ringPull, 110, 90, 100, 100);  // Draw at coordinate (110, 90) at size 100 x 100
    ringPull.scale(1.5);
    shape(ringPull, width/2, height/2-canHeightPix/2-canHeightPix/16);            // Draw at coordinate (280, 40) at the default size
  }

  void readSVGBean() {
    bean = loadShape("bean.svg");
    // shape(ringPull, 110, 90, 100, 100);  // Draw at coordinate (110, 90) at size 100 x 100
  }

  void getSVGBeanColors() {
    XML beanXML =xml = loadXML("bean.svg");
    XML[] children = xml.getChildren("g");
    for (int i = 0; i < children.length; i++) {
      int id = children[i].getInt("id");
      String name = children[i].getContent();
    }
  }
  color getSVGBeanColor(String nameS) {
    color beanColor = 0;
    XML beanXML = loadXML("bean.svg");
    XML beanXMLg = beanXML.getChild("g");
    XML[] childrenB = beanXMLg.getChildren("g");
    for (int i = 0; i < childrenB.length; i++) {
      String id = childrenB[i].getString("id");
      if (id.equals(nameS) == true) {
        String style = childrenB[i].getChild("path").getString("style");
        println(style);
        int r = Integer.parseInt(style.substring(9, 12));
        int g = Integer.parseInt(style.substring(13, 16));
        int b = Integer.parseInt(style.substring(17, 20));
        println(r+" "+g+" "+b);
        colorMode(RGB);
        beanColor = color(r, g, b);
        colorMode(HSB);
      }
      // fill:rgb(240,219,179);

      //     String s =children.getChild("top").getString("style"); //name").getContent();
      //  bean.disableStyle();
      //color c=  bean.getFill(1);

      //println(s);
    }
    return beanColor;
  }

  void createText() {
    PFont font;
    // The font must be located in the sketch's 
    // "data" directory to load successfully
    font = createFont("Amatic-Bold.ttf", 32);
    textFont(font, 32);
    fill(255, 0, 255);
    textSize(96);
    // textMode(CENTER);
    textAlign(CENTER, TOP);
    text(name, width/2, height-height/7);
    text("#1", width/16, height/64);
  }
  Letters let; 
  void drawLetters() {
    let =new Letters();
    int textWidth = canWidthPix-(canWidthPix/4);
    int brandLength = brand.length();
    int letterWidth = textWidth/brandLength;
    // rectMode(CORNER);
    for (int i=0; i<brandLength; i++) {
      if (i==0) {
        fill (40+let.countLettersRects(brand.charAt(i))-random(5, 15), 150, 200);
        rect(width/2-canWidthPix/2+canWidthPix/5+letterWidth*i, height/2-canHeightPix/4, letterWidth, 40+let.countLettersRects(brand.charAt(i)), 25);
      } else {
        fill (let.countLettersRects(brand.charAt(i))-random(5, 15), 150, 200);
        rect(width/2-canWidthPix/2+canWidthPix/5+letterWidth*i, height/2-canHeightPix/4, letterWidth, let.countLettersRects(brand.charAt(i)), 25);
      }
    }
  }

  void writeTimeLasting() {
    int d = day();    // Values from 1 - 31
    int m = month();  // Values from 1 - 12
    int y = year();   // 2003, 2004, 2005, etc.

    y*=365;
    m*=30;
    int fullDateToday = y+m+d;
    int expirationDate = days+(months*30)+(years*365);

    int lastingDays = expirationDate - fullDateToday;

    PFont font2;
    // The font must be located in the sketch's 
    // "data" directory to load successfully
    font2 = createFont("JosefinSans-Bold.ttf", 32);
    String textLasting = ("Razem możemy spędzić jeszcze "+ lastingDays + " dni.");
    textFont(font2, 32);
    fill(255, 0, 255);
    textSize(56);
    // textMode(CENTER);
    textAlign(CENTER, TOP);
    text(textLasting, width/2, height/2-canHeightPix/2-canHeightPix/8-height/32-15-96);
  }
}
