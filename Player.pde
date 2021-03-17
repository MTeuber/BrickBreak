class Player
{
  int len, r;
  float centerX, centerY;
  int colorCircle;
  float hCol, sCol, bCol;
  float dir, speed;

  Player()
  {
    r = 10;
    len = 40;
    centerX = width/2;
    centerY = height/2;
    hCol = int(random(360));
    sCol = 100;
    bCol = 100;
    colorCircle = 240;
    dir = 0;
    speed = 6;
  }

  void drawPlayer()
  {
    fill(colorCircle);
    stroke(colorCircle);
    circle(centerX - len/2, centerY, 2*r);
    circle(centerX + len/2, centerY, 2*r);

    fill(hCol, sCol, bCol);
    stroke(colorCircle);
    rect(centerX-len/2, centerY-r, len, 2*r);
  }

  void direction()
  {
    float angle;
    PVector v1 = new PVector(10, 0);                      // Making a vector, to use as basis for calculting the angle
    PVector v2 = new PVector(mouseX-centerX, mouseY-centerY);   // This vector is between player and mouse pointer position

    angle = PVector.angleBetween(v1, v2);                 // Uses the build-in method to determine the angle between the 2 vectors 

    dir = cos(angle);
  }

  void move()
  {
    if (dist(mouseX, mouseY, centerX, centerY) > 3)
    {
      centerX += dir * speed;
    }
  }
  
  void powerUp(int pu)
  {
    if(pu == 0)
    {
      len += 10;
    }
  }

  void setPlayerColor()
  {
    background(360);
    float angle, deg;
    // using PVector to make a vector in or det to get an angle
    PVector v1 = new PVector(10, 0);                              // generates a vector running 10 pixels along the x-axis. 
    PVector v2 = new PVector(mouseX-width/2, mouseY-height/2);    // generates a vector from the mouses position, and then shifts so it seems like it's around the center of the screen


    angle = PVector.angleBetween(v1, v2);                         // calculates the angle between the 2 vectors in radians
    if (mouseY > height/2)                                        // It always calculates the smallest angle, this checks if the mouse is above or below the center of the screen
    {
      deg = 360 - degrees(angle);
    } else
    {
      deg = degrees(angle);
    }

    println(deg);                                                  // Old debugging
    drawPlayer();                                         // draws the player, to show the color
    hCol = int(deg);

    float dis = dist(width/2, height/2, mouseX, mouseY);

    textSize(height/25);
    textAlign(CENTER, CENTER);
    text("Choose a color by moving the mouse.", width/2, height/4);
    text("Press to start the game", width/2, height*3/4);

    if (dis > 250)
    {
      sCol = 100;
      if (dis > 500)
      {
        bCol = 0;
      } else
      {
        bCol = 100 - (dis - 250)/2.5;
      }
    } else
    {
      sCol = dis/2.5;
    }

    drawPlayer();

    if (mousePressed)
    {
      centerY = height *9/10;
      gameOn = true;
    }
  }
}
