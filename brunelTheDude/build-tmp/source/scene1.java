import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.analysis.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class scene1 extends PApplet {


final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 1.3f;

Scene scene;
Actor brunel;

public void setup() {
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
	scene = new Scene(PApplet.parseFloat(screenWidth), PApplet.parseFloat(screenHeight), bgimg);

	//Actor brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);

	brunel = new Actor(brunelSprites, brunelDialogue, 400, 100, scalef, scalef);

	brunel.fliph();
}

public void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	//println("X: " + brunel.x + "  Y: " + brunel.y);
}

class Actor extends Object {
	PImage restImg;
	PImage talkImg;
	PImage blinkImg;
	float blinkProb;
	HashMap<String, Dialogue> dialogue;
	HashMap<String, PImage> sprites;
	boolean talkWobble;
	boolean walkWobble;
	boolean blinking;
	boolean moving;
	int blinkTime;
	Actor(HashMap<String, PImage> sprs, HashMap<String, Dialogue> dial, float posx, float posy, float scx, float scy){
		// constructor
		super(sprs.get("rest"), posx, posy, scx, scy);
		sprites = sprs;
		dialogue = dial;
		blinkProb = 0.1f;
		talkWobble = false;
		walkWobble = false;
		blinking = false;
		blinkTime = 0;
	}

	public void mouth(boolean mouthOpen) {
		if (mouthOpen == true) {
			sprite = sprites.get("talk");
		}
		else {
			sprite = sprites.get("rest");
		}
	}

	public void blink(boolean eyesShut) {
		if (eyesShut == true) {
			println("blinking");
			sprite = sprites.get("blink");
		}
		else {
			sprite = sprites.get("rest");
		}
	}


	public void update() {
		processMouse();
		moveToTarget();
		String[] lines = {"cool", "laugh", "hello", "disco", "wassup"};
		boolean flag = false;
		boolean mouthOpen = false;
		if (blinking == true) {
			if (blinkTime > 10) {
				blinkTime = 0;
				blinking = false;
				blink(false);
			}
			else {
				blinkTime++;
			}
		}

		for (int i = 0; i < lines.length; i++) {
			Dialogue d = dialogue.get(lines[i]);
			if (d.audio.isPlaying()) {
				d.fft.forward(d.audio.mix);
				for (int j = 0; j < d.fft.specSize() / 16; j++) {
					//println(d.fft.getBand(j)*8);
					if ((d.fft.getBand(j)) > 20) {
						mouthOpen = true;
					}
				}
				flag = true;
			}
		}

		if (random(100) <= 1) {
			if (flag == false) {
				dialogue.get(lines[PApplet.parseInt(random(lines.length))]).audio.play(0);
			}
		}

		if (random(50) <= 1) {
			blinking = true;
			blink(true);
		}

		if (mouthOpen == true) {
			mouth(true);
		}
		else {
			if (blinking == false) {
				mouth(false);
			}
		}
	}


}



Minim minim = new Minim(this);
class Dialogue {
	AudioPlayer audio;
	FFT fft;

	Dialogue(String filename) {
		audio = minim.loadFile(filename, 512);
		fft = new FFT(audio.bufferSize(), audio.sampleRate());
		//fft.forward(audio.mix);
	}

}

class Object {
	PImage sprite;
	float x;
	float y;
	float scalex;
	float scaley;
	float targetx;
	float targety;
	float speed;
	float horient;

	Object(PImage spr, float posx, float posy, float scx, float scy){
		sprite = spr;
		x = posx;
		y = posy;
		targetx = posx;
		targety = posy;
		scalex = scx;
		scaley = scy;
		horient = 1.0f;
		speed = 3.0f;
	}

	public void fliph() {
		if (horient == 1.0f) {
			x += (0.5f * sprite.width);
			targetx += (0.5f * sprite.width);
			horient = -1.0f;
		}
		else {
			x -= (0.5f * sprite.width);
			targetx -= (0.5f * sprite.width);
			horient = 1.0f;
		}
	}

	public void moveTo(float posx, float posy, float spd) {
		targetx = posx;
		targety = posy;
		speed = spd;
	}

	public void moveToTarget() {
		if (x > targetx) {
			x -= speed;
		}
		else if (x < targetx) {
			x += speed;
		}

		if (y > targety) {
			y -= speed;
		}
		else if (y < targety) {
			y += speed;
		}
	}

	public void processMouse() {
		if (mousePressed) {
			moveTo(mouseX - (sprite.width / 2), mouseY - (sprite.height / 2), 1.0f);

			if (targetx > x && horient == 1.0f){
				//println("flip1");
				fliph();
			}
			else if (targetx < x && horient == -1.0f){
				//println("flip2");
				fliph();
			}
		}
	}

	public void update() {
		processMouse();
		moveToTarget();
	}

	public void display() {
		pushMatrix();
		scale(horient * scalex, scaley);
		image(sprite, horient * x, y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();
	}
}

class Scene {
	PImage bgimage;
	float sceneWidth;
	float sceneHeight;
	Scene(float sWidth, float sHeight, PImage bgi){
		sceneWidth = sWidth;
		sceneHeight = sHeight;
		bgimage = bgi;
	}
	public void update() {

	}
	public void display() {
		// show the background image
		image(bgimage, 0, 0, sceneWidth, sceneHeight);
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "scene1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
