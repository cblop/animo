
class Scene {
	PImage bgimage;
	float sceneWidth;
	float sceneHeight;
	Scene(float sWidth, float sHeight, PImage bgi){
		sceneWidth = sWidth;
		sceneHeight = sHeight;
		bgimage = bgi;
	}
	void update() {

	}
	void display() {
		// show the background image
		image(bgimage, 0, 0, sceneWidth, sceneHeight);
	}
}