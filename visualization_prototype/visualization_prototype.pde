import ddf.minim.analysis.*;
import ddf.minim.*;
FFT fft;
Minim minim;


void setup() {
  size(1024, 600);
  background(0);
  stroke(255);
}

void draw() {
  background(0);
  minim = new Minim(this);
  fft = new FFT (256, 328);

  //load EEG data (2048 samples at 328 samples/second)
  String[] stringData = loadStrings("EEG_2048.txt");
  float[] data = float(stringData);
  data[2047] = -0.129150000000000;

  //Part of array
  int begin = mouseX;
  if (mouseX<0)
    begin=0;

  float[] part = new float[256];
  System.arraycopy(data, begin, part, 0, 256);

  //create zero array for imaginary component
  float[] zeros = new float[256];
  for (int i=0; i<256; i++) {
    zeros[i] = 0;
  }

  //draw FFT spectrum
  float w = 0;
  strokeCap(SQUARE);
  strokeWeight(6);
  fft.forward(part, zeros);
  for (int i = 0; i < fft.specSize(); i++) {
    if (i>=0 && i<=3 ) stroke(#009999);
    if (i>=4 && i<=5 ) stroke(#BFFFFE);
    if (i>=6 && i<=9 ) stroke(#80FFFE);
    if (i>=10 && i<=24 ) stroke(#80C8FE);
    if (i>24) stroke(#BFE3FE);
    line(w/128*width+7, height-20, w/128*width+7, height - fft.getBand(i)*10-20); //minus 20 to move graph up
    w++;
  }
  stroke(255);
  strokeWeight(0);
  //draw raw EEG data 
  int eegShrinkFactor=3;
  for (int i=0; i<data.length; i++) {
    point(i, height/2 - height*(data[i])/eegShrinkFactor);
    if (i>0) {
      line(i, height/2 - height*(data[i]/eegShrinkFactor), i-1, height/2 - height*(data[i-1])/eegShrinkFactor);
    }
  }   
  //draw lines to mark part of data that you're windowing
  line(mouseX, 0, mouseX, height);
  line(mouseX+256, 0, mouseX+256, height);

  // calculate EEG waves
  float delta = 0;
  float theta = 0;
  float alpha = 0;
  float beta = 0;
  float gamma = 0;

  for (float i=0; i<3.125; i=i+1.28125) {
    delta= delta += fft.getFreq(i);
  }
  for (float i=3.125; i<6.25; i=i+1.28125) {
    theta+=fft.getFreq(i);
  }
  for (float i=6.25; i<10.16; i=i+1.28125) {
    alpha+=fft.getFreq(i);
  }
  for (float i=10.16; i<23.43; i=i+1.28125) {
    beta+=fft.getFreq(i);
  }
  for (float i=23.43; i<78.125; i=i+1.28125) {
    gamma+=fft.getFreq(i);
  }

  //draw star chart
  Polygon starChart = new Polygon(mouseX+128, height/2, delta, theta, alpha, beta, gamma);
  starChart.display();


  TextData TextData = new TextData(delta, theta, alpha, beta, gamma);
  TextData.display();

  //show seconds when mouse is pressed
  float time = (mouseX/float(width))*6.28;
  if (mousePressed && mouseX!=0) {
    text(time+" seconds", mouseX, mouseY);
  }
}

