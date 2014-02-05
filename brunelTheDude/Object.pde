
class Object {
	PImage sprite;
	Coord location;
	Coord scaleCoord;
	float horient;

	Object(PImage spr, Coord loc, Coord sca){
		sprite = spr;
		location = loc;
		scaleCoord = sca;
		horient = 1.0;
	}


/*
	void moveTo(float posx, float posy, float spd) {
		targetx = posx;
		targety = posy;
		speed = spd;
	}
*/


/*
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
	*/

	void update() {
		//processMouse();
	}

	void display() {
		pushMatrix();
		scale(horient * scaleCoord.x, scaleCoord.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();
	}
}