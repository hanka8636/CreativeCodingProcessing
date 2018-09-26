String[] wordy;// declare global...

// an arraylist to add and remove fading words...
ArrayList <FadingText> words = new ArrayList<FadingText>();


int i;
PFont font;// made global

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth();
  font = createFont("SansSerif", 48);
  wordy=loadStrings("http://thepanthernaut.com/happyregrets/answers.txt");// initialize only once

  Collections.shuffle(Arrays.asList(wordy));

}

void draw() {
  // clear bg
  background(0);

  // draw steady phrases
  fill(255);
  textFont(font, 40);
  text("I'M SORRY.", 30, 50);
  text("I'M HAPPY.", 30, 86);

  // increment i constraining it to length of array
  i = (i+1) % wordy.length;

  // create a FadingText for this word and display it
  words.add(new FadingText ( wordy[i]));
  for (FadingText f:words) {
    f.display();
  }

  // if word is faded out, remove it from list
  // going backwards...
  if (words.size() > 0) {
    for (int i = words.size(); i > 0; i--) {

      if (words.get(i-1).isDone()) {
        words.remove(i);
      }
    }
  }
}


class FadingText {
  String txt;
  float alpha;
  float r, g, b, x, y;

  FadingText (String _txt) {
    txt = _txt;
    alpha = 255;
    r = random(125, 255);
    g = random(125, 255);
    b = random(125, 255);

    x = random(0, 1280);
    y = random(100, 720);
  }

  void display() {
    textSize(15);
    noStroke();
    fill(r, g, b, alpha);
    text(txt, x, y);
    alpha-=4;// fading speed
  }

  boolean isDone() {  
    return alpha < 0;
  }
}