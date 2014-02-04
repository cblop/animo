import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
final float scalef = 0.7f;

Scene scene;
Actor brunel;

public void setup() {
	//addScreen("scene", new Scene(screenWidth, screenHeight));
	size(screenWidth, screenHeight);
	PImage bgimg = loadImage("pics/cliftonBridgeBW.jpg");
	PImage brunelimg = loadImage("pics/brunel.png");
	PImage brunelTalk = loadImage("pics/brunelTalk.png");
	PImage brunelBlink = loadImage("pics/brunelBlink.png");
	scene = new Scene(PApplet.parseFloat(screenWidth), PApplet.parseFloat(screenHeight), bgimg);
	brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);
	brunel.fliph();
}

public void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	println("X: " + brunel.x + "  Y: " + brunel.y);
}

class Actor extends Object {
	PImage restImg;
	PImage talkImg;
	PImage blinkImg;
	Actor(PImage rest, PImage talk, PImage blink, float posx, float posy, float scx, float scy){
		// constructor
		super(rest, posx, posy, scx, scy);
		restImg = rest;
		talkImg = talk;
		blinkImg = blink;
	}

	public void talk(boolean mouthOpen) {
		if (mouthOpen == true) {
			sprite = talkImg;
		}
		else {
			sprite = restImg;
		}
	}

	public void blink(boolean eyesOpen) {
		if (eyesOpen == true) {
			sprite = blinkImg;
		}
		else {
			sprite = restImg;
		}
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
		speed = 1.0f;
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
				println("flip1");
				fliph();
			}
			else if (targetx < x && horient == -1.0f){
				println("flip2");
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
		println(horient);
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
