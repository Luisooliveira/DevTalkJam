#macro TILE_SIZE 16

var width = room_width div TILE_SIZE;
var height = room_height div TILE_SIZE;

var layerID = layer_get_id("Collision");
var tilemapID = layer_tilemap_get_id(layerID);

if (ds_exists(global.tileGrid, ds_type_grid))
{
	ds_grid_destroy(global.tileGrid);
}

global.tileGrid = ds_grid_create(width, height);
ds_grid_clear(global.tileGrid, 0);

for (var i = 0; i < width; i++)
{
	for (var j = 0; j < height; j++)
	{
		global.tileGrid[# i, j] = tilemap_get(tilemapID, i, j);
	}
}
