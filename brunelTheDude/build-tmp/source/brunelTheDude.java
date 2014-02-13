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

public class brunelTheDude extends PApplet {


final int screenWidth = 800;
final int screenHeight = 600;
final float scalef = 1.3f;

Scene scene;
Actor brunel;
//Event[] events;
//Actor[] actors;

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
		new MoveEvent(brunel, 100.0f, 20.0f, new Coord(0, 0)),
		new ZoomEvent(brunel, 100.0f, 20.0f, new Coord(3.0f, 3.0f)),
		new SpeakEvent(brunel, 100.0f, 20.0f, "cool"),
		new MoveEvent(brunel, 200.0f, 200.0f, new Coord(100, 0)),
		new ZoomEvent(brunel, 200.0f, 200.0f, new Coord(1.0f, 1.0f)),
		new ZoomEvent(brunel, 300.0f, 10.0f, new Coord(1.0f, 1.0f)),
		new MoveEvent(brunel, 300.0f, 200.0f, new Coord(400, 0)),
		new SpeakEvent(brunel, 400.0f, 20.0f, "disco"),
	};

	Actor[] actors = {brunel};

	scene = new Scene(PApplet.parseFloat(screenWidth), PApplet.parseFloat(screenHeight), bgimg, events, actors);
	scene.runEvents();

	//Actor brunel = new Actor(brunelimg, brunelTalk, brunelBlink, 400, 100, scalef, scalef);


	//brunel.fliph();
}

public void draw() {
	scene.update();
	scene.display();
	brunel.update();
	brunel.display();
	//println("X: " + brunel.x + "  Y: " + brunel.y);
}

class Actor extends Object {
	HashMap<String, Animation> animations;
	HashMap<String, Dialogue> dialogue;
	Animation currentAnim;
	Dialogue speech;
	Boolean speaking;
	Actor(Coord loc, Coord sca, HashMap<String, Animation> anims, HashMap<String, Dialogue> dial){
		// constructor
		super(anims.get("rest").frames[0], loc, sca);
		animations = anims;
		dialogue = dial;
		currentAnim = anims.get("rest");
		speaking = false;
		speech = dialogue.get("hello"); // very, very bad
	}

	public void setSpeech(String spch) {
		speech = dialogue.get(spch);
	}

	public void moveMouth() {
		boolean flag = false;
		speech.fft.forward(speech.audio.mix);
		for (int i = 0; i < speech.fft.specSize() / 16; i++) { // only process the first 16th of the spectrum
			if((speech.fft.getBand(i)) > 20) {
				// move the mouth
				//animations.get("talk").playAnim();
				sprite = animations.get("talk").frames[0];
			}
			else {
				//sprite = animations.get("rest").frames[0];
			}
		}
	}

	public void sayLine() {
		if (!speech.audio.isPlaying()) {
			speech.audio.play(0); // 0 means from the beginning
		}
	}

	public void speak() {
		if (speech.audio.position() >= speech.audio.length()) {
			speaking = false;
		}
		if (speaking == true) {
			moveMouth();
		}


	}

	public void update() {
		processMouse();
		//println(zoom.x);
		//println(location.x);
		sprite = currentAnim.frames[currentAnim.currentFrame];
	}

	public void display() {
		speak();
		move();
		zoom();
		pushMatrix();
		scale(horient * zoom.x, zoom.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();

	}


}
class AnimEvent extends Event {
	String animName;
	Actor object;
	AnimEvent(Actor obj, float sTime, float d, String aname) {
		super(obj, sTime, d);
		animName = aname;
	}

	public void trigger() {
		object.animations.get(animName).playAnim();
	}
}
class Animation {
	PImage[] frames;
	int currentFrame;
	boolean running;
	Animation(PImage[] frms){
		frames = frms;
		currentFrame = 0;
	}

	public void playAnim() {
		running = true;
		currentFrame++;
	}

	public void stopAnim() {
		running = false;
		currentFrame = 0;
	}

	public void update() {
		if (running) {
			playAnim();
			if (currentFrame >= frames.length) {
				stopAnim();
			}
		}

	}
}
class Coord {
	float x;
	float y;

	Coord(float xpos, float ypos) {
		x = xpos;
		y = ypos;
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
class Event {
	float startTime;
	float dur;
	float elapsed;
	float speed;
	boolean running;
	Object object;

	Event(Object obj, float sTime, float d) {
		object = obj;
		startTime = sTime;
		dur = d;
		elapsed = 0;
		running = false;
		speed = dur / frameRate;
	}

	public void trigger() {
		running = true;
	}

	public void stop() {
		running = false;
	}

}
class MoveEvent extends Event {
	Coord target;
	MoveEvent(Object obj, float sTime, float d, Coord targ) {
		super(obj, sTime, d);
		target = targ;
	}

	public void trigger() {
		running = true;
		Coord toTarget = new Coord(target.x - object.location.x, target.y - object.location.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		object.moveTo(target, toTargetLength / dur);
		//object.moveTo(target, 1.0);
	}
}

class Object {
	PImage sprite;
	Coord location;
	Coord target;
	Coord zoom;
	Coord zoomTarget;
	float zoomSpeed;
	float speed;
	float horient;

	Object(PImage spr, Coord loc, Coord sca){
		sprite = spr;
		location = loc;
		target = location;
		zoom = sca;
		zoomTarget = sca;
		horient = 1.0f;
	}

	public void processMouse() {
		if (mousePressed) {
			moveTo(new Coord(mouseX - (sprite.width / 2), mouseY - (sprite.height / 2)), 3.0f);

			if (target.x > location.x && horient == 1.0f){
				//println("flip1");
				fliph();
			}
			else if (target.x < location.x && horient == -1.0f){
				//println("flip2");
				fliph();
			}
		}
	}

	public void fliph() {
		if (horient == 1.0f) {
			location.x += (0.5f * sprite.width);
			target.x += (0.5f * sprite.width);
			horient = -1.0f;
		}
		else {
			location.x -= (0.5f * sprite.width);
			target.x -= (0.5f * sprite.width);
			horient = 1.0f;
		}
	}

	public void moveTo(Coord trgt, float spd) {
		//println("moved: "+trgt.x);
		println("speed: " + speed);
		target = trgt;
		speed = spd;
	}


	public void move() {
		Coord toTarget = new Coord(target.x - location.x, target.y - location.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		toTarget.x = toTarget.x / toTargetLength;
		toTarget.y = toTarget.y / toTargetLength;

		// this is a kludge?
		if (toTargetLength > speed) {
			location.x += toTarget.x * speed;
			location.y += toTarget.y * speed;
		}

		/* legacy code
		if (location.x > target.x) {
			location.x -= speed;
		}
		else if (location.x < target.x) {
			location.x += speed;
		}

		if (location.y > target.y) {
			location.y -= speed;
		}
		else if (location.y < target.y) {
			location.y += speed;
		}
		*/
	}

	public void zoomTo(Coord trgt, float spd) {
		zoomTarget = trgt;
		zoomSpeed = spd;
	}

	public void zoom() {
		Coord toTarget = new Coord(zoomTarget.x - zoom.x, zoomTarget.y - zoom.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		toTarget.x = toTarget.x / toTargetLength;
		toTarget.y = toTarget.y / toTargetLength;

		// this is a kludge?
		if (toTargetLength > zoomSpeed) {
			zoom.x += toTarget.x * zoomSpeed;
			zoom.y += toTarget.y * zoomSpeed;
		}

		/* legacy code
		if (zoom.x > zoomTarget.x) {
			zoom.x -= zoomSpeed;
		}
		else if (zoom.x < zoomTarget.x) {
			zoom.x += zoomSpeed;
		}

		if (zoom.y > zoomTarget.y) {
			zoom.y -= zoomSpeed;
		}
		else if (zoom.y < zoomTarget.y) {
			zoom.y += zoomSpeed;
		}
		*/
	}

	public void update() {
		processMouse();
	}

	public void display() {
		move();
		zoom();
		pushMatrix();
		scale(horient * zoom.x, zoom.y);
		image(sprite, horient * location.x, location.y, sprite.width, sprite.height);
		//println(horient);
		popMatrix();
	}
}

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
		timePassed = 0.0f;
		running = false;
	}

	public void runEvents() {
		running = true;
	}

	public void update() {
		if (running == true) {
			//println(timePassed);
			timePassed++;
			for (int i = 0; i < events.length; i++) {
				//println("timePassed: "+timePassed+"   eventTime: "+events[i].startTime);
				if (events[i].startTime == timePassed) {
					println("event: " + events[i].startTime);
					events[i].trigger();
				}
			}
		}

	}
	public void display() {
		// show the background image
		image(bgimage, 0, 0, sceneWidth, sceneHeight);
	}
}
class SpeakEvent extends Event {
	Actor actor;
	String dialogue;
	SpeakEvent(Actor act, float sTime, float d, String dial) {
		super(act, sTime, d);
		actor = act;
		dialogue = dial;
	}

	public void trigger() {
		running = true;
		//object.speech = object.dialogue.get(dialogue);
		actor.setSpeech(dialogue);
		actor.sayLine();
		actor.speaking = true;
	}

}
class ZoomEvent extends Event {
	Coord target;
	ZoomEvent(Object obj, float sTime, float d, Coord targ) {
		super(obj, sTime, d);
		target = targ;
	}

	public void trigger() {
		running = true;
		Coord toTarget = new Coord(target.x - object.zoom.x, target.y - object.zoom.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		object.zoomTo(target, toTargetLength / dur);
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "brunelTheDude" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
