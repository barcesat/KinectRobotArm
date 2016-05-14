import processing.serial.*;

Serial port;

HScrollbar A, B, C, D, E;  // Two scrollbars
PImage img1, img2;  // Two images to load

float angleA;
float angleB;
float angleC;
float angleD;
float angleE;

void setup() {
  size(640, 230);
  noStroke();
          //HScrollbar(xpos,ypos,width,height, loose);
  A = new HScrollbar(width/4, 30/*height/4*/, width/2, 20, 50);
  B = new HScrollbar(width/4, 60/*height/4*/, width/2, 20, 50);
  C = new HScrollbar(width/4, 90/*height/4*/, width/2, 20, 50);
  D = new HScrollbar(width/4, 120/*height/4*/, width/2, 20, 50);
  E = new HScrollbar(width/4, 150/*height/4*/, width/2, 20, 50);
  
  // Load images
  img1 = loadImage("seedTop.jpg");
  img2 = loadImage("seedBottom.jpg");
  
 String portName = Serial.list()[0];
 port = new Serial(this, portName, 115200);
}

void draw() {
  background(255);
  
  // Get the position of the img1 scrollbar
  // and convert to a value to display the img1 image 
  float img1Pos = A.getPos()-width/2;
  fill(255);
  image(img1, width/2-img1.width/2 + img1Pos*1.5, 0);
  
  // Get the position of the img2 scrollbar
  // and convert to a value to display the img2 image
  float img2Pos = B.getPos()-width/2;
  fill(255);
  image(img2, width/2-img2.width/2 + img2Pos*1.5, height/2);
  
  angleA = A.getPos();
  angleB = B.getPos();
  angleC = C.getPos();
  angleD = D.getPos();
  angleE = E.getPos();
  angleA = round(map(angleA, 171, 489, 0, 180));
  angleB = round(map(angleB, 171, 489, 0, 180));
  angleC = round(map(angleC, 171, 489, 0, 180));
  angleD = round(map(angleD, 171, 489, 0, 180));
  angleE = round(map(angleE, 171, 489, 0, 180));
  
  fill(255, 0, 0); //red
  textSize(30);
  text("A:" + int(angleA) + " B:" + int(angleB) + " C:" + int(angleC) + " D:" + int(angleD) + " E:" + int(angleE), 0, height);
  
  A.update();
  B.update();
  C.update();
  D.update();
  E.update();
  
  A.display();
  B.display();
  C.display();
  D.display();
  E.display();
  
  byte out[] = new byte[5];
  out[0] = byte(int(angleA));
  out[1] = byte(int(angleB));
  out[2] = byte(int(angleC));
  out[3] = byte(int(angleD));
  out[4] = byte(int(angleE));
  port.write(out);
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}