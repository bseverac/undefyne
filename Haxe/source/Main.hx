﻿package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite{
	var gameWidth:Int = 640;
	var gameHeight:Int = 320;
	var initialState:Class<FlxState> = MenuState;
	var zoom:Float = 2;
	var framerate:Int = 60;
	var skipSplash:Bool = true;
	var startFullscreen:Bool = false;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void{
		Lib.current.addChild(new Main());
	}

	public function new(){
		super();
		if (stage != null){
			init();
		}else{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void{
		if (hasEventListener(Event.ADDED_TO_STAGE)){
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		if (zoom == -1){
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
		}
		gameWidth = Math.ceil(stageWidth / zoom);
		gameHeight = Math.ceil(stageHeight / zoom);
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}
