class Word {
  ArrayList<Letter> letters = new ArrayList<Letter>();
  int points;
  int wordLength;
  int numberOfConsonants;
  int numberOfVowels;
  int occurance;

  Word(String word) {
    for (int i =0; i<word.length(); i++) {
      Letter l =  new Letter(str(word.charAt(i)));
    }
  }

  Word(ArrayList<Letter> letters) {
    this.letters = letters;
    wordLength = letters.size();
    for (int i = 0; i<wordLength; i++) {
      if (letters.get(i).getConsVowl() == 0)
        numberOfConsonants++;
      else 
      numberOfVowels++;
            
    }
    
    occurance++;
  }
  
  void addOccurance(){
  occurance++;
  }
  
  
}
