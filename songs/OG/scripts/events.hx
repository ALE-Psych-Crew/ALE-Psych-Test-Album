import flixel.text.FlxText.FlxTextBorderStyle;

skipCountdown = true;

final waterMark:FlxText = new FlxText(10, 0, 0, song + ' - ' + difficulty + '\nALE Psych ' + CoolVars.engineVersion);
waterMark.setFormat(Paths.font('comicSans.ttf'), 17, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
waterMark.borderSize = 1.25;
add(waterMark);
waterMark.y = FlxG.height - waterMark.height - 10;

function onHealthUpdate()
{
    for (icon in icons)
    {
        final factor:Float = health / 2;

        if (icon.type == 'opponent')
            factor = 1 - factor;

        icon.data.bopScale.x = 1 + 0.5 * factor;
        icon.data.bopScale.y = 1 - 0.5 * factor;
    }
}

function onNoteHit(note:Note, rating:String, character:Character)
{
    if (character.type == 'opponent')
        health = Math.max(0.1, health - 0.01);
}

var allowNoteCamera:Bool = true;

final CAM_OFFSET:Int = 20;

function postNoteHit(note:Note, rating:String, character:Character)
{
    if (character != cameraTarget || !allowNoteCamera)
        return;

    switch (note.data)
    {
        case 0:
            camGame.offset.set(-CAM_OFFSET, 0);
        case 1:
            camGame.offset.set(0, CAM_OFFSET);
        case 2:
            camGame.offset.set(0, -CAM_OFFSET);
        case 3:
            camGame.offset.set(CAM_OFFSET, 0);
    }
}

function postCreate()
{
    comboGroup.setPosition(650, 500);
    comboGroup.cameras = [camGame];

    remove(comboGroup, true);

    addBehindDad(comboGroup);

    scoreText.font = Paths.font('comicSans.ttf');

    waterMark.cameras = [camOther];

    for (icon in icons)
    {
        icon.data.bopScale.x = 1.5;
        icon.data.bopScale.y = 0.5;

        icon.data.lerp = 0.35;
    }

    shader.set({red: 0.75, green: 0.75, blue: 0.9});

    botplay = startTime > 0;
}

function onSongStart()
{
    camGame.targetZoom = 0.8;
}

var allowJump:Bool = false;

var beatFunc:Int -> Void;
var updateFunc:Float -> Void;
var moveCameraFunc:Character -> Void;

function onSafeBeatHit(curBeat:Int)
{
    switch (curBeat)
    {
        case 16:
            camGame.targetZoom = 0.7;
        case 30:
            camGame.zoomSpeed = 1.5;

            camGame.targetZoom = 1;
        case 31:
            camGame.tweenZoom(0.6, Conductor.secCrochet, {ease: FlxEase.cubeIn});
        case 32:
            camGame.bopModulo = camHUD.bopModulo = 2;

            if (startTime <= 0)
                camGame.flash(FlxColor.WHITE, Conductor.secCrochet * 4);

            shader.set({red: 1, green: 1, blue: 1.1});

            stage.get('clouds').velocity.set(100, -50);

            allowJump = true;
        case 36:
            camGame.targetZoom = 0.7;
        case 37:
            camGame.targetZoom = 0.6;
        case 38:
            camGame.targetZoom = 0.7;
        case 39:
            camGame.targetZoom = 0.6;
        case 44:
            camGame.targetZoom = 0.7;
        case 45:
            camGame.targetZoom = 0.6;
        case 46:
            camGame.targetZoom = 0.7;
        case 47:
            camGame.targetZoom = 0.6;
        case 64:
            camGame.cancelZoomTween();
            
            camGame.targetZoom = 0.5;
        case 68:
            camGame.targetZoom = 0.6;
        case 69:
            camGame.targetZoom = 0.5;
        case 70:
            camGame.targetZoom = 0.6;
        case 71:
            camGame.targetZoom = 0.5;
        case 76:
            camGame.targetZoom = 0.6;
        case 77:
            camGame.targetZoom = 0.5;
        case 78:
            camGame.targetZoom = 0.6;
        case 79:
            camGame.targetZoom = 0.5;
        case 92:
            camGame.targetZoom = 0.7;
        case 96:
            camGame.targetZoom = 0.6;
        case 104:
            camGame.targetZoom = 0.7;
        case 106:
            camGame.targetZoom = 0.8;
        case 108:
            camGame.targetZoom = 0.7;
        case 109:
            camGame.targetZoom = 0.6;
        case 120:
            camGame.targetZoom = 0.7;
        case 122:
            camGame.targetZoom = 0.8;
        case 124:
            camGame.targetZoom = 0.7;
        case 125:
            camGame.targetZoom = 0.6;
        case 128:
            camGame.targetZoom = 0.5;
        case 132:
            camGame.targetZoom = 0.55;
        case 134:
            camGame.targetZoom = 0.6;
        case 140:
            camGame.targetZoom = 0.7;
        case 144:
            camGame.targetZoom = 0.6;
        case 148:
            camGame.targetZoom = 0.65;
        case 150:
            camGame.targetZoom = 0.7;
        case 152:
            camGame.targetZoom = 1;
        case 156:
            allowNoteCamera = false;

            camGame.tweenZoom(0.5, Conductor.secCrochet * 4, {ease: FlxEase.circInOut});

            camGame.tweenPosition(700, 450, Conductor.secCrochet * 4, {ease: FlxEase.circInOut});

            shouldMoveCamera = false;

            camHUD.bopModulo = 0;
        case 160:
            camGame.bopModulo = camHUD.bopModulo = 1;
        case 176:
            camGame.targetZoom = 0.6;
        case 192:
            camGame.cancelZoomTween();
            camGame.cancelPositionTween();

            camGame.bopModulo = camHUD.bopModulo = 2;

            camGame.targetZoom = 0.7;
        
            allowNoteCamera = shouldMoveCamera = true;
        case 196:
            camGame.targetZoom = 0.65;
        case 200:
            camGame.targetZoom = 0.7;
        case 202:
            camGame.targetZoom = 0.8;
        case 204:
            camGame.targetZoom = 0.7;
        case 205:
            camGame.targetZoom = 0.6;
        case 210:
            camGame.targetZoom = 0.8;
        case 212:
            camGame.targetZoom = 0.75;
        case 214:
            camGame.targetZoom = 0.7;
        case 216:
            camGame.targetZoom = 0.6;
        case 218:
            camGame.targetZoom = 0.5;
        case 220:
            camGame.tweenZoom(1.5, Conductor.secCrochet * 4, {ease: FlxEase.cubeInOut});

            allowNoteCamera = false;

            camGame.offset.y = 75;
        case 224:
            camGame.cancelZoomTween();

            allowJump = false;

            shader.tween({red: 0.5, green: 0.5, blue: 0.75}, Conductor.secCrochet * 2);

            for (obj in uiGroup)
                FlxTween.tween(obj, {alpha: 0}, Conductor.secCrochet * 2);

            for (strl in strumLines)
                for (strum in strl.strums)
                    FlxTween.tween(strum, {alpha: 0}, Conductor.secCrochet * 2);

            var curChar:Character = boyfriend;
            
            camGame.zoomSpeed = 2;
            
            camGame.speed = 25;
            
            stage.get('clouds').velocity.set(200, -100);

            moveCameraFunc = (character) -> {
                if (curChar != character)
                {
                    curChar = character;
                    
                    camGame.offset.x = curChar == dad ? 100 : -100;
                    camGame.offset.y = curChar == dad ? -25 : 75;

                    camGame.targetZoom = curChar == dad ? 1 : 1.5;
                }
            };

            updateFunc = (elapsed) -> {
                camGame.offset.x += elapsed * 50 * (cameraTarget.type == 'player' ? 1 : -1);
            };

            camHUD.bopModulo = camGame.bopModulo = 0;
        case 240:
            for (strl in strumLines)
                for (index => strum in strl.strums.members)
                {
                    FlxTween.cancelTweensOf(strum);

                    FlxTween.tween(strum, {alpha: 1}, Conductor.secCrochet, {startDelay: index * Conductor.secCrochet * 4});
                }
        case 256:
            camGame.reset();
            camHUD.reset();

            camGame.targetZoom = 0.6;

            camHUD.bopModulo = camGame.bopModulo = 0;

            moveCameraFunc = null;
            updateFunc = null;
        case 272:
            allowNoteCamera = true;
            
            beatFunc = (curBeat) -> {
                if (curBeat % 2 == 1)
                {
                    shader.set({bloom: 1.25});

                    shader.tween({bloom: 1}, Conductor.secCrochet * 2);
                }
            };
        case 284:
            camGame.targetZoom = 0.8;

            beatFunc = null;
        case 286:
    }

    if (beatFunc != null)
        beatFunc(curBeat);
}

startTime = Conductor.beatsToTime(284);

function onBeatHit(curBeat)
{
    if (allowJump && curBeat % 2 == 1)
    {
        if (boyfriend.animation.name == 'idle')
        {
            FlxTween.cancelTweensOf(boyfriend);
            FlxTween.cancelTweensOf(boyfriend.scale);

            final JUMP_OFFSET:Float = 30;

            FlxTween.tween(boyfriend, {y: boyfriend.y - JUMP_OFFSET}, Conductor.secCrochet * 0.5, {
                ease: FlxEase.cubeOut,
                onComplete: (_) -> {
                    FlxTween.tween(boyfriend, {y: boyfriend.y + JUMP_OFFSET}, Conductor.secCrochet * 0.5, {ease: FlxEase.cubeIn});
                }
            });

            FlxTween.tween(boyfriend.scale, {x: 0.95, y: 1.05}, Conductor.secCrochet * 0.5, {
                ease: FlxEase.backOut,
                onComplete: (_) -> {
                    FlxTween.tween(boyfriend.scale, {x: 1, y: 1}, Conductor.secCrochet * 0.5, {startDelay: Conductor.secCrochet * 0.4, ease: FlxEase.backOut});
                }
            });

            FlxTween.cancelTweensOf(iconP1);

            FlxTween.tween(iconP1, {offsetX: -JUMP_OFFSET}, Conductor.secCrochet * 0.5, {
                ease: FlxEase.cubeOut,
                onComplete: (_) -> {
                    FlxTween.tween(iconP1, {offsetX: 0}, Conductor.secCrochet * 0.5, {ease: FlxEase.cubeIn});
                }
            });
        }
    }
}

function onCameraMove(character:Character)
{
    if (moveCameraFunc != null)
        moveCameraFunc(character);
}

function onUpdate(elapsed:Float)
{
    if (updateFunc != null)
        updateFunc(elapsed);
}