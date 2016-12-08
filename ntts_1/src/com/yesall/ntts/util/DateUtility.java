package com.yesall.ntts.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public final class DateUtility {
	public static final String DateStringFormat = "MM/dd/yyyy";
	public static final String DateTimeStringFormat = "MM/dd/yyyy HH:mm:ss";
	
	/*
	 * @param datePart 需要以Calendar.DAY/MONTH等枚举方式
	 */
	public static Date dateAdd(Date date, int datePart, int dateNumber) {
		Calendar theCa = Calendar.getInstance();
		theCa.setTime(date);
		theCa.add(datePart, -1);
		return theCa.getTime();
	}

	public static String ToDateString(Date date) {
		return ToDateString(date, DateUtility.DateStringFormat);
	}
	public static String ToDateString(Date date, String dateStringFormat) {
		SimpleDateFormat sdf =  new SimpleDateFormat(dateStringFormat);
		return sdf.format(date);
	}

	public static String ToDateTimeString(Date date) {
		return ToDateTimeString(date, DateUtility.DateTimeStringFormat);
	}
	public static String ToDateTimeString(Date date, String datetimeStringFormat) {
		SimpleDateFormat sdf =  new SimpleDateFormat(datetimeStringFormat);
		return sdf.format(date);
	}
	
	public static Date ParseDate(String dateString) throws ParseException {
		SimpleDateFormat sdf =  new SimpleDateFormat(DateUtility.DateStringFormat);
		return sdf.parse(dateString);
	}
	public static Date ParseDatetime(String datetimeString) throws ParseException {
		SimpleDateFormat sdf =  new SimpleDateFormat(DateUtility.DateTimeStringFormat);
		return sdf.parse(datetimeString);
	}
}
