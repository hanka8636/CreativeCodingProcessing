// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/jEwAMgcCgOA

var songs =[];
var song;
var amp;
var button;

var volhistory = [];

function toggleSong() {
  if (song.isPlaying()) {
    song.pause();
  } else {
    song.play();
  }
}

function keyPressed(){
  if (key==' ')
  rotate(90);
  
}

function preload() {
  for (var i =0; i<13; i++){
   // songs[i] = loadSound( "c" +(i+1) + ".wav");
    
  }
  song = loadSound('c1.wav');
}

function setup() {
  createCanvas(707, 1000);
  strokeCap(ROUND);
  var i =0;
  button = createButton('toggle');
  button.mousePressed(toggleSong);
  song.play();
  amp = new p5.Amplitude();
}

function draw() {
  background(247, 240, 225);
  var k =0;
  var vol = amp.getLevel();
  volhistory.push(vol);
  strokeWeight(5);
  stroke(10, 7, 96);
  noFill();
  push();
  var currentY = map(vol, 0, 1, height, 0);
  //translate(0, height / 2 - currentY);
  beginShape();
  for (var i = 0; i < volhistory.length; i++) {
    var y = map(volhistory[i], 0, 1, 100, 0);
    vertex(i*3, y);
   
  }
  endShape();
  
  
  pop();
  if (volhistory.length > width - 50) {
    volhistory.translate(0, -30);
  }

  stroke(255, 0, 0);
 // line(volhistory.length, 0, volhistory.length, height);
  //ellipse(100, 100, 200, vol * 200);
  
}
