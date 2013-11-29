package  {
	import flash.display.MovieClip;
	
	public class Main extends MovieClip {
		public function Main() {
			var dots:Vector.<Dot> = new Vector.<Dot>();
			dots.push(new Dot(stage, 100, 100));
			var canvas:Canvas = new Canvas(stage, 20, 30, dots[0]);
			//stage.setChildIndex(dots[0], 2);
		}
	}
}