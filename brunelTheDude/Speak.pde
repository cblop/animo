class Speak extends Event {
	Dialogue dialogue;
	Animation anim;
	Speak(Actor act, float sTime, float d, Dialogue dial, Animation ani) {
		super(act, sTime, d);
		dialogue = dial;
		anim = ani;
	}

	void playAudio() {
		dialogue.audio.play(0);
	}

	void moveMouth() {
		boolean flag = false;
		dialogue.fft.forward(dialogue.audio.mix);
		for (int i = 0; i < dialogue.fft.specSize() / 16; i++) { // only process the first 16th of the spectrum
			if((dialogue.fft.getBand(i)) > 20) {
				// move the mouth
				anim.startEvent();
			}
		}
	}

	void update() {
		if (running == true) {
			if (!dialogue.audio.isPlaying) {
				moveMouth();
				playAudio();
			}
			if (dialogue.audio.position() >= dialogue.audio.length()) {
				stopEvent();
			}
		}
	}

}