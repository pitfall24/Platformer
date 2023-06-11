public class Background extends Layer {
  String path;
  PImage image;
  PImage imageC;
  
  public Background(String path) {
    this.path = path;
    this.image = loadImage(path);
    this.imageC = null;
  }
  
  public Background(PImage image) {
    this.path = "";
    this.image = image;
    this.imageC = null;
  }
  
  public void draw(PApplet sketch) {
    if (this.imageC == null) {
      double targetAspect = (double) sketch.width / sketch.height;
      double currentAspect = (double) this.image.width / this.image.height;
      
      if (currentAspect < targetAspect) {
        this.imageC = this.image.get(0, 0, this.image.width, (int) (this.image.height * currentAspect / targetAspect));
      } else if (currentAspect > targetAspect) {
        this.imageC = this.image.get(0, 0, (int) (this.image.width * currentAspect / targetAspect), this.image.height);
      } else {
        this.imageC = this.image.get();
      }
    }
    
    sketch.image(imageC, 0.0, 0.0, sketch.width, sketch.height);
  }
}
