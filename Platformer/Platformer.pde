import java.util.Arrays;

Screen spawn;

Body b1;
Body b2;
Body b3;

void setup() {
  frameRate(30);
  size(960, 528);
  
  rectMode(CENTER);
  
  spawn = new Screen("spawn");
  
  b1 = new Body(80, 80, 100, 100);
  b2 = new Body(80, 80, 250, 250);
  b3 = new Body(80, 100, 450, 450);
}

void draw() {
  background(255, 255, 255);
  
  spawn.draw(this);
  
  b1.draw(this);
  b2.draw(this);
  b3.draw(this);
  
  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX;
      b1.yOrigin = height - mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = height - mouseY;
    } else if (key == ' ') {
      key = '0';
      b3.xOrigin = mouseX;
      b3.yOrigin = mouseY;
    }
  }
  
  b1.update(1.0 / frameRate, 5, new ArrayList<Body>(Arrays.asList(new Body[] { b2, b3 })));
  
  println(frameRate);
}

void keyPressed() {
  switch (key) {
    case 'w': {
      b1.yVelocity = 150;
      
      break;
    }
    case 'a': {
      b1.xVelocity = -150;
      
      break;
    }
    case 's': {
      b1.yVelocity = -150;
      
      break;
    }
    case 'd': {
      b1.xVelocity = 150;
      
      break;
    }
  }
}

void keyReleased() {
  switch (key) {
    case 'w': {
      b1.yVelocity = 0;
      
      break;
    }
    case 'a': {
      b1.xVelocity = 0;
      
      break;
    }
    case 's': {
      b1.yVelocity = 0;
      
      break;
    }
    case 'd': {
      b1.xVelocity = 0;
      
      break;
    }
    default: {
      b1.xVelocity = 0;
      b1.yVelocity = 0;
    }
  }
}
