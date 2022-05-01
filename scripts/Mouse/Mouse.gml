function MouseIsDragging()
{
	var dragging = (global.lastMouseX != mouse_x || global.lastMouseY != mouse_y);
	
	global.lastMouseX = mouse_x;
	global.lastMouseY = mouse_y;
	
	return dragging;
}