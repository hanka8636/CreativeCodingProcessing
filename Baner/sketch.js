var n = 0;
var c = 16;


var img;
var imgMask;

function preload() {
  img = loadImage("2.jpg");
  imgMask = loadImage("3.png");
}


function setup() {
    createCanvas(750, 150);
    angleMode(DEGREES);
    colorMode(HSB);
    img.mask(imgMask);
 imageMode(CENTER);
      
    background(0);
       image(img, width/2, height/2);
}

function draw() {
    var a = n * 137.5;
    var r = c * sqrt(n);

    var x = r * cos(a) + width/2;
    var y = r * sin(a) + height/2;

    fill(a % r, 100, 100, 25);
    //tint(255, 127);
    noStroke();
    ellipse(x, y, 16, 16);
    n++;
}

function mouseClicked() {
  background(0);
  n = 0;
  c = 16;
  location.replace("https://en.wikipedia.org/wiki/Phyllotaxis");
  //createCanvas(750, 750);
}