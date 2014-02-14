class SpeakEvent extends Event {
	Actor actor;
	String dialogue;
	SpeakEvent(Actor act, float sTime, float d, String dial) {
		super(act, sTime, d);
		actor = act;
		dialogue = dial;
	}

	void trigger() {
		running = true;
		actor.setSpeech(dialogue);
		actor.sayLine();
		actor.speaking = true;
	}
	
	void stop() {
		running = false;
	}

}