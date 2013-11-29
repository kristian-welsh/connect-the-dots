package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class Dot extends MovieClip {
		public function Dot(container:DisplayObjectContainer, x:Number, y:Number) {
			//container.addChild(this);
			this.x = x;
			this.y = y;
		}
		
		public function get bitmapRepresentation():Bitmap {
			var bmd:BitmapData = new BitmapData(400, 300, false, 0xFFFFFF);
			var bmp:Bitmap = new Bitmap(bmd);
			bmd.draw(this);
			return bmp;
		}
	}
}