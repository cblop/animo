
final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 1.3; // size of the actor

Scene scene;
Actor brunel;

void setup() {
	size(screenWidth, screenHeight);
	PImage bgimg = loadImage("pics/cliftonBridgeBW.jpg"); // background image

	// put brunel's dialogue into a hash map
	HashMap<String, Dialogue> brunelDialogue = new HashMap<String, Dialogue>();
	brunelDialogue.put("cool", new Dialogue("sounds/cool_man.mp3"));
	brunelDialogue.put("laugh", new Dialogue("sounds/dude_laugh.mp3"));
	brunelDialogue.put("hello", new Dialogue("sounds/hello_man.mp3"));
	brunelDialogue.put("disco", new Dialogue("sounds/love_disco.mp3"));
	brunelDialogue.put("wassup", new Dialogue("sounds/wassup.mp3"));

	// these are brunel's animations, only one frame each for now
	PImage[] brunelRest = {loadImage("pics/brunel.png")};
	PImage[] brunelTalk = {loadImage("pics/brunelTalk.png")};
	PImage[] brunelBlink = {loadImage("pics/brunelBlink.png")};

	// animations in a hash map
	HashMap<String, Animation> brunelAnims = new HashMap<String, Animation>();
	brunelAnims.put("rest", new Animation(brunelRest));
	brunelAnims.put("talk", new Animation(brunelTalk));
	brunelAnims.put("blink", new Animation(brunelBlink));

	// initialise the Brunel actor
	brunel = new Actor(new Coord(400, 100), new Coord(scalef, scalef), brunelAnims, brunelDialogue);

	// this is a list of all the events for the animation
	Event[] events = {
		// MoveEvent arguments: object, start time, duration, target location
		new MoveEvent(brunel, 100.0, 20.0, new Coord(0, 0)),
		// ZoomEvent arguments: object, start time, duration, target sprite size
		new ZoomEvent(brunel, 100.0, 20.0, new Coord(3.0, 3.0)),
		// SpeakEvent arguments: object, start time, duration, hash map string for line
		new SpeakEvent(brunel, 100.0, 20.0, "cool"),
		new MoveEvent(brunel, 200.0, 200.0, new Coord(100, 0)),
		new ZoomEvent(brunel, 200.0, 200.0, new Coord(1.0, 1.0)),
		new ZoomEvent(brunel, 300.0, 10.0, new Coord(1.0, 1.0)),
		new MoveEvent(brunel, 300.0, 200.0, new Coord(400, 0)),
		new SpeakEvent(brunel, 400.0, 20.0, "disco"),
	};

	Actor[] actors = {brunel}; // list of all actors in the scene

	// create and run the scene
	scene = new Scene(float(screenWidth), float(screenHeight), bgimg, events, actors);
	scene.runEvents();
}

void draw() {
	// just update the scene and actors
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
}

