(function() {
  var init;

  $(document).ready(function() {
    return init();
  });

  init = function() {
    var canvas, i, isoMap, j, map, scene, spriteSheet;
    canvas = $('#canvas')[0];
    scene = new Scene(canvas, 'black');
    spriteSheet = new SpriteSheet('images/tileset.png', [
      {
        length: 7,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 8,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 4,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 9,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 4,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 3,
        cellWidth: 64,
        cellHeight: 64
      }, {
        length: 10,
        cellWidth: 64,
        cellHeight: 64
      }
    ]);
    map = [];
    for (i = 0; i <= 9; i++) {
      map[i] = [];
      for (j = 0; j <= 9; j++) {
        map[i][j] = Math.floor(Math.random() * 60);
      }
    }
    console.log(map);
    isoMap = new IsometricMap({
      spriteSheet: spriteSheet,
      map: map,
      tileWidth: 64,
      tileHeight: 64,
      tileXOffset: 32,
      tileYOffset: 16
    });
    isoMap.position.x = 300;
    return scene.addChild(isoMap);
  };

}).call(this);
