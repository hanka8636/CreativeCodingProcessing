var minval = -1.0;
var maxval = 1.0;

var minSlider; //= createSlider();
var maxSlider;

function setup() {
  createCanvas(900, 900);
  pixelDensity(1);
  colorMode(HSB);
  
  minSlider = createSlider(-2.5, 0, -2.5, 0.01);
  maxSlider = createSlider(0, 2.5, 2.5, 0.01);
  
}

function draw() {
  var maxiterations = 75000;
  loadPixels();
  for (var x = 0; x < width; x++){
    for (var y = 0; y < height; y++){
      
      var a = map(x, 0, width, minval-0.75,  maxval);
      var b = map(y, 0, height, minval,  maxval);
      
      var ca = a;
      var cb = b;
      
      var n = 0;
      
      while(n < maxiterations){
        var aa = a * a - b * b;
        var bb = 2 * a * b;
        
        a = aa + ca;
        b = bb + cb;
        //var bright = 0;
        if (abs(a + b) > 16){
          break;
        }
        
        n++;
      }
      
      var bright = map(n, 0, maxiterations, 0, 255);
      bright = map(sqrt(bright), 0, 1, 0, 255);
      
      if (n == maxiterations){
        bright = 0;
      }
      
      var pix  = (x + y * width) * 4;
      pixels[pix + 0] = 0;
      pixels[pix + 1] = bright;
      pixels[pix + 2] = 80;
      pixels[pix + 3] = 255;
    }
  }
  updatePixels();
  noLoop();

}

