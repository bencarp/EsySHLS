#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <Servo.h>

Servo servosg90;

const char* ssid = "Fab\ Visitors";
const char* password = "Tonality";

ESP8266WebServer server(80);

const int ledgruen = 15;
const int ledrot = 13;

void servo1() {
  digitalWrite(ledgruen, 0);
  digitalWrite(ledrot, 1);
  servosg90.write(0);
  delay(500);
  digitalWrite(ledrot, 0);
  digitalWrite(ledgruen, 1);
  server.send(200, "text/plain", "Licht an");
}

void servo2() {
  digitalWrite(ledgruen, 0);
  digitalWrite(ledrot, 1);
  servosg90.write(180);
  delay(500);
  digitalWrite(ledrot, 0);
  digitalWrite(ledgruen, 1);
  server.send(200, "text/plain", "Licht aus");
}

void handleNotFound(){
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET)?"GET":"POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i=0; i<server.args(); i++){
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
}

void setup(void){
  pinMode(ledgruen, OUTPUT);
  pinMode(ledrot, OUTPUT);
  servosg90.attach(14);
  digitalWrite(ledgruen, 1);
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/ON", servo1);
  server.on("/OFF", servo2);

  server.on("/inline", [](){
    server.send(200, "text/plain", "this works as well");
  });

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}

void loop(void){
  server.handleClient();
}
