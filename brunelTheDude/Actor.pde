class Actor extends Object {
	HashMap<String, Animation> animations;
	HashMap<String, Dialogue> dialogue;
	Actor(Coord loc, Coord sca, PImage spr, HashMap<String, Animation> anims, HashMap<String, Dialogue> dial){
		// constructor
		super(spr, loc, sca);
		animations = anims;
		dialogue = dial;
	}

	void update() {
		
	}


}