package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Canvas extends MovieClip {
		private var _oldPos:Point = new Point(0, 0);
		private var _container:DisplayObjectContainer;
		private var _drawing:Shape = new Shape();
		private var _dot:Dot;
		
		public function Canvas(container:DisplayObjectContainer, x:Number, y:Number, dot:Dot) {
			_container = container;
			_dot = dot;
			
			this.x = x;
			this.y = y;
			
			_drawing.x = x;
			_drawing.y = y;
			_drawing.graphics.lineStyle(2);
			
			bondToContainer();
			addEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
		}
		
		private function bondToContainer():void {
			_container.addChild(this);
			_container.addChild(_drawing);
		}
		
		private function startDrawing(e:MouseEvent):void {
			updateOldPosition(e);
			addEventListener(MouseEvent.MOUSE_MOVE, drawLine);
			removeEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
			addEventListener(MouseEvent.MOUSE_UP, stopDrawing);
		}
		
		private function updateOldPosition(e:MouseEvent):void {
			_oldPos.x = e.localX;
			_oldPos.y = e.localY;
		}
		
		private function drawLine(e:MouseEvent):void {
			drawLineTo(new Point(e.localX, e.localY));
			updateOldPosition(e);
		}
		
		private function drawLineTo(newPos:Point):void {
			_drawing.graphics.moveTo(_oldPos.x, _oldPos.y);
			_drawing.graphics.lineTo(newPos.x, newPos.y);
			//collide();
		}
		
		private function collide():void {
			if (playerDrawing.bitmapData.compare(_dot.bitmapRepresentation.bitmapData) is BitmapData) {
				trace("yes");
				var result:BitmapData = playerDrawing.bitmapData.compare(_dot.bitmapRepresentation.bitmapData) as BitmapData;
				var bitmap:Bitmap = new Bitmap(result);
				_container.addChild(bitmap);
			}
		}
		
		private function stopDrawing(e:MouseEvent):void {
			removeEventListener(MouseEvent.MOUSE_MOVE, drawLine);
			removeEventListener(MouseEvent.MOUSE_UP, stopDrawing);
			addEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
		}
		
		public function get playerDrawing():Bitmap {
			var bmd:BitmapData = new BitmapData(400, 300, true, 0xFFFFFF);
			var bmp:Bitmap = new Bitmap(bmd);
			bmd.draw(_drawing);
			return bmp;
		}
	}
}