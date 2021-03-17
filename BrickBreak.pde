Player myPlayer;
Ball[] balls = new Ball[4]; 
int ballsInPlay, maxBalls;
Brick[] row1 = new Brick[20];
Brick[] row2 = new Brick[20];
Brick[] row3 = new Brick[20];
Brick[] row4 = new Brick[20];
float xBrickStart, yBrickStart;
int brickHitBuffer;

PowerUp myPowerUp;

boolean buff;
int buffMax;

int brickAmount;

boolean gameOn, gameOver, gameWon;

void setup()
{
  colorMode(HSB, 360, 100, 100);
  size(1000, 1000);
  ballsInPlay = 1;
  maxBalls = 5;

  xBrickStart = width/20;
  yBrickStart = height/10;
  brickHitBuffer = 0;

  brickAmount = 80;

  row1 = brickBuilder(xBrickStart, yBrickStart);
  yBrickStart += 25;
  row2 = brickBuilder(xBrickStart, yBrickStart);
  yBrickStart += 25;
  row3 = brickBuilder(xBrickStart, yBrickStart);
  yBrickStart += 25;
  row4 = brickBuilder(xBrickStart, yBrickStart);

  gameOn = false;
  gameOver = false;

  buff = false;
  buffMax = 5;

  myPlayer = new Player();
  balls[0] = new Ball();
}

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

Brick[] brickBuilder(float xStart, float yStart)
{
  Brick[] bricks = new Brick[20]; 
  float brickCol = random(360);
  for (int i = 0; i < 20; i++)
  {
    bricks[i] = new Brick(xStart, yStart, brickCol);
    xStart += 45;
    brickCol = (brickCol + 2)%360;
  }
  return bricks;
}


void game()
{
  background(360);

  drawRow(row1);
  drawRow(row2);
  drawRow(row3);
  drawRow(row4);

  if (buff)
  {
    myPowerUp.move();
    myPowerUp.drawPU();
    if (checkPlayerToPU())
    {
      if (myPowerUp.type != 1)
      {
        myPowerUp.display = false;
        buff = false;
        println(myPowerUp.type);
        myPlayer.powerUp(myPowerUp.type);
      }
      else
      {
        if(ballsInPlay < maxBalls)
        {
          balls[ballsInPlay] = new Ball();
        }
      }
    }
  }

  myPlayer.drawPlayer();
  myPlayer.direction();
  myPlayer.move();

for(int b = 0; b < ballsInPlay; b++)
{
  balls[b].drawBall();
  balls[b].moveBall();
  balls[b].hitPlayer();
  balls[b].hitWall();
}

  brickHitBuffer--;
}

void drawRow(Brick[] row)
{
  for (int i = 0; i < 20; i++)
  {
    if (row[i].display)
    {
      row[i].drawBrick();
      checkBrickToBall(row[i]);
    }
  }
}

void checkBrickToBall(Brick brick)
{
  int hit = brick.hitByBall(balls[0].xPos, balls[0].yPos, balls[0].r);
  if (hit > 0 && brickHitBuffer < 0)
  {
    if (hit == 1)
    {
      balls[0].newDir(false);
    } else
    {
      balls[0].newDir(true);
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

boolean checkPlayerToPU()
{
  if (myPlayer.centerX + myPlayer.len >= myPowerUp.xPos
    && myPlayer.centerX - myPlayer.len <= myPowerUp.xPos + myPowerUp.len
    && myPlayer.centerY + myPlayer.r >= myPowerUp.yPos
    && myPlayer.centerY - myPlayer.r <= myPowerUp.yPos + myPowerUp.h)
  {
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
