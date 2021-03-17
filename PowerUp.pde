class PowerUp
{
  float xPos, yPos;
  float len, h;
  int type;
  float hCol, sCol, bCol;
  String textPU;
  float speed;
  boolean display;


  PowerUp(float x, float y, float col)
  {
    xPos = x;
    yPos = y;
    len = 40;
    speed = 2.5;
    h = 20;
    hCol = col;
    sCol = 100;
    bCol = 100;
    type = int(random(2));
    display = true;
    if(type == 0)
    {
      textPU = "G";
    }
    else
    {
      textPU = "EB";
    }
  }
  
  void move()
  {
    yPos += speed;
    hCol = (hCol + 0.5)%360;
    if(yPos > height)
    {
      display = false;
      buff = false;
    }
  }
  
  void drawPU()
  {
    fill(hCol, sCol, bCol);
    stroke(hCol, sCol, bCol);
    rect(xPos, yPos, len, h);
    fill(0);
    textSize(h);
    textAlign(CENTER);
    text(textPU,xPos+len/2,yPos+h*9/10);
  }
  
}
