package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(flash.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/bumps1.oel", __ASSET__assets_data_bumps1_oel);
		type.set ("assets/data/bumps1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/data/flat1.oel", __ASSET__assets_data_flat1_oel);
		type.set ("assets/data/flat1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/data/flat2.oel", __ASSET__assets_data_flat2_oel);
		type.set ("assets/data/flat2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/data/hole2.oel", __ASSET__assets_data_hole2_oel);
		type.set ("assets/data/hole2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/data/join2to1.oel", __ASSET__assets_data_join2to1_oel);
		type.set ("assets/data/join2to1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/data/split1to2.oel", __ASSET__assets_data_split1to2_oel);
		type.set ("assets/data/split1to2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/images/ninja_sheet.png", __ASSET__assets_images_ninja_sheet_png);
		type.set ("assets/images/ninja_sheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		
		
		#elseif html5
		
		addExternal("assets/data/bumps1.oel", "text", "assets/data/bumps1.oel");
		addExternal("assets/data/flat1.oel", "text", "assets/data/flat1.oel");
		addExternal("assets/data/flat2.oel", "text", "assets/data/flat2.oel");
		addExternal("assets/data/hole2.oel", "text", "assets/data/hole2.oel");
		addExternal("assets/data/join2to1.oel", "text", "assets/data/join2to1.oel");
		addExternal("assets/data/split1to2.oel", "text", "assets/data/split1to2.oel");
		addExternal("assets/images/ninja_sheet.png", "image", "assets/images/ninja_sheet.png");
		addExternal("assets/images/tiles.png", "image", "assets/images/tiles.png");
		addExternal("assets/sounds/beep.mp3", "music", "assets/sounds/beep.mp3");
		addExternal("assets/sounds/flixel.mp3", "music", "assets/sounds/flixel.mp3");
		
		
		#else
		
		#if (windows || mac || linux)
		
		var loadManifest = false;
		
		className.set ("assets/data/bumps1.oel", __ASSET__assets_data_bumps1_oel);
		type.set ("assets/data/bumps1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/data/flat1.oel", __ASSET__assets_data_flat1_oel);
		type.set ("assets/data/flat1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/data/flat2.oel", __ASSET__assets_data_flat2_oel);
		type.set ("assets/data/flat2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/data/hole2.oel", __ASSET__assets_data_hole2_oel);
		type.set ("assets/data/hole2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/data/join2to1.oel", __ASSET__assets_data_join2to1_oel);
		type.set ("assets/data/join2to1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/data/split1to2.oel", __ASSET__assets_data_split1to2_oel);
		type.set ("assets/data/split1to2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("assets/images/ninja_sheet.png", __ASSET__assets_images_ninja_sheet_png);
		type.set ("assets/images/ninja_sheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		
		
		#else
		
		var loadManifest = true;
		
		#end
		
		if (loadManifest) {
			try {
				
				#if blackberry
				var bytes = ByteArray.readFile ("app/native/manifest");
				#elseif tizen
				var bytes = ByteArray.readFile ("../res/manifest");
				#elseif emscripten
				var bytes = ByteArray.readFile ("assets/manifest");
				#else
				var bytes = ByteArray.readFile ("manifest");
				#end
				
				if (bytes != null) {
					
					bytes.position = 0;
					
					if (bytes.length > 0) {
						
						var data = bytes.readUTFBytes (bytes.length);
						
						if (data != null && data.length > 0) {
							
							var manifest:Array<AssetData> = Unserializer.run (data);
							
							for (asset in manifest) {
								
								if (!className.exists(asset.id)) {
									
									path.set (asset.id, asset.path);
									type.set (asset.id, asset.type);
									
								}
							}
						
						}
					
					}
				
				} else {
				
					trace ("Warning: Could not load asset manifest");
				
				}
			
			} catch (e:Dynamic) {
			
				trace ("Warning: Could not load asset manifest");
			
			}
		
		}
		
		#end
		
	}
	
	
	#if html5
	private function addEmbed(id:String, kind:String, value:Dynamic):Void {
		className.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	
	
	private function addExternal(id:String, kind:String, value:String):Void {
		path.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	#end
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif openfl_html5
		
		return null;
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_data_bumps1_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_data_flat1_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_data_flat2_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_data_hole2_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_data_join2to1_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_data_split1to2_oel extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_images_ninja_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5













#elseif (windows || mac || linux)


@:file("assets/data/bumps1.oel") class __ASSET__assets_data_bumps1_oel extends flash.utils.ByteArray {}
@:file("assets/data/flat1.oel") class __ASSET__assets_data_flat1_oel extends flash.utils.ByteArray {}
@:file("assets/data/flat2.oel") class __ASSET__assets_data_flat2_oel extends flash.utils.ByteArray {}
@:file("assets/data/hole2.oel") class __ASSET__assets_data_hole2_oel extends flash.utils.ByteArray {}
@:file("assets/data/join2to1.oel") class __ASSET__assets_data_join2to1_oel extends flash.utils.ByteArray {}
@:file("assets/data/split1to2.oel") class __ASSET__assets_data_split1to2_oel extends flash.utils.ByteArray {}
@:bitmap("assets/images/ninja_sheet.png") class __ASSET__assets_images_ninja_sheet_png extends flash.display.BitmapData {}
@:bitmap("assets/images/tiles.png") class __ASSET__assets_images_tiles_png extends flash.display.BitmapData {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,1/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,1/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound {}


#end