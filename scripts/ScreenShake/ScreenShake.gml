function ScreenShake(magnitude, frames)
{
	with (oCamera)
	{
		if (magnitude > shakeRemain)
		{
			shakeMagnitude = magnitude;
			shakeRemain = magnitude;
			shakeLength = frames;
		}
	}
}
