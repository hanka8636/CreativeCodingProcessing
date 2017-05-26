/*
 * Creative Coding
 * Week 3, 06 - rule-based system: final version
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014-2016 Monash University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
 * This sketch draws a series of moving Elements (circles) according to the following rules:
 * - start from a random position and move in a constant random direction
 * - if the point reaches the boundary of the screen move in the opposite direction with new velocity
 * - if the circles intersect then draw a line connecting their centres, colouring the line based on the circle being odd or even
 *
 * This sketch is the finished version from the exercise
 */
int width1=300; // that be the width of your brush
  //
  float radx;   // Radius
  float rady;
  float angle1; // angle 
 

float[] x;      // position
float[] y;
float[] xInc;   // change per frame
float[] yInc;
int numElements;   // number of elements

float proximity;  // if distance between elements < proximity then draw a line between them

int sizze=400;
int colorH = 25;
void setup() {
  size(720, 720);

  numElements = 500;
   background(0);
   colorMode(HSB);

  // allocate arrays
  x= new float[numElements];
  y= new float[numElements];
  xInc= new float[numElements];
  yInc= new float[numElements];

  proximity = 100;   // influence distance

  // random starting position and direction
  for (int i=0; i<numElements; i++) {
   // x[i] = random(width/2-sizze,width/2+sizze);
   // y[i] = random(height/2-sizze,height/2+sizze);
    
      radx=random(width1);
    rady=random(width1);
    angle1= random(359);
    //
    x[i]=(radx*cos(radians(angle1)))+width/2;
    y[i]=(radx*sin(radians(angle1)))+height/2;
    xInc[i] = random(-5, 5);
    yInc[i] = random(-5, 5);
  }

  strokeWeight(2);
}

void draw() {

  // background(200,10);

  // iterate over each point
  for (int i=0; i<numElements; i++) {

    x[i] += xInc[i];
    y[i] += yInc[i];

    // bounce off the sides of the window
    if (x[i] > width/2+100 || x[i] <width/2-100) {
      xInc[i] = xInc[i] > 0 ? -random(5) : random(5);
    }

    if (y[i] > height/2+100|| y[i] <height/2-100 ) {
      yInc[i] = yInc[i] > 0 ? -random(5) : random(5);
    }
  }

  for (int i=0; i<numElements; i++) {
    for (int j=0; j<i; j++) {
      float distance = dist(x[i], y[i], x[j], y[j]  );
      if (distance < proximity) {
        if (i%2 == 0 || j%2==0) {
          stroke(colorH, 255,255, 5);
        } 
        else {
          stroke(0, 10);
        }
        line(x[i], y[i], x[j], y[j]  );
      }
    }
  }
}

void keyPressed() {
  if (key == 'c') {
  sizze-=100;
  }
  if (keyCode == 32) {
  saveFrame("w3_06-######.png");
  }
}