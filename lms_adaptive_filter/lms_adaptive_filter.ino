//LMS Filter for Arduino

#include <stdio.h> 
#include <math.h> 
#include <iostream>

float beta=3E-8;    //rate of convergence        was 1E-8
const int N=10;     // # of weights (coefﬁcients) was 30
//const int NS=256;   //# of output sample points

using namespace std;

float w[N];         //buffer weights of adapt ﬁlter
float delay_1[N];   //input buffer to adapt ﬁlter
short output= 0;    //overall output
short out_type = 1; //output type for slider

short T=0;

int InputPin_Noise= A7;
int InputPin_NoisySignal= A2; 

int DigitalValue_Noise=0;
int PreviousDigitalValue_Noise = 0;

int DigitalValue_NoisySignal= 0;
int PreviousDigitalValue_NoisySignal = 0;

int Noise= 0;
int NoisySignal= 0;

int Value_Noise=0;
int Value_NoisySignal=0;


float LMS()
{  
 
  short i;
  
  float yn;                    //output of adaptive system
  float E;                     //”error” signal
  
  delay_1[0] = Value_Noise; 
  yn = 0;                      //initial output of adapt ﬁlter
  
  for (i = 0; i < N; i++)     //to calculate output of FIR
  yn += (w[i] * delay_1[i]);  //output of adaptive ﬁlter
  E = Value_NoisySignal- yn;       //”error” signal=(d+n)-yn
  
  for (i = N-1; i >= 0; i--)  //to update weights and delays
    {
      w[i] = w[i] + beta*E*delay_1[i]; //update weights
      delay_1[i] = delay_1[i-1];       //update delay samples
    }
 
  if (out_type == 1)          //if slider in position 1
    output = ((short)E);      //”error” signal overall output
  
  else if (out_type == 2)
    output= Value_NoisySignal*10;       

  return yn;                   
}

void setup() 
{
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(InputPin_NoisySignal, INPUT);
  pinMode(InputPin_Noise, INPUT);
  pinMode(DAC0, OUTPUT);
  
  for (T = 0; T < N; T++)
  {
    w[T] = 0;       //init buffer for weights
    delay_1[T] = 0; //init buffer for delay samples
  }
  
//   Serial.print("A2");
//   Serial.print("  ");
//   Serial.print("A0");
//   Serial.print("  ");
//   Serial.print("LMS");
//   Serial.print("\n");  
}

void loop() 
{
  
  // put your main code here, to run repeatedly: 
  
  DigitalValue_Noise=analogRead(InputPin_Noise);
  DigitalValue_NoisySignal=analogRead(InputPin_NoisySignal);
  
  Noise=DigitalValue_Noise;
  NoisySignal=DigitalValue_NoisySignal;
  
  Value_Noise= DigitalValue_Noise;
  Value_NoisySignal= DigitalValue_NoisySignal;
  
  if(DigitalValue_Noise != PreviousDigitalValue_Noise || DigitalValue_NoisySignal != PreviousDigitalValue_NoisySignal)
    {
       LMS();
     }
     
 // analogWrite(DAC0, LMS());

// serial output
  analogReadResolution(12);
 
  Serial.print(Noise);
  Serial.print("  ");
  Serial.print(NoisySignal);
  Serial.print("  ");
  Serial.print(LMS());
  Serial.print(" ");
  Serial.print(output);
  Serial.print(";\n");  

  PreviousDigitalValue_Noise = DigitalValue_Noise;
  PreviousDigitalValue_NoisySignal = DigitalValue_NoisySignal;
}


