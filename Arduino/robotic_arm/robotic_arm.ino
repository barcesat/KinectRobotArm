#include <Servo.h>
// declare servos
Servo A;
Servo B;
Servo C;
Servo D;
Servo E;

// setup the array of servo positions
int nextServo = 0;
int servoAngles[] = {0,0,0,0,0};

void setup() {
 Serial.begin(115200);
 
 // attach servos to their pins
 A.attach(2);
 B.attach(3);
 C.attach(4);
 D.attach(5);
 E.attach(6);
}

void loop() {
 if(Serial.available()){
	int servoAngle = Serial.read();
	servoAngles[nextServo] = servoAngle;
	nextServo++;
	if(nextServo > 4) nextServo = 0;
 
 
 A.write(servoAngles[0]);
 B.write(servoAngles[1]);
 C.write(servoAngles[2]);
 D.write(servoAngles[3]);
 E.write(servoAngles[4]);
 }

}
