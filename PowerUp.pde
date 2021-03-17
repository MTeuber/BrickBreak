class PowerUp
{
  float xPos, yPos;
  float len, h;
  int type;
  float hCol, sCol, bCol;
  String text;
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
    type = int(random(1));
    display = true;
    if(type == 0)
    {
      text = "EB";
    }
    else
    {
      text = "G";
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
  }
  
}
