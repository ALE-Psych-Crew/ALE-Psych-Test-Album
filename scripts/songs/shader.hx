public var shader = new funkin.visuals.shaders.FXShader('default');
shader.set({bloom: 1, red: 1, green: 1, blue: 1});

function postCreate()
{
    camGame.setShaders([shader]);
}