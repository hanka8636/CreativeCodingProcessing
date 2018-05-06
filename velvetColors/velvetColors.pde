int size = 1024;
int siz = size-1;
int si = size-2;

float halfWidth, halfHeight;

float r = 192, g = 192, b = 192;
float vr, vg, vb;

float tension = .15;
float sympathy = 0.25;

float[] px = new float[size];
float[] py = new float[size];
float[] vx = new float[size];
float[] vy = new float[size];
float[] ax = new float[size];
float[] ay = new float[size];

/////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  fullScreen();
  background(0);
  noFill();
  strokeWeight(0.05);
  
  halfWidth = width/2;
  halfHeight = height/2;
  
  for (int i = 0; i < size; i++) {
    float angle = TAU * i / size;
    px[i] = halfWidth + cos(angle) * halfHeight;
    py[i] = halfHeight + sin(angle) * halfHeight;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  for (int i = 1; i < siz; i++) {
    ax[i] = (px[i-1] + px[i+1] - px[i] - px[i]) * tension + (vx[i-1] + vx[i+1] - vx[i] - vx[i]) * sympathy;
    ay[i] = (py[i-1] + py[i+1] - py[i] - py[i]) * tension + (vy[i-1] + vy[i+1] - vy[i] - vy[i]) * sympathy;
  }
  
  ax[0] = (px[siz] + px[1] - px[0] - px[0]) * tension + (vx[siz] + vx[1] - vx[0] - vx[0]) * sympathy;
  ay[0] = (py[siz] + py[1] - py[0] - py[0]) * tension + (vy[siz] + vy[1] - vy[0] - vy[0]) * sympathy;
  
  ax[siz] = (px[si] + px[0] - px[siz] - px[siz]) * tension + (vx[si] + vx[0] - vx[siz] - vx[siz]) * sympathy;
  ay[siz] = (py[si] + py[0] - py[siz] - py[siz]) * tension + (vy[si] + vy[0] - vy[siz] - vy[siz]) * sympathy;
  
  int randomNode = int(random(size));
  ax[randomNode] = (halfWidth - px[randomNode]) * 0.001 + randomGaussian() * 5;
  ay[randomNode] = (halfHeight - py[randomNode]) * 0.001 + randomGaussian() * 5;
  
  for (int i = 0; i < size; i++) {
    vx[i] += ax[i];
    vy[i] += ay[i];
    px[i] += vx[i];
    py[i] += vy[i];
    px[i] = constrain(px[i], 0, width);
    py[i] = constrain(py[i], 0, height);
  }
  
  vr = vr * 0.995 + randomGaussian() * 0.04;
  vg = vg * 0.995 + randomGaussian() * 0.04;
  vb = vb * 0.995 + randomGaussian() * 0.04;
  
  r += vr;
  g += vg;
  b += vb;
  
  if ((r < 128 && vr < 0) || (r > 255 && vr > 0))    vr = -vr;
  if ((g < 128 && vg < 0) || (g > 255 && vg > 0))    vg = -vg;
  if ((b < 128 && vb < 0) || (b > 255 && vb > 0))    vb = -vb;
  
  stroke(r, g, b);
  
  beginShape();
  for (int i = 0; i < size; i++) {
    vertex(px[i], py[i]);
  }
  endShape();
}

void keyPressed(){
if(keyCode == 32)
saveFrame("nice.#######.png");
}