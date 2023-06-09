import java.util.Arrays;

Screen spawn;

Actor b1;
Actor b2;

void setup() {
  //try { refreshTileBinaries(); } catch (Exception e) {}
  //exit();
  
  frameRate(30);
  size(960, 528);

  rectMode(CENTER);

  spawn = new Screen("spawn");

  b1 = new Actor(8, 10, 25, 40, absoluteRepoPath() + "resources/textures/bin/player.bin", 0.0, 0.0);
  b2 = new Actor(8, 10, 25, 25);
  
  //try { spawn.writeScreen(absoluteRepoPath() + "resources/worlds/screens/test.txt"); } catch (Exception e) { e.printStackTrace(); }
  //exit();
}

void draw() {
  background(255, 255, 255);

  spawn.draw(this);
  
  fill(255, 0, 0);
  noStroke();
  
  b1.draw(this, spawn.width, spawn.height);
  b2.draw(this, spawn.width, spawn.height);
  
  //b1.drawHitbox(this, spawn.width, spawn.height);

  if (mousePressed) {
    // fix this. scale by what to make one-to-one?
    
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX / 4;
      b1.yOrigin = (height - mouseY) / 5;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX / 4;
      b2.yOrigin = (height - mouseY) / 5;
    }
  }

  b1.update(this, 1.0 / frameRate, 15, new ArrayList<Body>(Arrays.asList(new Body[] { b2 })), false);
  b2.blindUpdate(1.0 / frameRate);

  b1.update(this, 1.0 / frameRate, 15, spawn, false);

  println(frameRate);
}

void keyPressed() {
  switch (key) {
  case 'w':
    {
      b1.yVelocity = 50;

      break;
    }
  case 'a':
    {
      b1.xVelocity = -50;

      break;
    }
  case 's':
    {
      b1.yVelocity = -50;

      break;
    }
  case 'd':
    {
      b1.xVelocity = 50;

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
