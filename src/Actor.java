import java.util.ArrayList;

public class Actor extends Body {
	int width, height;

	int facing;

	boolean onGround;
	boolean dashing;
	boolean grabbing;
	boolean crouching;

	public Actor(int width, int height, int xOrigin, int yOrigin) {
		super(width, height, xOrigin, yOrigin);

		this.width = width;
		this.height = height;

		this.facing = 0;

		this.onGround = true;
		this.dashing = false;
		this.grabbing = false;
		this.crouching = false;
	}

	public ArrayList<Body> checkEntityCollisions(ArrayList<Body> bodies) {
		ArrayList<Body> out = new ArrayList<Body>();

		for (Body body : bodies) {
			if (this.colliding(body)) {
				out.add(body);
			}
		}

		return out;
	}

	public void update(double deltaT) {
		double elapsed = 0.0;
		// move forward pixel by pixel along with time until `elapsed (>)= deltaT`

	}
}