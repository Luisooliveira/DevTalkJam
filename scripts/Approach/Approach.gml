function Approach(a, b, amount)
{
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return a;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}
