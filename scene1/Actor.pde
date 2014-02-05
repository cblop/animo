class Actor extends Object {
	PImage restImg;
	PImage talkImg;
	PImage blinkImg;
	float blinkProb;
	HashMap<String, Dialogue> dialogue;
	HashMap<String, PImage> sprites;
	boolean talkWobble;
	boolean walkWobble;
	boolean blinking;
	boolean moving;
	int blinkTime;
	Actor(HashMap<String, PImage> sprs, HashMap<String, Dialogue> dial, float posx, float posy, float scx, float scy){
		// constructor
		super(sprs.get("rest"), posx, posy, scx, scy);
		sprites = sprs;
		dialogue = dial;
		blinkProb = 0.1;
		talkWobble = false;
		walkWobble = false;
		blinking = false;
		blinkTime = 0;
	}

	void mouth(boolean mouthOpen) {
		if (mouthOpen == true) {
			sprite = sprites.get("talk");
		}
		else {
			sprite = sprites.get("rest");
		}
	}

	void blink(boolean eyesShut) {
		if (eyesShut == true) {
			println("blinking");
			sprite = sprites.get("blink");
		}
		else {
			sprite = sprites.get("rest");
		}
	}


	void update() {
		processMouse();
		moveToTarget();
		String[] lines = {"cool", "laugh", "hello", "disco", "wassup"};
		boolean flag = false;
		boolean mouthOpen = false;
		if (blinking == true) {
			if (blinkTime > 10) {
				blinkTime = 0;
				blinking = false;
				blink(false);
			}
			else {
				blinkTime++;
			}
		}

		for (int i = 0; i < lines.length; i++) {
			Dialogue d = dialogue.get(lines[i]);
			if (d.audio.isPlaying()) {
				d.fft.forward(d.audio.mix);
				for (int j = 0; j < d.fft.specSize() / 16; j++) {
					//println(d.fft.getBand(j)*8);
					if ((d.fft.getBand(j)) > 20) {
						mouthOpen = true;
					}
				}
				flag = true;
			}
		}

		if (random(100) <= 1) {
			if (flag == false) {
				dialogue.get(lines[int(random(lines.length))]).audio.play(0);
			}
		}

		if (random(50) <= 1) {
			blinking = true;
			blink(true);
		}

		if (mouthOpen == true) {
			mouth(true);
		}
		else {
			if (blinking == false) {
				mouth(false);
			}
		}
	}


}