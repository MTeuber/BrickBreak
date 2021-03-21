// Declaring gam variables
Player myPlayer;
Ball[] balls = new Ball[4]; 
int ballsInPlay, maxBalls;
int  rowAmount = 4;
Brick[][] rows;
Brick[] row1 = new Brick[20];
Brick[] row2 = new Brick[20];
Brick[] row3 = new Brick[20];
Brick[] row4 = new Brick[20];
float xBrickStart, yBrickStart;
int brickHitBuffer;

// Buff handling
PowerUp myPowerUp;
boolean buff;
int buffMax;

int brickAmount;

// game state
boolean gameOn, gameOver, gameWon;

void setup()
{
  colorMode(HSB, 360, 100, 100);
  size(1000, 1000);
  ballsInPlay = 1;
  maxBalls = 4;

  xBrickStart = width/20;
  yBrickStart = height/10;
  brickHitBuffer = 0;

  brickAmount = 80;

  rows = new Brick[20][4];

  rowBuilder(xBrickStart, yBrickStart);

  gameOn = false;
  gameOver = false;

  buff = false;
  buffMax = 5;

  myPlayer = new Player();
  balls[0] = new Ball();
}

//Main
void draw()
{
  if (gameOver)
  {
    gameOverScreen(gameWon);
  } else
  {
    if (gameOn)
    {
      game();
    } else
    {
      myPlayer.setPlayerColor();
    }
  }
}

// build the rows of bricks
void rowBuilder(float xStart, float yStart)
{
  for (int j = 0; j < rowAmount; j++)
  {
    float brickCol = random(360);
    int xOffset = 0;
    for (int i = 0; i < 20; i++)
    {
      rows[i][j] = new Brick(xStart + xOffset, yStart, brickCol);
      xOffset += 45;
      brickCol = (brickCol + 2)%360;
    }
    xOffset = 0;
    yStart += 25;
  }
}

// The main game
void game()
{
  background(360);

  drawRow(rows);                                    // Draws the rows

  if (buff)                                         // buff handling, should be a new function
  {
    myPowerUp.move();
    myPowerUp.drawPU();
    if (checkPlayerToPU())
    {
      myPowerUp.display = false;
      buff = false;
      println("PowerUp: " + myPowerUp.type);
      if (myPowerUp.type != 1)
      {
        myPlayer.powerUp(myPowerUp.type);
      } else
      {
        if (ballsInPlay < maxBalls)
        {
          balls[ballsInPlay] = new Ball();
          ballsInPlay++;
          println("ballsInPlay: " + ballsInPlay);
        }
      }
    }
  }

  myPlayer.drawPlayer();
  myPlayer.direction();
  myPlayer.move();

  for (int b = 0; b < ballsInPlay; b++)
  {
    balls[b].drawBall();
    balls[b].moveBall();
    balls[b].hitPlayer();
    if (balls[b].hitWall())                                // Returning true means a ball is OOB
    {
      balls[b].display = false;
    }
  }

  ballCleanUp(ballsInPlay);
  brickHitBuffer--;
}

// Draws all the rows
void drawRow(Brick[][] rowsToDraw)
{
  for (int j = 0; j < rowAmount; j++)
  {
    for (int i = 0; i < 20; i++)
    {
      if (rowsToDraw[i][j].display)
      {
        rowsToDraw[i][j].drawBrick();
        checkBrickToBall(rowsToDraw[i][j]);
      }
    }
  }
}

// Checks if a brick is hit by a ball
void checkBrickToBall(Brick brick)
{
  int hit;
  for (int k = 0; k < ballsInPlay; k++)
  {
    hit = brick.hitByBall(balls[k].xPos, balls[k].yPos, balls[k].r);
    if (hit > 0 && brickHitBuffer < 0)                                  // hit = 0 means that the brick is not hit
    {
      if (hit == 1)                                                     // hit = 1 means it's hit on x-axis
      {
        balls[k].newDir(false);
      } else                                                            // hit = 2 means it's hit on y-axis
      {
        balls[k].newDir(true);
      }
      brick.display = false;
      brickAmount--;
      if (int(random(10)) > 1 && !buff && buffMax > 0)
      {
        buff = true;
        myPowerUp = new PowerUp(brick.xPos, brick.yPos, brick.hCol);
      }
      if (brickAmount == 0)
      {
        gameWon = true;
        gameOver = true;
      }

      brickHitBuffer = 3;
    }
  }
}

// checks if aren't being displayed and removes them
void ballCleanUp(int ballsInPlayCurrent)
{
  int offset = 0;
  if (ballsInPlayCurrent == 1)
  {
    if (!balls[0].display)
    {
      ballsInPlay--;
      println("ballsInPlay " + ballsInPlay);
      gameOver = true;
    }
  } else
  {
    for (int i = 0; i < ballsInPlayCurrent-1; i++)
    {
      if (!balls[i].display)
      {
        offset++;
        ballsInPlay--;
        println("ballsInPlay: " + ballsInPlay);
      }
      if (offset > 0)
      {
        balls[i] = balls[i+offset];
      }
    }
  }
}

// Checks if player gets a power up
boolean checkPlayerToPU()
{
  if (myPlayer.centerX + myPlayer.len >= myPowerUp.xPos
    && myPlayer.centerX - myPlayer.len <= myPowerUp.xPos + myPowerUp.len
    && myPlayer.centerY + myPlayer.r >= myPowerUp.yPos
    && myPlayer.centerY - myPlayer.r <= myPowerUp.yPos + myPowerUp.h)
  {
    println("Power up gotten");
    return true;
  }
  return false;
}

void gameOverScreen(boolean won)
{
  textSize(height/25);
  textAlign(CENTER, CENTER);
  if (won)
  {
    text("YOU WON!", width/2, height/4);
  } else
  {
    text("GAME OVER!", width/2, height/4);
  }
}
