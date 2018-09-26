class Explaination {
  String[] texts = {"Grafika", "Napisy"};

  void drawStep(int i) {
    text(texts[i], 30, height/2);
  }

  void info() {
    textSize(100);
    text("Proces powstania plakatu", 10, 10, 700, 800);
  }
}