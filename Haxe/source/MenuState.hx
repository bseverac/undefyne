package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

import 	ui.Icon;

class MenuState extends FlxState{
	private var promptText:FlxText;
	private var iconOff:Icon;

	override public function create():Void{
		FlxG.mouse.visible = true;

		promptText = new FlxText(Std.int(FlxG.width/2-200/2), 0, 200, "hello");
		promptText.alignment = 'center';
		iconOff = new Icon(0, 0); 
		add(iconOff);
		add(promptText);
	}

	override public function update():Void{
		super.update();
		if (FlxG.keys.anyPressed(["UP", "W"])){

		}
		else if (FlxG.keys.anyPressed(["DOWN", "S"])){
		}
		else if (FlxG.keys.anyPressed(["LEFT", "A"])){
		}
		else if (FlxG.keys.anyPressed(["RIGHT", "D"])){
		}
	}
}
