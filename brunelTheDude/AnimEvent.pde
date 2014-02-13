class AnimEvent extends Event {
	String animName;
	Actor object;
	AnimEvent(Actor obj, float sTime, float d, String aname) {
		super(obj, sTime, d);
		animName = aname;
	}

	void trigger() {
		object.animations.get(animName).playAnim();
	}
}