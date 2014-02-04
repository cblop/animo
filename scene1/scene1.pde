final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 0.7;

Scene scene;
Actor brunel;

void setup() {
	//addScreen("scene", new Scene(screenWidth, screenHeight));
	size(screenWidth, screenHeight);
	PImage bgimg = loadImage("pics/cliftonBridgeBW.jpg");
	PImage brunelimg = loadImage("pics/brunel.png");
	PImage brunelTalk = loadImage("pics/brunelTalk.png");
	PImage brunelBlink = loadImage("pics/brunelBlink.png");
	scene = new Scene(float(screenWidth), float(screenHeight), bgimg);
	brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);
	brunel.fliph();
}

void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	println("X: " + brunel.x + "  Y: " + brunel.y);
}

