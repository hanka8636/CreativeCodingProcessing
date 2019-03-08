import ddf.minim.*;  //<>// //<>// //<>// //<>// //<>//
import ddf.minim.analysis.*;

//grupa dzwiekowa
Audio audio;

//grupa tekstowa
SplitAndDict sad;
String file;
Grid grid;

//grupa generacyjna
int i =0;
float h = 0;
float step = 0;
float xStart;
float yStart;
int rectSize = (int)random(75, 85);
int stageMargin;

//pozniej do usuniecia
void drawTestMargins() {
  stroke(255);
  line(0, 50, width, 50);
  line(0, height-50, width, height-50);
  line(0, height-100, width, height-100);
  line(0, height-150, width, height-150);

  textSize(12);
  // text(author, 50, height-125);
  // text(title, 50, height-75);
  // text(speaker, width/2+50, height-50);
  noStroke();
}

//podstawowe operacje by tekst byl przydatny
void setAllConnectedWithText() {
  file = "smazenieIT.txt";
  sad = new SplitAndDict(file);
  sad.setAll();
  sad.text =sad.getText();
}

void setup() {
  size(707, 1000);
  colorMode(HSB);
  audio = new Audio(this);
  grid = new Grid("Barlow-Thin.ttf");
  setAllConnectedWithText();

  //obliczanie wartosci jezyka jako suma kodow ASCII
  grid.setBackgroundColorByLanguage("IT");

  grid.setDrawingColorByAuthorAndTitle();

  countHAmplitudeStep(sad.text.length);
  grid.countHighestWordsNumber(sad.text);
  grid.drawTexts();

  audio.loadFiles();
  audio.playFirst();
  String[] words = sad.splitThisText(sad.text[0]);
  audio.audioRange = words.length;
  grid.setMargin(words.length);
}

void draw()
{
  audio.playAudio();
  audio.setFFT(i);
  drawViz(grid.upMargin+step*i);

  audio.audioIndexAmp = audio.audioIndex;
}


//rysowanie grafik wersa
void drawViz(float y) {
  noStroke();
  float maxtempIndxAvg =0;
  for (int i = 0; i < audio.audioRange; i++)
  {
    fill(grid.genColor, 25);
    float tempIndxAvg = (audio.fft.getAvg(i) * audio.audioAmp) * audio.audioIndexAmp;
    if (maxtempIndxAvg < tempIndxAvg)
      maxtempIndxAvg = tempIndxAvg;
    rect(xStart + (i* rectSize), y+((step/4)*i), rectSize, tempIndxAvg);
    audio.audioIndexAmp += audio.audioIndexStep;
  }
}

//liczenie wysokosci slupka, amplitudy i kroku miedzy wersami
void countHAmplitudeStep(int wl) {
  float th = map(wl-1, wl, wl+30, (height - 350), (height-150)); 

  step = (((height-th)+375)/(wl-1));

  h=(th/(wl));
  audio.audioAmp = h;
}

void keyPressed() {
  if (key == ' ') {
    // a++;
    println("SPACJA");
    saveFrame("#####.png");
  }
}
