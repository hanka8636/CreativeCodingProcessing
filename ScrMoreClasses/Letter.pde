class Letter {
  String character;
  int scrabPoints;
  int consVowl; //spólgłoska - 0  samogłoska 1
  int occ; //wystapienia litery w tekscie
  Letter() {
    occ = 1;
  }

  Letter(String s) {
    this.character = s;
    occ = 1;
  }

  Letter(String ch, int sp, int cv) {
    this.character = ch;
    this.scrabPoints = sp;
    this.consVowl = cv;
    occ = 1;
  }

  String getCharacter() {
    return character;
  }

  int getScrabPoints() {
    return scrabPoints;
  }

  int getConsVowl() {
    return consVowl;
  }

  void addOccurance() {
    occ++;
  }
  
  
  void setCharacter(String s) {
     character = s;
  }

  void setScrabPoints(int a) {
     scrabPoints = a;
  }

  void setConsVowl(int a) {
     consVowl = a;
  }

}
