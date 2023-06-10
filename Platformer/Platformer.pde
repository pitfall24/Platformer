import java.util.Arrays;

Screen spawn;

//Actor b1;
//Actor b2;

String newName;

int tileInd;
ArrayList<Tile> palette;

boolean hasHitbox;
boolean canInteract;

void setup() {
  //try { refreshBinaries(); } catch (Exception e) { e.printStackTrace(); println("refresh error ^^"); } exit(); return;

  frameRate(30);
  size(960, 528);

  rectMode(CENTER);

  spawn = new Screen("spawn");
  
  newName = "test";

  tileInd = 0;
  palette = new ArrayList<Tile>();

  for (File file : new File(absoluteRepoPath() + "resources/textures/tiles/").listFiles()) {
    try {
      palette.add(new Tile(removeExtension(file.getName()), absoluteRepoPath() + "resources/textures/bin/" + removeExtension(file.getName()) + ".bin", hasHitbox, canInteract, 0, 0));
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  hasHitbox = true;
  canInteract = false;

  //b1 = new Actor(8, 10, 25, 40, absoluteRepoPath() + "resources/textures/bin/player.bin", -2.5, 0.0);
  //b2 = new Actor(8, 10, 25, 25);
}

void draw() {
  background(128, 255, 255);

  spawn.draw(this);
  spawn.drawHitboxes(this);
  
  //println(frameRate);
  //b1.draw(this, spawn.width, spawn.height);
  //b2.draw(this, spawn.width, spawn.height);

  //b1.drawHitbox(this, spawn.width, spawn.height);

  /*
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
   */
}

void mouseReleased() {
  int x = mouseX / (width / spawn.width);
  int y = spawn.height - mouseY / (height / spawn.height);

  Tile tile = new Tile(palette.get(tileInd));
  
  tile.hitbox = new Body(8, 8, x * 8 + 4.0, (y - 1) * 8 + 4.0);
  tile.xPosition = x * 8;
  tile.yPosition = (y - 1) * 8;

  tile.hasHitbox = hasHitbox;
  tile.canInteract = canInteract;

  spawn.screen[spawn.height - y][x] = tile;
}

void keyReleased() {
  switch (keyCode) {
  case ENTER:
    {
      try {
        spawn.writeScreen(absoluteRepoPath() + "resources/worlds/screens/" + newName + ".txt", newName);
        exit();
      }
      catch (Exception e) {
        e.printStackTrace();
        return;
      }
    }
  }

  switch (key) {
  case 'h':
    {
      hasHitbox = !hasHitbox;
      println("hasHitbox=" + hasHitbox);
      break;
    }
  case 'i':
    {
      canInteract = !canInteract;
      println("canInteract=" + canInteract);
      break;
    }
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    tileInd = (tileInd + 1) % palette.size();
  } else if (event.getCount() < 0) {
    tileInd = (tileInd - 1) % palette.size();
  }
  
  println("tileInd=" + tileInd + ", tilename=" + palette.get(tileInd).name);
}

/*
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
 */
