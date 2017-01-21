package com.yesall.ntts.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import net.sf.ezmorph.MorphException;
import net.sf.ezmorph.object.AbstractObjectMorpher;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import net.sf.json.util.JSONUtils;
import net.sf.json.util.PropertyFilter;


public class JsonUtility {
	private static JsonDateValueProcessor jsonDateValueProcessor = new JsonUtility().new JsonDateValueProcessor();
	
	private static String[] DATE_FORMATS = new String[] {"yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd HH:mm:ss", "yyyy-MM-dd", "yyyy/MM/dd"};
	private static final DateMorpher DATE_MORPHER = new DateMorpher(DATE_FORMATS);
	private static final TimeStampMorpher TIMESTAMP_MOPHER = new JsonUtility().new TimeStampMorpher();
	
	/**
	 * 
	    * 方法功能说明：  将对象转换为JSONObject，可以规避属性死循环的问题
	    * @参数： @param obj 对象
	    * @参数： @param excludeRegEx （参数暂未起作用，将恒定取值“^(msgpkgUp|msgpkgDn).*”）
	    * @参数： @return      
	    * @return JSONObject     
	    * @throws
	 */
	public static JSONObject ConvertFrom(Object obj, final String excludeRegEx) {
		if(excludeRegEx==null || excludeRegEx.equals(""))
			return JSONObject.fromObject(obj);
				
		JsonConfig jsonConfig = new JsonConfig();
		
		jsonConfig.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value)
            {
            	return Pattern.matches("^(baseInfo|msgpkgDn|ura).*", name);
            	//return Pattern.matches(excludeRegEx, name);
            }
        });
		
		jsonConfig.registerJsonValueProcessor(Date.class, jsonDateValueProcessor);
		jsonConfig.registerJsonValueProcessor(Timestamp.class, jsonDateValueProcessor);

		return JSONObject.fromObject(obj, jsonConfig);
	}
	
	public static <E> E ConvertTo(Class<E> entityClass, JSONObject json) {
		JSONUtils.getMorpherRegistry().registerMorpher(DATE_MORPHER);
		JSONUtils.getMorpherRegistry().registerMorpher(TIMESTAMP_MOPHER);
		return (E) JSONObject.toBean(json, entityClass);
	}
	
	
	
	public static <E> List<E> ConvertTo(Class<E> entityClass, JSONArray jsonArray) {
		if(jsonArray == null || jsonArray.size()==0) {
			return null;
		}
		
//		JsonValueProcessor jsonValueProcessor = new JsonDateValueProcessor() {
//			@Override
//			public Object processObjectValue(String propertyName, Object date, JsonConfig jsonConfig) {
//				return DateUtility.ToDateTimeString(date);
//			}
//			
//			
//		};
//		
//		JsonConfig jsonConfig = new JsonConfig();
//		//jsonConfig.registerJsonBeanProcessor(DateMorpher.class, jsonBeanProcessor);
		
		List<E> list = new ArrayList<E>(jsonArray.size());
		for(int i=0; i<jsonArray.size(); i++) {
			E obj = ConvertTo(entityClass, jsonArray.getJSONObject(i));
			list.add(obj);
		}
		return list;
	}

	
	class JsonDateValueProcessor implements JsonValueProcessor {
		private String format = DateUtility.DateTimeStringFormat;
	      
	    public JsonDateValueProcessor() {  
	        super();  
	    }  
	      
	    public JsonDateValueProcessor(String format) {  
	        super();  
	        this.format = format;  
	    }  
	  
	    @Override  
	    public Object processArrayValue(Object paramObject, JsonConfig paramJsonConfig) {  
	        return process(paramObject);  
	    }  
	  
	    @Override  
	    public Object processObjectValue(String paramString, Object paramObject, JsonConfig paramJsonConfig) {  
	        return process(paramObject);  
	    }  
	      
	      
	    private Object process(Object value){  
	        if(value instanceof Date  || value instanceof Timestamp){
	    		SimpleDateFormat sdf =  new SimpleDateFormat(format);   
	            return sdf.format(value);  
	        }
	        return value == null ? "" : value.toString();    
	    }  
	}
	
	class TimeStampMorpher extends AbstractObjectMorpher{
	    public TimeStampMorpher() {   
	        // TODO Auto-generated constructor stub   
	    }   
	       
	    public TimeStampMorpher(String[] formats) {   
	    	DATE_FORMATS = formats;   
	    }   
	   
	    @Override   
	    public Object morph(Object dateStr) {   
	        // TODO Auto-generated method stub   
	        if(null == dateStr){  
	          return null;  
	        }  
	        if(Timestamp.class.isAssignableFrom(dateStr.getClass())){  
	            return (Timestamp)dateStr;  
	        }  
	        if(!supports(dateStr.getClass())){  
	          throw new MorphException(dateStr.getClass()+"不是支持的类型！");  
	        }  
	        String strValue = (String)dateStr;  
	        SimpleDateFormat dateParser = null;  
	        for(int i=0,k=DATE_FORMATS.length;i<k;i++){  
	           if(null == dateParser){  
	                dateParser = new SimpleDateFormat(DATE_FORMATS[i]);  
	           }else{  
	                dateParser.applyPattern(DATE_FORMATS[i]);  
	           }  
	           try{  
	              return new Timestamp(dateParser.parse(strValue.toLowerCase()).getTime());  
	           }catch(ParseException e){  
	             e.printStackTrace();  
	           }  
	        }  
	        return new  java.sql.Timestamp(System.currentTimeMillis());//返回默认日期        
	    }   
	   
	    @Override   
	    public Class morphsTo() {   
	        // TODO Auto-generated method stub   
	        return Timestamp.class;   
	    }   
	    public boolean supports(Class claszz){  
	            return String.class.isAssignableFrom(claszz);  
	    }  
	}   
}
