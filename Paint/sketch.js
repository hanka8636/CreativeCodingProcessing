var H = 0;
var S = 255;
var B = 255;
var Slider;
var hi = 100;


function setup() {
  createCanvas(1200,800);
  smooth();
  background(51);
  colorMode(HSB);
  strokeWeight(2);
  Slider = createSlider(1, 0, 20, 1);
 
  for (var i = 0; i<256; i++){
   stroke(H+i, S, B);
    line(50, 2*i+hi, 100, 2*i+hi);
 }
 noStroke();
 fill(255,0,255);
  rect(50,50+2*255+hi,50,50);
  //gumka
  rect(150,25,50,50);
  
  //kanwa
  rect(200,hi,800,610);
}

function draw() {
   noStroke();

 
   if ((mouseX>49)&&(mouseX<101)&&(mouseY>49)&&(mouseY<2*255+50)){
     H = (mouseY-50)/2;
     fill(H,S,B);
     rect(50,hi+2*255+50,50,50);
   }
   
    fill(0,0,20);
  rect(width-150, 0, 100, 150);
       fill(H,S,B);
  ellipse(width-100, 75, Slider.value(), Slider.value())
   
}

function mouseClicked(){
  if ((mouseX>49)&&(mouseX<101)&&(mouseY>49)&&(mouseY<2*255+50)){
    H = (mouseY-50)/2;
    S = 255;
    B = 255;
    fill(H,S,B);
   rect(50,hi+2*255+50,50,50);
  }
  
  
 if ((mouseX>149)&&(mouseX<201)&&(mouseY>49)&&(mouseY<101)){
    H = 255;
    S = 0;
    B = 255;
        fill(H,S,B);
 }
}

function mouseDragged() {

         strokeWeight(Slider.value());
        stroke(H,S,B);
        smooth();
         if ((mouseX>250)&&(mouseX<1020)&&(mouseY>hi-20)&&(mouseY<600+hi-20)){
                   line(mouseX, mouseY, pmouseX, pmouseY);
           noFill();
            
        strokeWeight(40);
        stroke(0,0,20);
       rect(180,hi-20,890,660);
        stroke(H,S,B);
            strokeWeight(Slider.value());
           
         }


}

