class Timeline {
	Event[] events;
	float timePassed;
	boolean running;

	Timeline(Event[] es) {
		events = es;
		timePassed = 0.0;
		running = false;

	}

	void runEvents() {
		running = true;
	}

	void update() {
		if (running == true) {
			timePassed++;
			for (int i = 0; i < events.length; i++) {
				if (events[i].startTime == timePassed) {
					events[i].startEvent();
				}
			}
		}

	}
}