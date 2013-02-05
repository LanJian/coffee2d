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
      }
    ]);
    map = [];
    for (i = 0; i <= 9; i++) {
      map[i] = [];
      for (j = 0; j <= 9; j++) {
        map[i][j] = new Tile(spriteSheet, 1);
      }
    }
    map[7][5].addHeightIndex(54);
    map[6][5].addHeightIndex(55);
    map[6][4].addHeightIndex(54);
    map[5][4].addHeightIndex(55);
    map[6][4].addHeightIndex(120);
    map[5][5].addHeightIndex(54);
    map[5][5].addHeightIndex(54);
    map[5][5].addHeightIndex(51);
    map[8][5].addHeightIndex(51);
    map[8][6].addHeightIndex(50);
    map[7][6].addHeightIndex(55);
    map[7][4].addHeightIndex(53);
    map[4][4].addHeightIndex(54);
    map[4][5].addHeightIndex(62);
    map[4][5].addHeightIndex(61);
    map[4][5].addHeightIndex(63);
    map[6][6].addHeightIndex(114);
    map[5][6].addHeightIndex(115);
    map[4][6].addHeightIndex(91);
    map[4][7].addHeightIndex(94);
    map[8][2].addHeightIndex(120);
    map[1][7].addHeightIndex(121);
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
