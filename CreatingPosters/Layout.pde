import java.util.Collections;
import java.util.Arrays;

class Layout {

  int i = 0;
  String[] wordy;// declare global...
  // an arraylist to add and remove fading words...
  ArrayList <FadingText> words = new ArrayList<FadingText>();

  Layout() {
    font = createFont("SansSerif", 48);
    wordy=loadStrings("fade.txt");// initialize only once

    Collections.shuffle(Arrays.asList(wordy));
  }
  PFont font;// made global
  void drawConstantContent() {


    // draw steady phrases
    fill(255);
    textFont(font, 40);
    text("I'M SORRY.", 30, 50);
    text("I DO CARE.", 30, 86);
  }

  void drawFading() {
    textFont(font, 5);
    String s = wordy[int(random(wordy.length))];
    text(s, random(width-1), random(height-1));
  }
}