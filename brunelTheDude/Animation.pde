class Animation {
	PImage[] frames;
	int currentFrame;
	boolean running;
	Animation(PImage[] frms){
		frames = frms;
		currentFrame = 0;
	}

	void playAnim() {
		running = true;
		currentFrame++;
	}

	void stopAnim() {
		running = false;
		currentFrame = 0;
	}

	void update() {
		if (running) {
			playAnim();
			if (currentFrame >= frames.length) {
				stopAnim();
			}
		}

	}
}