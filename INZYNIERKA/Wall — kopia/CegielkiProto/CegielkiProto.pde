
float increment = 0.02;

void setup()
{
  frameRate(3);
  background(255);
  stroke(100);
  strokeWeight(3);
  //noLoop();
  size(707, 1000);
}
float yoff = 0.0;
void draw() {
  //background(255);

  drawNoise();
  drawBricks();
}

void drawBricks() {
  int sum =0;
  float  y = 160;
  int[] t = {3, 9, 6, 5, 7, 6, 6, 3, 5};
  for (int i=0; i<t.length; i++) {
    int currentY = i;
    int[] a =  new int[t[i]];
    for (int j=0; j<t[i]; j++) {
      a[j] = int(random(1, 15));
      sum+=a[j];
      print(a[j] + " ");
    }

    println();
    int current = 0;

    for (int j=0; j<t[i]; j++) {
      current+=a[j];
      float c = map(current, 1, sum, 0, width);
      y = map(t.length/2, 1, t.length+15, 0, height);
      // strokeWeight(t[i]);
      stroke(175);
      strokeWeight(4);
      line(c, i*y, c, y*(i+1));
      stroke(100);
      strokeWeight(1.5);
      line(c, i*y, c, y*(i+1));
    }
    sum=0;
    current =0;
    stroke(175);
    strokeWeight(4);
    line(0, y*i, width, y*i);
    stroke(100);
    strokeWeight(1.5);
    line(0, y*i, width, y*i);
  }
}

void drawNoise()
{
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float detail = map(random(0, 400), 0, width, 0.9, 0.8);
  noiseDetail(8, detail);

  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff

      // Calculate noise and scale by 255
      float bright = noise(xoff, yoff) * 255;

      // Try using this line instead
      //float bright = random(0,255);

      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  }

  updatePixels();
}
