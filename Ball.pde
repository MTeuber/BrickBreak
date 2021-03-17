class Ball
{
  float xPos, yPos, r;
  float col;
  float xDir, yDir, speed;
  int xHitBuffer, yHitBuffer, pHitBuffer;

  Ball()
  {
    xPos = random(width*8/10)+width/10;
    yPos = height*1/4;
    r = 5;
    float dirStarter = random(1) - 0.5;
    col = 240;
    xDir = dirStarter;
    yDir = 1 - abs(dirStarter);
    speed = 5;
    xHitBuffer = 0;
    yHitBuffer = 0;
    pHitBuffer = 0;
  }

  void drawBall()
  {
    fill(col);
    stroke(col);
    circle(xPos, yPos, 2*r);
  }

  void moveBall()
  {
    xPos += xDir * speed;
    yPos += yDir * speed;
  }

  void hitPlayer()
  {
    if (pHitBuffer < 0)
    {
      if (xPos + r >= myPlayer.centerX - myPlayer.len
        && xPos - r <= myPlayer.centerX + myPlayer.len
        && yPos + r >= myPlayer.centerY - myPlayer.r
        && yPos - r <= myPlayer.centerY + myPlayer.r)
      {
        pHitBuffer = 3;
        newDirPlayer();
      }
    }
    pHitBuffer--;
  }

  void hitWall()
  {
    if (xHitBuffer < 0 && (xPos - r < 0  || xPos + r > width))
    {
      newDir(true);
    } else if (yHitBuffer < 0 && yPos - r < 0)
    {
      newDir(false);
    } else
      if (yPos - r > height)
      {
        
        gameOver = true;
      }
    {
      xHitBuffer--;
      yHitBuffer--;
    }
  }

  void newDir(boolean hitOnX)
  {
    if (hitOnX)
    {
      xDir = -1*xDir;
      xHitBuffer = 3;
    } else
    {
      yDir = -1*yDir;
      yHitBuffer = 3;
    }
  }

  void newDirPlayer()
  {
    float angle;
    PVector v1 = new PVector(10, 0);
    PVector v2 = new PVector(xPos - myPlayer.centerX, yPos - myPlayer.centerY);

    angle = PVector.angleBetween(v1, v2);

    xDir = cos(angle);                        
    yDir = -sin(angle);
  }
}
