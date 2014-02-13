class MoveEvent extends Event {
	Coord target;
	MoveEvent(Object obj, float sTime, float d, Coord targ) {
		super(obj, sTime, d);
		target = targ;
	}

	void trigger() {
		running = true;
		Coord toTarget = new Coord(target.x - object.location.x, target.y - object.location.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		object.moveTo(target, toTargetLength / dur);
	}
}