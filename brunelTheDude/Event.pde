class Event {
	Object object;
	float startTime;
	float dur;
	float elapsed;
	float speed;
	boolean running;

	Event(Object obj, float sTime, float d) {
		object = obj;
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