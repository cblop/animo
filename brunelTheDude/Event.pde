class Event {
	float startTime;
	float dur;
	float elapsed;
	float speed;
	boolean running;

	Event(float sTime, float d) {
		startTime = sTime;
		dur = d;
		elapsed = 0;
		running = false;
		speed = dur / frameRate;
	}

	void startEvent() {
		running = true;
	}

	void stopEvent() {
		running = false;
	}

}