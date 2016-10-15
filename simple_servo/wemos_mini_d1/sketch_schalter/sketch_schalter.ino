
#include <Servo.h>

Servo servosg90;
int ledPingruen = 15;
int ledPinrot = 13;

//button
int inPin = 12;   // pushbutton connected to digital pin 7
int val = 0;     // variable to store the read value
//button end

void setup()

{
pinMode(ledPingruen, OUTPUT);
pinMode(ledPinrot, OUTPUT);

servosg90.attach(14);


//button
 pinMode(inPin, INPUT_PULLUP);      // sets the digital pin 7 as input

  Serial.begin(9600);
//button end


}

 
void loop()

{
  //button
  val = digitalRead(inPin);   // read the input pin
  //digitalWrite(ledPin, val);   

  Serial.println(val);             // debug value
  delay(100);
  //button end


  
  digitalWrite(ledPingruen, 1);


  if(val==0){

  digitalWrite(ledPingruen, 0);
  digitalWrite(ledPinrot, 1);
  
  servosg90.write(0);

  delay(1000);

  servosg90.write(90);

  servosg90.write(0);

  
  delay(500);
  digitalWrite(ledPinrot, 0);
  digitalWrite(ledPingruen, 1);

}}
