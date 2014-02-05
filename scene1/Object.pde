
class Object {
	PImage sprite;
	float x;
	float y;
	float scalex;
	float scaley;
	float targetx;
	float targety;
	float speed;
	float horient;

	Object(PImage spr, float posx, float posy, float scx, float scy){
		sprite = spr;
		x = posx;
		y = posy;
		targetx = posx;
		targety = posy;
		scalex = scx;
		scaley = scy;
		horient = 1.0;
		speed = 3.0;
	}

	void fliph() {
		if (horient == 1.0) {
			x += (0.5 * sprite.width);
			targetx += (0.5 * sprite.width);
			horient = -1.0;
		}
		else {
			x -= (0.5 * sprite.width);
			targetx -= (0.5 * sprite.width);
			horient = 1.0;
		}
	}

	void moveTo(float posx, float posy, float spd) {
		targetx = posx;
		targety = posy;
		speed = spd;
	}

	void moveToTarget() {
		if (x > targetx) {
			x -= speed;
		}
		else if (x < targetx) {
			x += speed;
		}

		if (y > targety) {
			y -= speed;
		}
		else if (y < targety) {
			y += speed;
		}
	}

	void processMouse() {
		if (mousePressed) {
			moveTo(mouseX - (sprite.width / 2), mouseY - (sprite.height / 2), 1.0);

			if (targetx > x && horient == 1.0){
				//println("flip1");
				fliph();
			}
			else if (targetx < x && horient == -1.0){
				//println("flip2");
				fliph();
			}
		}
	}

	void update() {
		processMouse();
		moveToTarget();
	}

	void display() {
		pushMatrix();
		scale(horient * scalex, scaley);
		image(sprite, horient * x, y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();
	}
}