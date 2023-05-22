public class Location {
  int xPos;
  int yPos;
  
  public Location(int xPos, int yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public Location(String loc) {
    if (loc.charAt(loc.length() - 1) == '\n') {
      loc = loc.substring(0, loc.length() - 1);
    }
    
    this.xPos = Integer.parseInt(loc.substring(0, loc.indexOf(",")));
    this.yPos = Integer.parseInt(loc.substring(loc.indexOf(",") + 1));
  }
  
  public String toString() {
    return "(" + this.xPos + ", " + this.yPos + ")";
  }
}
