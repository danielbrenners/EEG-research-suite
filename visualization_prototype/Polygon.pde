class Polygon 
{
  color c;
  float xPos;
  float yPos;
  
  float alphaXPos;
  float alphaYPos;

  float betaXPos;
  float betaYPos;

  float deltaXPos;
  float deltaYPos;
  
  float thetaXPos;
  float thetaYPos;
 
  float gammaXPos;
  float gammaYPos;
  
  
  
  Polygon(float xPos, float yPos, float delta, float theta, float alpha, float beta, float gamma)
  {
     float size=4.8;
    
     deltaXPos = xPos;
     deltaYPos = yPos - size*delta;
    
     thetaXPos = xPos - size*theta*cos(9*PI/10);
     thetaYPos = yPos - size*theta*sin(9*PI/10);
    
     alphaXPos =  xPos - size*alpha*cos(13*PI/10);
     alphaYPos = yPos - size*alpha*sin(13*PI/10);
    
     betaXPos = xPos - size*beta*cos(17*PI/10);
     betaYPos = yPos - size*beta*sin(17*PI/10);
    
     gammaXPos = xPos - size*gamma*cos(PI/10);
     gammaYPos = yPos - size*gamma*sin(PI/10);
    
     this.xPos = xPos;
     this.yPos = yPos;
  }
  
  void display()
  {
    
    
    float alpha = 128;
    fill(#00CCFF, alpha);
    triangle(deltaXPos, deltaYPos, xPos, yPos, thetaXPos, thetaYPos);
    
    fill(#0099CC, alpha);
    triangle(thetaXPos, thetaYPos, xPos, yPos, alphaXPos, alphaYPos);
    
    fill(#006699, alpha);
    triangle(alphaXPos, alphaYPos, xPos, yPos, betaXPos, betaYPos);
    
    fill(#006699, alpha);
    triangle(betaXPos, betaYPos, xPos, yPos, gammaXPos, gammaYPos);
    
    fill(#0099CC, alpha);
    triangle(gammaXPos, gammaYPos, xPos, yPos, deltaXPos, deltaYPos);
    
    //starChart Label
    fill(#FFFFFF);
    textSize(20);
    text("δ", deltaXPos, deltaYPos-8); 
    text("θ", thetaXPos+6, thetaYPos+4); 
    text("α", alphaXPos+5, alphaYPos+7);
    text("β", betaXPos-15, betaYPos+5); 
    text("γ", gammaXPos-8, gammaYPos+5); 
    textSize(13);
  }
}
