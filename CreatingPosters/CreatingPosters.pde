import processing.pdf.*;
Layout lay =  null;
Picture pic = null;
Explaination exp = null;
boolean recording;
PGraphicsPDF pdf;
void setup() {
  size(630, 891);
   pdf = (PGraphicsPDF) createGraphics(width, height, PDF, "pause-resume.pdf");
   recording = true;
   //beginRecord(pdf);
      println("Recording started.");
      recording = true;
  background(51);
  exp =  new Explaination();
  pic =  new Picture();
  lay =  new Layout();
  lay.drawConstantContent();
  
}

void draw() {
  
  lay.drawFading();
  pic.drawSplatter();
}

void toBackground() {
  background(51, 5);
}

void keyPressed() {
  if (key == 's')
  {
    saveFrame("plakat.#####.png");
  }

  if (key == 'r') {
    if (recording) {
      endRecord();
      println("Recording stopped.");
      recording = false;
    } else {
      beginRecord(pdf);
      println("Recording started.");
      recording = true;
    }
  } else if (key == 'q') {
    if (recording) {
      endRecord();
    }
    exit();
  }  

  if (key == 'c') 
    lay.drawConstantContent();
}