import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim = new Minim(this);
class Dialogue {
	AudioPlayer audio;
	FFT fft;
	String subtitle;

	Dialogue(String filename) {
		audio = minim.loadFile(filename, 512);
		fft = new FFT(audio.bufferSize(), audio.sampleRate());
		subtitle = "";
	}

	Dialogue(String filename, String sub) {
		audio = minim.loadFile(filename, 512);
		fft = new FFT(audio.bufferSize(), audio.sampleRate());
		subtitle = sub;
	}

}