class Zoom extends Event {
	Coord startSize;
	Coord endSize;

	Zoom(Object obj, float stime, float d, Coord sSize, Coord eSize) {
		super(obj, stime, d);
		startSize = sSize;
		endSize = eSize;
	}

	void resize() {
		if (object.scaleCoord.x > endSize.x) {
			object.scaleCoord.x -= speed;
		}
		else if (object.scaleCoord.x < endSize.x) {
			object.scaleCoord.x += speed;
		}

		if (object.scaleCoord.y > endSize.y) {
			object.scaleCoord.y -= speed;
		}
		else if (object.scaleCoord.y < endSize.y) {
			object.scaleCoord.y += speed;
		}
	}

	void update() {
		if (running) {
			if (elapsed >= dur) {
				stopEvent();
			}
			else {
				elapsed++;
				resize();
			}
		}
	}

}