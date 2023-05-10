public class Body {
	int width, height;
	double xOrigin, yOrigin;
	double xVelocity, yVelocity;
	double xAcceleration, yAcceleration;
	double xJerk, yJerk;

	public Body(int width, int height, double xOrigin, double yOrigin) {
		this.width = width;
		this.height = height;

		this.xOrigin = xOrigin;
		this.yOrigin = yOrigin;

		this.xVelocity = 0.0;
		this.yVelocity = 0.0;
		this.xAcceleration = 0.0;
		this.yAcceleration = 0.0;
		this.xJerk = 0.0;
		this.yJerk = 0.0;
	}

	public void setPosition(double xOrigin, double yOrigin) {
		this.xOrigin = xOrigin;
		this.yOrigin = yOrigin;
	}

	public int getIntXPosition() {
		return (int) Math.round(this.xOrigin);
	}

	public int getIntYPosition() {
		return (int) Math.round(this.yOrigin);
	}

	public boolean colliding(Body other) {
		return this.xOrigin + width > 0;
	}
}