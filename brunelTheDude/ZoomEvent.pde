class ZoomEvent extends Event {
	Coord target;
	ZoomEvent(Object obj, float sTime, float d, Coord targ) {
		super(obj, sTime, d);
		target = targ;
	}

	void trigger() {
		running = true;
		Coord toTarget = new Coord(target.x - object.zoom.x, target.y - object.zoom.y);
		float toTargetLength = sqrt(sq(toTarget.x) + sq(toTarget.y));
		object.zoomTo(target, toTargetLength / dur);
	}
}