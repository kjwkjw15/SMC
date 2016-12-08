package com.yesall.ntts.dao;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.Serializable;  
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;  
import java.util.Date;
import java.util.List;  

import javax.annotation.Resource;  
import javax.persistence.Table;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.Query;  
import org.hibernate.Session;  
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.yesall.ntts.util.DateUtility;




/** 
 * BaseDaoImpl 定义DAO的通用操作的实现 
 * 
 */

@SuppressWarnings("unchecked")
public abstract class BaseDAO<T, PK extends Serializable>  {
	private static final Logger log = LoggerFactory.getLogger(BaseDAO.class);
	
	private Class<T> clazz;
	private String entityName;
	private String tableName;
	
	/** 
	 * 通过构造方法指定DAO的具体实现类 
	 */
	public BaseDAO() {
		super();
        clazz = (Class<T>) ((ParameterizedType) (getClass().getGenericSuperclass())).getActualTypeArguments()[0];
        entityName = clazz.getSimpleName();

		Table t = (Table) clazz.getAnnotation(Table.class);
		tableName = t.name();
		
		log.debug("DAO的真实实现类是：" + this.clazz.getName());  
	}

	/** 
	 * 向DAO层注入SessionFactory  
	 */  
	@Resource  
	private SessionFactory sessionFactory;  

	/** 
	 * 获取当前工作的Session 
	 */  
	protected Session getSession() {  
		//return this.sessionFactory.openSession();  
		return this.sessionFactory.getCurrentSession();
	}  

	public void save(T entity) {  
		this.getSession().save(entity);  
	}  

	public void update(T entity) {  
		this.getSession().update(entity);  
	}  

	public void saveOrUpdate(T entity) {  
		this.getSession().saveOrUpdate(entity);  
	}  

	public void delete(PK id) {  
		this.getSession().delete(this.findById(id));  
	}  

	public T findById(PK id) {  
		return (T) this.getSession().get(this.clazz, id);  
	}
	
	/**  
	    * <根据字段名及对应的值（只做等于的判断），得到对应的list>
	    * @param propertyName 以半角逗号分割的属性名
	    * @param propertyValue 属性值
	    * @return List<T>
	    */ 
	public List<T> findByProperty(String propertyName, Object propertyValue) {
		return findByProperties(propertyName, propertyValue);
	}
	
	/**  
	    * <根据字段名及对应的值（只做等于的判断），得到对应的list>
	    * @param propertyNames 以半角逗号分割的属性名
	    * @param propertyValues 与propertyName位置一一对应的属性值
	    * @return List<T>
	    */ 
	public List<T> findByProperties(String propertyNames, Object... propertyValues) {
		byte[] propertyOperatorArray = new byte[propertyValues.length];
		for (int i = 0; i < propertyOperatorArray.length; i++) {
			propertyOperatorArray[i] = '=';
		}
		
	 	String propertyOperators = new String(propertyOperatorArray);
	 	return findByProperties(propertyNames, propertyOperators, propertyValues);
	}
 
 	/**  
	    * <根据字段名、运算符和对应的值，得到对应的list>
	    * @param propertyNames 以半角逗号分割的属性名
	    * @param propertyOperators 与propertyName位置一一对应的运算符
	    * @param propertyValues 与propertyName位置一一对应的属性值
	    * @return List<T>
	    */ 
 	public List<T> findByProperties(String propertyNames, String propertyOperators, final Object... propertyValues) {
		try {
			String[] propertyNameArray = propertyNames.split(",");
			String[] propertyOperatorArray = propertyOperators.split(",");
			if(propertyNameArray.length != propertyOperatorArray.length || propertyNameArray.length != propertyValues.length)
				throw new RuntimeException("Invalid params and/or values");
			
			StringBuilder sbQueryString = new StringBuilder("from " +entityName+ " as model");
			if(propertyValues.length > 0) {
				sbQueryString.append(" where ");
				for (int i = 0; i < propertyValues.length; i++) {
					if(i > 0) {
						sbQueryString.append(" and ");
					}
					sbQueryString.append("model.");
					sbQueryString.append(propertyNameArray[i]);
					sbQueryString.append(propertyOperatorArray[i]);
					sbQueryString.append("?");
				}
			}

			Query queryObject = this.getSession().createQuery(sbQueryString.toString()); 
			for (int i = 0; propertyValues != null && i < propertyValues.length; i++) {  
				queryObject.setParameter(i, propertyValues[i]);  
			}
			return queryObject.list();
		} catch (RuntimeException re) {
			throw re;
		}
	} 
	

 	
 	
	/**
	 * 
	    * 方法功能说明：  生成原生SQL的方式，查询得到JSONArray对象。
	    * 创建：2016年12月3日 by Vison   
	    * 修改：日期 by 修改者  
	    * 修改内容：  
	    * @参数： @param sql 要执行的SQL语句（可以带?参数，需要与下面的params一致）
	    * @参数： @param jsonFieldsString 与sql执行结果的列序对应的json对象key名列表（以逗号分割，若与sql一致应可以不用传入，但目前仍然需要传入）
	    * @参数： @param propertyValues 与sql对应的参数值
	    * @参数： @return      
	    * @return JSONArray
	    * @throws
	 */
	public JSONArray findBySQL(String sql, String jsonFieldsString, Object... propertyValues) {
		Query queryObject = this.getSession().createSQLQuery(sql); 
		for (int i = 0; propertyValues != null && i < propertyValues.length; i++) {  
			queryObject.setParameter(i, propertyValues[i]);  
		}
		
		List<Object[]> list = queryObject.list();
		if(list==null || list.size()==0) {
			return new JSONArray();
		}
		
		String[] jsonFieldArray = jsonFieldsString.split(",");
		if(jsonFieldArray.length != list.get(0).length) {
			return new JSONArray();	//有时间时可以通过ResultSet来获取返回的字段名，则jsonFieldsString可以不用传入，但目前需要两者匹配
		}
		for(int i=0; i<jsonFieldArray.length; i++) {
			jsonFieldArray[i]= jsonFieldArray[i].trim(); 
		}
		
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i<list.size(); i++) {
			JSONObject jsonObject = new JSONObject();
			
			for(int j=0; j<jsonFieldArray.length; j++) {
				Object obj = list.get(i)[j];
				if(obj instanceof Date) {
					jsonObject.put(jsonFieldArray[j], DateUtility.ToDateTimeString((Date)obj));
				}
				else {
					jsonObject.put(jsonFieldArray[j], obj);
				}
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	
	/**  
	    * <根据字段名和对应的值（只做等于的判断），删除记录>
	    * @param fieldName 以半角逗号分割的字段名
	    * @param fieldValue 字段值
	    * @return int 受影响的行数
	    */ 
	public int deleteByField(String fieldName, Object fieldValue) {
		return deleteByFields(fieldName, fieldValue);
	}
	
	/**  
	    * <根据字段名和对应的值（只做等于的判断），删除记录>
	    * @param fieldNames 以半角逗号分割的字段名
	    * @param fieldValues 与fieldName位置一一对应的字段值
	    * @return int 受影响的行数
	    */ 
	public int deleteByFields(String fieldNames, Object... fieldValues) {
		byte[] fieldOperatorArray = new byte[fieldValues.length];
		for (int i = 0; i < fieldOperatorArray.length; i++) {
			fieldOperatorArray[i] = '=';
		}
		
	 	String fieldOperators = new String(fieldOperatorArray);
	 	return deleteByFields(fieldNames, fieldOperators, fieldValues);
	}

	/**  
	    * <根据字段名、运算符和对应的值，删除记录>
	    * @param fieldNames 以半角逗号分割的字段名
	    * @param fieldOperators 与fieldName位置一一对应的运算符
	    * @param fieldValues 与fieldName位置一一对应的字段值
	    * @return int 受影响的行数
	    */ 
	public int deleteByFields(String fieldNames, String fieldOperators, final Object... fieldValues) {
		try {
			String[] fieldNameArray = fieldNames.split(",");
			String[] fieldOperatorArray = fieldOperators.split(",");
			if(fieldNameArray.length != fieldOperatorArray.length || fieldNameArray.length != fieldValues.length)
				throw new RuntimeException("Invalid params and/or values");
			
			StringBuilder sbQueryString = new StringBuilder("delete " +tableName);
			if(fieldValues.length > 0) {
				sbQueryString.append(" where ");
				for (int i = 0; i < fieldValues.length; i++) {
					if(i > 0) {
						sbQueryString.append(" and ");
					}
					
					sbQueryString.append(fieldNameArray[i]);
					sbQueryString.append(fieldOperatorArray[i]);
					sbQueryString.append("?");
				}
			}
			
			return execSQL(sbQueryString.toString(), fieldValues);
		} catch (RuntimeException re) {
			throw re;
		}
	} 
	
	
	public boolean updateField(PK id, String fieldName, Object fieldValue) {
		return updateFields(id, fieldName, fieldValue);
	}

	public boolean updateFields(PK id, String fieldNames, Object... fieldValues) {
		try {
			String[] fieldNameArray = fieldNames.split(",");
			if(fieldNameArray.length != fieldValues.length || fieldNameArray.length == 0)
				throw new RuntimeException("Invalid params and/or values");
			
			T entity = findById(id);
			for(int i=0; i<fieldNameArray.length; i++) {
				String fieldName = fieldNameArray[i];
				
				PropertyDescriptor pd = new PropertyDescriptor(fieldName, clazz);
		        Method setMethod = pd.getWriteMethod();
		        if(setMethod != null){
		        	setMethod.invoke(entity, fieldValues[i]);
		        }
			}
			
			update(entity);
			return true;
		} catch (Exception re) {
			return false;
		}
	}
	
	
	/**
	 * 
	    * 方法功能说明：  执行SQL语句，返回受影响的记录数
	    * 创建：2016年12月7日 by Vison  
	    * @参数： @param sql
	    * @参数： @param propertyValues
	    * @参数： @return      
	    * @return int     
	    * @throws
	 */
	public int execSQL(String sql, Object... propertyValues) {
		Query queryObject = this.getSession().createSQLQuery(sql); 
		for (int i = 0; propertyValues != null && i < propertyValues.length; i++) {  
			queryObject.setParameter(i, propertyValues[i]);  
		}
		return queryObject.executeUpdate();
	}
}
