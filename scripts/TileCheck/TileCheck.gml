///@param x
///@param y
function TileCheck(_x, _y)
{
	// Check for tile in the position
	return (global.tileGrid[# _x div TILE_SIZE, _y div TILE_SIZE] > 0);
}