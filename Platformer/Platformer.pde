Screen spawn;

Body b1;
Body b2;

void setup() {
  size(600, 400);
  
  rectMode(CENTER);
  
  spawn = new Screen("spawn");
  
  b1 = new Body(80, 100, 90, 120);
  b2 = new Body(8, 10, 50, 150);
}

void draw() {
  background(255, 255, 255);
  
  //rect((float) b1.xOrigin, (float) b1.yOrigin, (float) b1.width, (float) b1.height);
  //rect((float) b2.xOrigin, (float) b2.yOrigin, (float) b2.width, (float) b2.height);
  
  b1.draw(this);
  b2.draw(this);
  
  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX;
      b1.yOrigin = mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = mouseY;
    }
  }
  
  System.out.println(b1.colliding(b2));
}
