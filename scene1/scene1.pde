
final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 1.3;

Scene scene;
Actor brunel;

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

	HashMap<String, PImage> brunelSprites = new HashMap<String, PImage>();
	brunelSprites.put("rest", loadImage("pics/brunel.png"));
	brunelSprites.put("talk", loadImage("pics/brunelTalk.png"));
	brunelSprites.put("blink", loadImage("pics/brunelBlink.png"));


	/*
	PImage brunelimg = loadImage("pics/brunel.png");
	PImage brunelTalk = loadImage("pics/brunelTalk.png");
	PImage brunelBlink = loadImage("pics/brunelBlink.png");
	*/
	scene = new Scene(float(screenWidth), float(screenHeight), bgimg);

	//Actor brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);

	brunel = new Actor(brunelSprites, brunelDialogue, 400, 100, scalef, scalef);

	brunel.fliph();
}

void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	//println("X: " + brunel.x + "  Y: " + brunel.y);
}

