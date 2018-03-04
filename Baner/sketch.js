var n = 0;
var c = 16;

function setup() {
    createCanvas(750, 150);
    angleMode(DEGREES);
    colorMode(HSB);
    background(0);
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
}