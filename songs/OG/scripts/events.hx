import flixel.text.FlxText.FlxTextBorderStyle;

skipCountdown = true;

final waterMark:FlxText = new FlxText(10, 0, 0, song + ' - ' + difficulty + '\nALE Psych ' + CoolVars.engineVersion);
waterMark.setFormat(Paths.font('comicSans.ttf'), 17, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
waterMark.borderSize = 1.25;
add(waterMark);
waterMark.y = FlxG.height - waterMark.height - 10;

function postCreate()
{
    comboGroup.setPosition(650, 500);
    comboGroup.cameras = [camGame];

    remove(comboGroup, true);

    addBehindDad(comboGroup);

    scoreText.font = Paths.font('comicSans.ttf');

    waterMark.cameras = [camHUD];

    for (icon in icons)
    {
        icon.data.bopScale.x = 1.5;
        icon.data.bopScale.y = 0.5;

        icon.data.lerp = 0.35;
    }
}

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

function onSongStart()
{
    camGame.targetZoom = 0.8;
}

function onSafeBeatHit(curBeat:Int)
{
    switch (curBeat)
    {
        case 16:
            camGame.targetZoom = 0.7;
    }
}

//startTime = Conductor.beatsToTime(16);