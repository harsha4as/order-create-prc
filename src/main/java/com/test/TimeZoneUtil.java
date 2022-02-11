package com.test;

import java.util.TimeZone;

public class TimeZoneUtil {
	
	public static String getCurrentTimeZone()
	{
		java.util.TimeZone tz = TimeZone.getDefault();
		return tz.getDisplayName(true, 0);
		
	}
	

}
