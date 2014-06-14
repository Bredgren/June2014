package;

import flixel.effects.particles.FlxEmitterExt;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxSave;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState  {
  private var _loader:FlxOgmoLoader;
  private var _maps:FlxTypedGroup<FlxTilemap>;
  private var _sections1:Array<String>;
  private var _sections2:Array<String>;
  private var _paths = 1;

  private var _ninja:FlxSprite;

  private var _target_x = 350;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
		super.create();

    FlxG.camera.bgColor = 0xC0C0C0;

    _sections1 = new Array<String>();
    _sections1.push("flat1.oel");
    _sections1.push("bumps1.oel");
    _sections1.push("split1to2.oel");

    _sections2 = new Array<String>();
    _sections2.push("flat2.oel");
    _sections2.push("hole2.oel");
    _sections2.push("join2to1.oel");

    _maps = new FlxTypedGroup<FlxTilemap>();

    _newSection("assets/data/flat1.oel", 0);
    _newSection("assets/data/bumps1.oel", 1);
    _newSection();

    _makeNinja();

    //FlxG.camera.follow(_ninja);
    //FlxG.camera.bounds.x -= FlxG.camera.bounds.width / 2;
    //FlxG.camera.bounds.y -= FlxG.camera.bounds.height / 2;
    //FlxG.camera.bounds.width *= 2;
    //FlxG.camera.bounds.height *= 2;
	}

  private function _makeNinja():Void {
    _ninja = new FlxSprite(300, FlxG.height - 210);
    _ninja.loadGraphic("assets/images/ninja_sheet.png", true, 50, 50);
    _ninja.animation.add("normal", [0], 0, false);
    _ninja.animation.add("jump_prep", [1, 2], 15, false);
    _ninja.animation.add("jump", [3, 4], 3, false);
    _ninja.animation.play("normal");
    _ninja.acceleration.y = 1500;
    _ninja.drag.x = 900;
    _ninja.width = 32;
    _ninja.height = 32;
    _ninja.offset.x = 14;
    _ninja.offset.y = 17;
    add(_ninja);
  }

  private function _newSection(section:String="", start:Int=2):Void {
    if (section == "") {
      if (_paths == 1) {
        var index = Math.floor(Math.random() * _sections1.length);
        section = _sections1[index];
      } else if (_paths == 2) {
        var index = Math.floor(Math.random() * _sections2.length);
        section = _sections2[index];
      }
      section = "assets/data/" + section;
    }
    if (section == "assets/data/split1to2.oel") {
      _paths = 2;
    } else if (section == "assets/data/join2to1.oel") {
      _paths = 1;
    }
    _loader = new FlxOgmoLoader(section);
    var map = _loader.loadTilemap("assets/images/tiles.png", 50, 50, "Walls");
    add(map);
    map.x = start * (map.width);
    map.moves = true;
    map.velocity.x = -200;
    _maps.add(map);
  }

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
    super.update();

    //_ninja.flipY = false;
    _ninja.offset.y = 17;

    _handleCollisions();
    _updateNinja();
    _updateMap();
  }

  private function _handleCollisions():Void {
    FlxG.collide(_maps, _ninja, function(ground:FlxObject, ninja:FlxSprite) {
      if (ninja.isTouching(FlxObject.UP) && FlxG.keys.pressed.W) {
        _ninja.velocity.y = -500;
        _ninja.animation.play("normal");
        _ninja.flipY = true;
        _ninja.offset.y = 0;
      } else if (ninja.isTouching(FlxObject.DOWN) && ninja.animation.name != "jump_prep") {
        ninja.animation.play("normal");
      }
    });
  }

  private function _updateNinja():Void {
    var on_ground = _ninja.isTouching(FlxObject.DOWN);

    if (FlxG.keys.pressed.W && on_ground && _ninja.animation.name != "jump_prep") {
      _ninja.animation.play("jump_prep");
    }

    if (FlxG.keys.justReleased.W) {
      _ninja.flipY = false;
    }

    if (_ninja.flipY && FlxG.keys.pressed.W) {
        _ninja.velocity.y = -500;
        _ninja.animation.play("normal");
        _ninja.offset.y = 0;
    }

    //if (FlxG.keys.pressed.A) {
      //_ninja.velocity.x = -300;
      //_ninja.flipX = true;
      //_ninja.offset.x = 4;
    //}
    //if (FlxG.keys.pressed.S) {
      //_ninja.velocity.x = 300;
      //_ninja.flipX = false;
      //_ninja.offset.x = 14;
    //}

    if (_ninja.x < _target_x) {
      _ninja.velocity.x = 50;
    }

    if (_ninja.x < -_ninja.width) {
      FlxG.log.notice("dead");
    }

    if (_ninja.animation.finished) {
      switch (_ninja.animation.name) {
        case "jump_prep":
          _ninja.animation.play("jump");
          _ninja.velocity.y = -500;
        case "jump":
          _ninja.animation.play("normal");
      }
    }
  }

  private function _updateMap():Void {
    var old = new Array();
    for (map in _maps) {
      if (map.x < -map.width) {
        map.destroy();
        old.push(map);
        _newSection();
      }
    }
    for (map in old) {
      _maps.remove(map);
    }
  }
}
