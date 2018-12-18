// forum.processing.org/two/discussion/12966/
// how-to-play-an-audio-file-sequentially
 
// 2015-Oct-13
 
import ddf.minim.Minim;
import ddf.minim.AudioPlayer;
 
static final int PLAYERS = 2;
final AudioPlayer[] players = new AudioPlayer[PLAYERS];
int idx;
 
void setup() {
  Minim m = new Minim(this);
  (players[0] = m.loadFile("u.wav")).play();
  players[1]  = m.loadFile("Blue.wav");
}
 
void draw() {
  if (!players[idx].isPlaying())  players[idx = (idx + 1) % PLAYERS].play();
}
