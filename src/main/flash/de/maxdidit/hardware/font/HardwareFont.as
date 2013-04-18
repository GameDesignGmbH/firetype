package de.maxdidit.hardware.font 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFont 
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFont() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function loadFont(url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			urlLoader.addEventListener(Event.COMPLETE, handleFontLoaded);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
			
			urlLoader.load(urlRequest);
		}
		
		public function parseFontData(data:ByteArray):void
		{
			
		}
		
		private function removeEventHandlerFromLoader(urlLoader:URLLoader):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, handleFontLoaded);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
		}
		
		///////////////////////
		// Event Handler
		///////////////////////
		
		private function handleFontLoaded(e:Event):void 
		{
			// TODO: provide feedback that font has been loaded.
			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
			
			var data:ByteArray = urlLoader.data as ByteArray;
			parseFontData(data);
		}
		
		private function handleFontLoadingFailed(e:Event):void 
		{
			// TODO: provide feedback that the font could not be loaded and why.
			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
		}
		
	}

}