class Actor extends Object {
	PImage restImg;
	PImage talkImg;
	PImage blinkImg;
	Actor(PImage rest, PImage talk, PImage blink, float posx, float posy, float scx, float scy){
		// constructor
		super(rest, posx, posy, scx, scy);
		restImg = rest;
		talkImg = talk;
		blinkImg = blink;
	}

	void talk(boolean mouthOpen) {
		if (mouthOpen == true) {
			sprite = talkImg;
		}
		else {
			sprite = restImg;
		}
	}

	void blink(boolean eyesOpen) {
		if (eyesOpen == true) {
			sprite = blinkImg;
		}
		else {
			sprite = restImg;
		}
	}

}