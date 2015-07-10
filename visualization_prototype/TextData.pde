class TextData{
  String delta = "Delta (δ):     ";
  color deltaColor=(#FFFFFF);
  float deltaValue;
  
  String theta = "Theta (θ):    ";
  color thetaColor=(#FFFFFF);;
  float thetaValue;
  
  String alpha = "Alpha (α):    ";
  color alphaColor=(#FFFFFF);
  float alphaValue;
  
  String beta = "Beta (β):       ";
  color betaColor=(#FFFFFF);
  float betaValue;
  
  String gamma = "Gamma (γ):  ";
  color gammaColor=(#FFFFFF);
  float gammaValue;
  
  TextData(float deltaValue, float thetaValue, float alphaValue, float betaValue, float gammaValue) {
    this.deltaValue = deltaValue;
    this.thetaValue = thetaValue;
    this.alphaValue = alphaValue;
    this.betaValue = betaValue;
    this.gammaValue = gammaValue;
  }
  
  void display() {
    
    int xLeft = 160;
    int yDown = 5;
    fill(deltaColor);
    text(delta+deltaValue, width-xLeft, yDown+15);
    fill(thetaColor);
    text(theta+thetaValue, width-xLeft, yDown+30);
    fill(alphaColor);
    text(alpha+alphaValue, width-xLeft, yDown+45);
    fill(betaColor);
    text(beta+betaValue, width-xLeft, yDown+60);
    fill(gammaColor);
    text(gamma+gammaValue, width-xLeft, yDown+75);
    
    text("Patient A", 5, 20);
    text("Channel 1", 5, 35);
    text("328 samples/sec", 5, 50);
    text("Window length = .785 seconds",5, 65);
    
    text("0", 3, height-5);
    text("20", 3+.125*(width-25), height-5);
    text("40", 3+.250*(width-25), height-5 );
    text("60", 3+.375*(width-25), height-5 );
    text("80", 3+.500*(width-25), height-5 );
    text("100", 3+.625*(width-25), height-5 );
    text("120", 3+.750*(width-25), height-5 );
    text("140", 3+.900*(width-25), height-5 );
    text("160", width-25, height-5);
  }
}
