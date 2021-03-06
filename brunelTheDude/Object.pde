
class Object {
	PImage sprite;
	Coord location;
	Coord target;
	Coord zoom;
	Coord zoomTarget;
	float zoomSpeed;
	float speed;
	float horient;

	Object(PImage spr, Coord loc, Coord sca){
		sprite = spr;
		location = loc;
		target = location;
		zoom = sca;
		zoomTarget = sca;
		horient = 1.0;
	}

	void processMouse() {
		if (mousePressed) {
			moveTo(new Coord(mouseX - (sprite.width / 2), mouseY - (sprite.height / 2)), 3.0);

			if (target.x > location.x && horient == 1.0){
				fliph();
			}
			else if (target.x < location.x && horient == -1.0){
				fliph();
			}
		}
	}

	void fliph() {
		if (horient == 1.0) {
			location.x += (0.5 * sprite.width);
			target.x += (0.5 * sprite.width);
			horient = -1.0;
		}
		else {
			location.x -= (0.5 * sprite.width);
			target.x -= (0.5 * sprite.width);
			horient = 1.0;
		}
	}

	void moveTo(Coord trgt, float spd) {
		target = trgt;
		speed = spd;
	}


	void move() {
		Coord toTarget = new Coord(target.x - location.x, target.y - location.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		toTarget.x = toTarget.x / toTargetLength;
		toTarget.y = toTarget.y / toTargetLength;

		// this is a kludge?
		if (toTargetLength > speed) {
			location.x += toTarget.x * speed;
			location.y += toTarget.y * speed;
		}

	}

	void zoomTo(Coord trgt, float spd) {
		zoomTarget = trgt;
		zoomSpeed = spd;
	}

	void zoom() {
		// duplicated code - too similar to move()
		Coord toTarget = new Coord(zoomTarget.x - zoom.x, zoomTarget.y - zoom.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		toTarget.x = toTarget.x / toTargetLength;
		toTarget.y = toTarget.y / toTargetLength;

		// this is a kludge?
		if (toTargetLength > zoomSpeed) {
			zoom.x += toTarget.x * zoomSpeed;
			zoom.y += toTarget.y * zoomSpeed;
		}

	}

	void update() {
		processMouse();
	}

	void display() {
		move();
		zoom();
		pushMatrix();
		scale(horient * zoom.x, zoom.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		popMatrix();
	}
}