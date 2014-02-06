class Animation extends Event {
	PImage[] frames;
	int currentFrame;
	Animation(Object obj, float sTime, float d, PImage[] frms){
		super(obj, sTime, d);
		frames = frms;
		currentFrame = 0;
	}

	void playAnim() {
		object.sprite = frames[currentFrame];
		currentFrame++;
	}

	void update() {
		if (running) {
			playAnim();
			if (currentFrame >= frames.length) {
				stopEvent();
			}
		}

	}
}