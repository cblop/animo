
final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 1.3;

Scene scene;
Actor brunel;
//Event[] events;
//Actor[] actors;

void setup() {
	//addScreen("scene", new Scene(screenWidth, screenHeight));
	size(screenWidth, screenHeight);
	PImage bgimg = loadImage("pics/cliftonBridgeBW.jpg");

	HashMap<String, Dialogue> brunelDialogue = new HashMap<String, Dialogue>();
	brunelDialogue.put("cool", new Dialogue("sounds/cool_man.mp3"));
	brunelDialogue.put("laugh", new Dialogue("sounds/dude_laugh.mp3"));
	brunelDialogue.put("hello", new Dialogue("sounds/hello_man.mp3"));
	brunelDialogue.put("disco", new Dialogue("sounds/love_disco.mp3"));
	brunelDialogue.put("wassup", new Dialogue("sounds/wassup.mp3"));

	PImage[] brunelRest = {loadImage("pics/brunel.png")};
	PImage[] brunelTalk = {loadImage("pics/brunelTalk.png")};

	HashMap<String, Animation> brunelAnims = new HashMap<String, Animation>();
	brunelAnims.put("rest", new Animation(brunelRest));
	brunelAnims.put("talk", new Animation(brunelTalk));
	//brunelSprites.put("talk", loadImage("pics/brunelTalk.png"));
	//brunelSprites.put("blink", loadImage("pics/brunelBlink.png"));


	brunel = new Actor(new Coord(400, 100), new Coord(scalef, scalef), brunelAnims, brunelDialogue);
	/*
	PImage brunelimg = loadImage("pics/brunel.png");
	PImage brunelTalk = loadImage("pics/brunelTalk.png");
	PImage brunelBlink = loadImage("pics/brunelBlink.png");
	*/
	Event[] events = {
		//new MoveEvent(brunel, 100.0, 200.0, new Coord(500, 500)), 
		new MoveEvent(brunel, 100.0, 20.0, new Coord(0, 0)),
		new ZoomEvent(brunel, 100.0, 20.0, new Coord(3.0, 3.0)),
		new SpeakEvent(brunel, 100.0, 20.0, "cool"),
		new MoveEvent(brunel, 200.0, 200.0, new Coord(100, 0)),
		new ZoomEvent(brunel, 200.0, 200.0, new Coord(1.0, 1.0)),
		new ZoomEvent(brunel, 300.0, 10.0, new Coord(1.0, 1.0)),
		new MoveEvent(brunel, 300.0, 200.0, new Coord(400, 0)),
		new SpeakEvent(brunel, 400.0, 20.0, "disco"),
	};

	Actor[] actors = {brunel};

	scene = new Scene(float(screenWidth), float(screenHeight), bgimg, events, actors);
	scene.runEvents();

	//Actor brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);


	//brunel.fliph();
}

void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	//println("X: " + brunel.x + "  Y: " + brunel.y);
}

