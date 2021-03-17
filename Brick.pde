class Brick
{
  float xPos, yPos, len, h;
  float hCol, sCol, bCol;
  int health;
  boolean display;

  Brick(float x, float y, float col)
  {
    xPos = x;
    yPos = y;
    hCol = col;

    len  = 40;
    h = 20;

    health = 1;

    sCol = 100;
    bCol = 100;
    
    display = true;
  }

  void drawBrick()
  {
    fill(hCol, sCol, bCol);
    stroke(hCol, sCol, bCol);
    rect(xPos, yPos, len, h);
  }

  int hitByBall(float x, float y, float r)
  {
    if (x > xPos && x < xPos + len &&
      y + r > yPos && y - r < yPos + h)
    {
      return 1;
    } else
      if (x + r > xPos && x - r < xPos + len
        && y > yPos && y < yPos + h)
      {
        return 2;
      } 
    return 0;
  }
}
