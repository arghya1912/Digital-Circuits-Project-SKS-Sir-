 
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>
/* Assign a unique ID to this sensor at the same time */
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified(12345);
int x = 0;
int y = 0;
int z = 0; 
void setup(void) {
Serial.begin(115200);
if(!accel.begin()) {   // Initialize the sensor
 Serial.println("No ADXL345 detected");
} else {
 // Range for this sensor - If you don't know the range run the
 // displayDataRate of the example code of the ADXL345 provided by Adafruit
 accel.setRange(ADXL345_RANGE_16_G);
thing["accelerometer"] >> [](pson& out){ // A new "thing" function for Thinger.io
    sensors_event_t event;
    accel.getEvent(&event);  // Get a new sensor event
    out["x"] = event.acceleration.x;  // Display the results (acceleration is measured in m/s^2)
    out["y"] = event.acceleration.y;
    out["z"] = event.acceleration.z;
    Serial.print("X: "); Serial.print(event.acceleration.x); Serial.print("  ");
    Serial.print("Y: "); Serial.print(event.acceleration.y); Serial.print("  ");
    Serial.print("Z: "); Serial.print(event.acceleration.z); Serial.print("  ");Serial.println("m/s^2 ");
}; //end of thing
} //end of if/else statement
}
