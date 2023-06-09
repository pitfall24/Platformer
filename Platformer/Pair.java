public class Pair<T1, T2> {
  T1 first;
  T2 second;

  public Pair(T1 first, T2 second) {
    this.first = first;
    this.second = second;
  }

  public Pair() {
    this.first = null;
    this.second = null;
  }
  
  public String toString() {
    return "{" + this.first.toString() + ", " + this.second.toString() + "}";
  }
}
