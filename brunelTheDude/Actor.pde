class Actor extends Object {
	HashMap<String, Animation> animations;
	HashMap<String, Dialogue> dialogue;
	Animation currentAnim;
	Dialogue speech;
	Boolean speaking;
	Actor(Coord loc, Coord sca, HashMap<String, Animation> anims, HashMap<String, Dialogue> dial){
		// constructor
		super(anims.get("rest").frames[0], loc, sca);
		animations = anims;
		dialogue = dial;
		currentAnim = anims.get("rest");
		speaking = false;
		speech = dialogue.get("hello"); // very, very bad
	}

	void setSpeech(String spch) {
		speech = dialogue.get(spch);
	}

	void moveMouth() {
		boolean flag = false;
		speech.fft.forward(speech.audio.mix);
		for (int i = 0; i < speech.fft.specSize() / 16; i++) { // only process the first 16th of the spectrum
			if((speech.fft.getBand(i)) > 20) {
				// move the mouth
				//animations.get("talk").playAnim();
				sprite = animations.get("talk").frames[0];
			}
			else {
				//sprite = animations.get("rest").frames[0];
			}
		}
	}

	void sayLine() {
		if (!speech.audio.isPlaying()) {
			speech.audio.play(0); // 0 means from the beginning
		}
	}

	void speak() {
		if (speech.audio.position() >= speech.audio.length()) {
			speaking = false;
		}
		if (speaking == true) {
			moveMouth();
		}


	}

	void update() {
		processMouse();
		//println(zoom.x);
		//println(location.x);
		sprite = currentAnim.frames[currentAnim.currentFrame];
	}

	void display() {
		speak();
		move();
		zoom();
		pushMatrix();
		scale(horient * zoom.x, zoom.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();

	}


}