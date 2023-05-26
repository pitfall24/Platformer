Screen spawn;

Body b1;
Body b2;

void setup() {
  size(960, 528);
  
  rectMode(CENTER);
  
  spawn = new Screen("spawn");
  
  b1 = new Body(80, 100, 90, 120);
  b2 = new Body(8, 10, 50, 150);
}

void draw() {
  background(255, 255, 255);
    
  b1.draw(this);
  b2.draw(this);
  
  spawn.draw(this);
    
  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX;
      b1.yOrigin = mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = mouseY;
    }
  }
}
