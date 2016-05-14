import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import processing.serial.*;

Serial port;
byte out[] = new byte[5];

Kinect kinect;
ArrayList <SkeletonData> bodies;
float dist_x;
float dist_y;
float angle;

float angleA = 90.0;
float angleB = 90.0;
float angleC = 90.0;
float angleD = 90.0;
float angleE = 90.0;

int ServoangleA = 90;
int ServoangleB = 90;
int ServoangleC = 90;
int ServoangleD = 90;
int ServoangleE = 90;

PImage img;

void setup()
{
  //size(640, 500);
  //surface.setResizable(true);
  fullScreen(P2D);
  background(0);
  smooth();
  
  img = loadImage("jerusalab_clear.png");
  
  kinect = new Kinect(this);
  bodies = new ArrayList<SkeletonData>();
  
  port = new Serial(this, Serial.list()[0], 115200);
}

void draw()
{
  background(#AC25C1);
  fill(0);
  //image(img, x, y, w, h)
  image(kinect.GetMask(), width/2, 0, width/2, height/2);
  image(kinect.GetImage(), 0, height/2-20, width/2, height/2);
  image(kinect.GetDepth(), width/2, height/2-20, width/2, height/2);
  image(img, width/4, height/3);
  
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    //drawPosition(bodies.get(i));
  }
  textSize(20);
  /*
  //display robot angles
    fill(255, 0, 0); //red   
    text("A:" + angleA + 
         " B:" + angleB + 
         " C:" + angleC + 
         " D:" + angleD + 
         " E:" + angleE
    , 0, height);
    */
    //display servo angles
    fill(0, 255, 0); //green  
    text("A:" + ServoangleA + 
         " B:" + ServoangleB + 
         " C:" + ServoangleC + 
         " D:" + ServoangleD + 
         " E:" + ServoangleE
    , width/2, height);
  
}

void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255); //light blue
  String s1 = str(_s.dwTrackingID);
  //text follows your middle position
  textSize(32);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}

void drawSkeleton(SkeletonData _s) 
{
  
  // Head & Shoulders
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HEAD, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER); // 3,2 - E
  
  //DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT); // 2,4 
  //DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT); // 2,8

  // Left Arm
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT); //4,5 - D
  
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT); //5,6 - C
  //DrawBone(_s, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, Kinect.NUI_SKELETON_POSITION_HAND_LEFT); //6,7

  // Right Arm
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT); // 8,9 - B
  
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT); //9,10 - A
  
  //DrawBone(_s, Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, Kinect.NUI_SKELETON_POSITION_HAND_RIGHT); //10,11
  
  /*
  //Lower Body
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SPINE, Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_CENTER, Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_CENTER, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_LEFT, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);

  // Left Leg
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_LEFT, Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Right Leg
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
  */
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    
     //line (x1, y1, x2, y2);  
    line(_s.skeletonPositions[_j1].x*width/2, 
    _s.skeletonPositions[_j1].y*height/2, 
    _s.skeletonPositions[_j2].x*width/2, 
    _s.skeletonPositions[_j2].y*height/2);
    /*
    print(_j1);
    print(" j1 x: ");
    print(_s.skeletonPositions[_j1].x);
    print(" y: ");
    println(_s.skeletonPositions[_j1].y);
    print(_j2);
    print(" j2 x: ");
    print(_s.skeletonPositions[_j2].x);
    print(" y: ");
    println(_s.skeletonPositions[_j2].y);
    */
    dist_x = (_s.skeletonPositions[_j1].x-_s.skeletonPositions[_j2].x);//*width/2;
    dist_y = (_s.skeletonPositions[_j1].y-_s.skeletonPositions[_j2].y);//*width/2;
    //angle = -atan(dist_y/dist_x)*180/PI;
    angle = degrees(atan(dist_y/dist_x));
    //println(atan(dist_y/dist_x)); //radians
    //println(angle); //degrees
    
    //String ang = str(angle);
    fill(0, 100, 255); //light blue
    textSize(20);
    text(round(angle), _s.skeletonPositions[_j1].x*width/2, _s.skeletonPositions[_j1].y*height/2);
    
    // adjust angles based on orientation of hardware 5
    //float shoulderAngle = constrain(degrees(PI/2 - E),0, 180);
    //float elbowAngle = degrees(PI - C);
    
    if( _j1 == 3 && _j2 == 2) {
      //angleE = round(constrain((180 - angle),0, 180));
      ServoangleE = int(map(round(angle), -90, 90, 40, 180));
      //print("head: "); println(angleE);
    }
    else if( _j1 == 9 && _j2 == 10) {
      //angleA = round(constrain((180 - angle),0, 180));
      ServoangleA = int(map(round(-angle), -90, 90, 20, 160));
      //print("sh_right: "); println(angleA);
    }
    else if( _j1 == 5 && _j2 == 6) {
      //angleC = round(constrain((180 - angle),0, 180));
      ServoangleC = int(map(round(-angle), -90, 90, 60, 115));
      //print("sh_left: "); println(angleC);
    }
    else if( _j1 == 4 && _j2 == 5) {
      //angleD = round(constrain((180 - angle),0, 180));
      ServoangleD = int(map(round(angle), -90, 90, 40, 180));
      //print("el_left: "); println(angleD);
    }
    else if( _j1 == 8 && _j2 == 9) {
      //angleB = round(constrain((180 - angle),0, 180));
      ServoangleB = int(map(round(-angle), -90, 90, 60, 120));
      //print("el_right: "); println(angleB);
    }
    
    
    //write to serial port
    out[0] = byte(ServoangleA);
    out[1] = byte(ServoangleB);
    out[2] = byte(ServoangleC);
    out[3] = byte(ServoangleD);
    out[4] = byte(ServoangleE);
    port.write(out);
    /*
    //write to serial port
    out[0] = byte(ServoangleE);
    out[1] = byte(ServoangleC);
    out[2] = byte(ServoangleD);
    out[3] = byte(ServoangleB);
    out[4] = byte(ServoangleA);
    port.write(out);
    */
  }
  
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
  println("O_O");
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
  println("X_X");
  // if not tracked: maintain steady position
    out[0] = byte(90);
    out[1] = byte(90);
    out[2] = byte(90);
    out[3] = byte(90);
    out[4] = byte(90);
    port.write(out);
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}