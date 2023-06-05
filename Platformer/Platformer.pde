import java.util.Arrays;

Screen spawn;

Body b1;
Body b2;

void setup() {
  frameRate(30);
  size(960, 528);
  
  rectMode(CENTER);
  
  spawn = new Screen("spawn");
  
  b1 = new Body(80, 100, 300, 120);
  b2 = new Body(80, 100, 50, 150);
  
  b1.yJerk = -5;
  b1.xJerk = 2;
}

void draw() {
  background(255, 255, 255);
  
  b1.yJerk = -5;
  b1.xJerk = 2;
  
  spawn.draw(this);
  
  b1.draw(this);
  b2.draw(this);
  
  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX;
      b1.yOrigin = height - mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = height - mouseY;
    }
  }
  
  b1.update(1.0 / 60.0, 5, new ArrayList<Body>(Arrays.asList(new Body[] { b2 })));
  
  println(frameRate);
}
