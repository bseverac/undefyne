package ui;

import flixel.plugin.MouseEventManager;
import flixel.group.FlxGroup;
import flixel.FlxSprite;

class Icon extends FlxGroup{
  private static var icons = {
    off: { img: Hashes.icons.off,
           color1: Hashes.colors.red_d_4,
           color2: Hashes.colors.red_d_3,
           color3: Hashes.colors.red_l_3,
           color4: Hashes.colors.red_l_4,
           colorL1: Hashes.colors.red_d_3,
           colorL2: Hashes.colors.red_d_2,
           colorL3: Hashes.colors.red_l_2,
           colorL4: Hashes.colors.red_l_3
         }
  };
  private var x:Int;
  private var y:Int;
  private var iconCode:String;
  private var background:FlxSprite;
  private var icon:FlxSprite;

  public function new(_x:Int, _y:Int, _iconCode:String = 'off'){
    super();
    x = _x;
    y = _y;
    iconCode = _iconCode;
    background = new FlxSprite();
    background.loadGraphic(Hashes.icons.background);
    add(background);
    MouseEventManager.add(background, onDown, onUp, onOver, onOut);

    icon = new FlxSprite();
    icon.loadGraphic(iconAttrs().img);
    add(icon);
    applyColor();
  }

  private function onDown(sprite:FlxSprite):Void{
      applyHoverColor();
  }

  private function onUp(sprite:FlxSprite):Void{
      applyHoverColor();
  }
  private function onOver(sprite:FlxSprite):Void{
      applyHoverColor();
  }
  private function onOut(sprite:FlxSprite):Void{
      applyColor();
  }

  private function iconAttrs():Dynamic{
    return Reflect.field(icons, iconCode);
  }

  private function applyColor():Void{
    background.loadGraphic(Hashes.icons.background);
    background.replaceColor(Hashes.colors.color_1, iconAttrs().color1);
    background.replaceColor(Hashes.colors.color_2, iconAttrs().color2);
    background.replaceColor(Hashes.colors.color_3, iconAttrs().color3);
    background.replaceColor(Hashes.colors.color_4, iconAttrs().color4);
    icon.loadGraphic(iconAttrs().img);
    icon.replaceColor(Hashes.colors.color_1, iconAttrs().color1);
    icon.replaceColor(Hashes.colors.color_2, iconAttrs().color2);
  }
  private function applyHoverColor():Void{
    background.loadGraphic(Hashes.icons.background);
    background.replaceColor(iconAttrs().color_1, iconAttrs().colorL4);
    background.replaceColor(iconAttrs().color_2, iconAttrs().colorL3);
    background.replaceColor(iconAttrs().color_3, iconAttrs().colorL2);
    background.replaceColor(iconAttrs().color_4, iconAttrs().colorL1);
    icon.loadGraphic(iconAttrs().img);
    icon.replaceColor(iconAttrs().color_1, iconAttrs().colorL1);
    icon.replaceColor(iconAttrs().color_2, iconAttrs().colorL2);
  }
  override public function destroy():Void{
    MouseEventManager.remove(background);
    super.destroy();
  }
}
