#include <SoftwareSerial.h>
#include  <Servo.h> 
SoftwareSerial BTserial(2, 3); // RX | TX
// Connect the HC-05 TX to Arduino pin 2 
// Connect the HC-05 RX to Arduino pin 3

Servo servoLock;

char incomingByte = ' ';
int LivingRoomPin = 13;
int BedroomPin = 12;
int ChildrensRoomPin = 11;
int KitchenPin = 10;
int servoPin = 9;
int BathroomPin = 8;
int HallwayPin = 7;

int pos=0;
 
void setup() {
    pinMode(LivingRoomPin, OUTPUT);
    pinMode(BedroomPin, OUTPUT);
    pinMode(ChildrensRoomPin, OUTPUT);
    pinMode(KitchenPin, OUTPUT);
    pinMode(BathroomPin, OUTPUT);
    pinMode(HallwayPin, OUTPUT);
    
    servoLock.attach(servoPin);
    digitalWrite(servoPin, LOW);
    
    digitalWrite(LivingRoomPin, LOW);
    digitalWrite(BedroomPin, LOW);
    digitalWrite(ChildrensRoomPin, LOW);
    digitalWrite(KitchenPin, LOW);
    digitalWrite(BathroomPin, LOW);
    digitalWrite(HallwayPin, LOW);
 
    // HC-05 default serial speed for commincation mode is 9600
    BTserial.begin(9600);  
}
 
void loop() {
  
    if (BTserial.available()) {  
      
        incomingByte = BTserial.read();
        
        if (incomingByte == 'a') {  
          digitalWrite(LivingRoomPin, HIGH);
        } 
        if (incomingByte == 'b') {
          digitalWrite(LivingRoomPin, LOW);
        } 
        if (incomingByte == 'c') {  
          digitalWrite(BedroomPin, HIGH);
        } 
        if (incomingByte == 'd') {
          digitalWrite(BedroomPin, LOW);
        } 
        if (incomingByte == 'e') {  
          digitalWrite(ChildrensRoomPin, HIGH);
        } 
        if (incomingByte == 'f') {
          digitalWrite(ChildrensRoomPin, LOW);
        } 
        if (incomingByte == 'g') {  
          digitalWrite(KitchenPin, HIGH);
        } 
        if (incomingByte == 'h') {
          digitalWrite(KitchenPin, LOW);
        } 
        if (incomingByte == 'i') {  
          digitalWrite(BathroomPin, HIGH);
        }
        if (incomingByte == 'j') {
          digitalWrite(BathroomPin, LOW);
        }
        if (incomingByte == 'k') {  
          digitalWrite(HallwayPin, HIGH);
        }
        if (incomingByte == 'l') {
          digitalWrite(HallwayPin, LOW);
        }
        if (incomingByte == 'm') {  
          digitalWrite(servoPin, HIGH);
          pos = map(90, 0, 180, 180, 0); 
          servoLock.write(pos); 
          digitalWrite(servoPin, LOW);
        }
        if (incomingByte == 'n') {
          digitalWrite(servoPin, HIGH);
          pos = map(0, 0, 180, 180, 0); 
          servoLock.write(pos); 
          digitalWrite(servoPin, LOW);
        }
    }
}
