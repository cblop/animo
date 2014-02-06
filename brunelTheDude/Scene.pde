
class Scene {
	PImage bgimage;
	float sceneWidth;
	float sceneHeight;
	Event[] events;
	Actor[] actors;
	float timePassed;
	boolean running;

	Scene(float sWidth, float sHeight, PImage bgi, Event[] es, Actor[] acts){
		sceneWidth = sWidth;
		sceneHeight = sHeight;
		bgimage = bgi;

		events = es;
		actors = acts;
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
	void display() {
		// show the background image
		image(bgimage, 0, 0, sceneWidth, sceneHeight);
	}
}