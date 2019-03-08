
class Audio {
  //deklaracja bibliotek do odczytywania muzyki i z Szybka Transformata Fouriera (FFT) 
  Minim minim;
  AudioPlayer myAudio;
  FFT fft;

  AudioPlayer[] files;

  //wysokosc i krok, pozniej uzaleznione od liczby wersow w tekscie 


  //liczba przedzialow i maksymalna moc dzwieku
  int audioRange = 12;
  int audioMax = 100;

  //domyslna wartosc amplitudy (pozniej uzalezniana od liczby wersow w tekscie),  indeks amplitudy i jej krok 
  float audioAmp = 40.0;
  float audioIndex = 0.3;
  float audioIndexAmp = audioIndex;
  float audioIndexStep = 0.35;

  Audio(PApplet p) {
    // always start Minim first!
    minim = new Minim(p);
  }

  //wczytanie plikow dzwiekowych z wersami
  void loadFiles() {
    files = new AudioPlayer[sad.text.length];

    for (int i = 0; i < files.length; i++) {
      files[i] = minim.loadFile( "22ms" +(i+1) + ".wav"); //<>//
    }
  }

  void playFirst() {
    //odtworzenie i wykonanie operacji na pierwszym pliku dzwiekowym
    files[0].play();
  }

  void playAudio() {
    //odtwarzanie kolejnych utworow, jesli poprzedni sie skonczyl

    if (!files[i].isPlaying()) {

      files[i = (i + 1) % files.length].play();



      String[] words = sad.splitThisText(sad.text[i]);
      audio.audioRange = words.length;
      grid.setMargin(words.length);
    }
    ;
  }

  //Wlaczenie szybiej transformaty Fouriera (FFT) dla konkretnej probki dzwieku
  void setFFT(int i) {
    fft = new FFT(files[i].bufferSize(), files[i].sampleRate());
    fft.linAverages(audioRange);
    fft.window(FFT.GAUSS);
    fft.forward(files[i].mix);
    //drawViz(50+step*i);
  }

  //zakonczenie odtwarzania
  void stop() {
    files[sad.text.length].close();
    minim.stop();
    // super.stop();
  }
}
