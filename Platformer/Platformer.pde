import java.util.Arrays;

Screen spawn;

Actor b1;
Actor b2;

void setup() {
  frameRate(30);
  size(960, 528);

  rectMode(CENTER);

  spawn = new Screen("spawn");

  b1 = new Actor(80, 100, 100, 100);
  b2 = new Actor(80, 100, 250, 250);
  
  //try { spawn.writeScreen(absoluteRepoPath() + "resources/worlds/screens/test.txt"); } catch (Exception e) { e.printStackTrace(); }
  //exit();
}

void draw() {
  background(255, 255, 255);

  spawn.draw(this);
  spawn.drawHitboxes(this);
  
  fill(255, 0, 0);
  noStroke();
  
  b1.draw(this, spawn.width, spawn.height);
  b2.draw(this);

  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xVelocity = mouseX - b1.xOrigin;
      b1.yVelocity = mouseY - b1.yOrigin;

      b1.xOrigin = mouseX;
      b1.yOrigin = height - mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = height - mouseY;
    }
  }

  b1.update(this, 1.0 / frameRate, 5, new ArrayList<Body>(Arrays.asList(new Body[] { b2 })), false);
  b2.blindUpdate(1.0 / frameRate);

  b1.update(this, 1.0 / frameRate, 5, spawn, true);

  println(frameRate);
}

void keyPressed() {
  switch (key) {
  case 'w':
    {
      b1.yVelocity = 150;

      break;
    }
  case 'a':
    {
      b1.xVelocity = -150;

      break;
    }
  case 's':
    {
      b1.yVelocity = -150;

      break;
    }
  case 'd':
    {
      b1.xVelocity = 150;

      break;
    }
  }
}

void keyReleased() {
  switch (key) {
  case 'w':
    {
      b1.yVelocity = 0;

      break;
    }
  case 'a':
    {
      b1.xVelocity = 0;

      break;
    }
  case 's':
    {
      b1.yVelocity = 0;

      break;
    }
  case 'd':
    {
      b1.xVelocity = 0;

      break;
    }
  default:
    {
      b1.xVelocity = 0;
      b1.yVelocity = 0;
    }
  }
}
