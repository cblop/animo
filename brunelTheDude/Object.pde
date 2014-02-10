
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
		target = loc;
		zoom = sca;
		zoomTarget = sca;
		horient = 1.0;
	}

	void processMouse() {
		if (mousePressed) {
			moveTo(mouseX - (sprite.width / 2), mouseY - (sprite.height / 2), 1.0);

			if (target.x > location.x && horient == 1.0){
				//println("flip1");
				fliph();
			}
			else if (target.x < location.x && horient == -1.0){
				//println("flip2");
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
		if (location.x > target.x) {
			location.x -= speed;
		}
		else if (location.x < target.x) {
			location.x += speed;
		}

		if (location.y > target.y) {
			location.y -= speed;
		}
		else if (location.y < target.y) {
			location.y += speed;
		}
	}

	void zoom() {
		if (zoom.x > zoomTarget.x) {
			zoom.x -= zoomSpeed;
		}
		else if (zoom.x < zoomTarget.x) {
			zoom.x += zoomSpeed;
		}

		if (zoom.y > zoomTarget.y) {
			zoom.y -= zoomSpeed;
		}
		else if (zoom.y < zoomTarget.y) {
			zoom.y += zoomSpeed;
		}
	}

	void update() {
		//processMouse();
		move();
		zoom();
	}

	void display() {
		pushMatrix();
		scale(horient * scaleCoord.x, scaleCoord.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();
	}
}