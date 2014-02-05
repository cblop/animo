class Movement extends Event {
	//Actor actor;
	Coord startloc;
	Coord endloc;

	// Move an object
	Movement(Object obj, float stime, float d, Coord sloc, Coord eloc) {
		super(obj, stime, d);
		startloc = sloc;
		endloc = eloc;

	}

	void fliph() {
		if (object.horient == 1.0) {
			object.location.x += (0.5 * object.sprite.width);
			endloc.x += (0.5 * object.sprite.width);
			object.horient = -1.0;
		}
		else {
			object.location.x -= (0.5 * object.sprite.width);
			endloc.x -= (0.5 * object.sprite.width);
			object.horient = 1.0;
		}
	}

	void move() {
		if (object.location.x > endloc.x) {
			object.location.x -= speed;
		}
		else if (object.location.x < endloc.x) {
			object.location.x += speed;
		}

		if (object.location.y > endloc.y) {
			object.location.y -= speed;
		}
		else if (object.location.y < endloc.y) {
			object.location.y += speed;
		}
	}

	void update() {
		if (running) {
			if (elapsed >= dur) {
				stopEvent();
			}
			else {
				elapsed++;
				move();
			}
		}

	}

}