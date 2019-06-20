/**
 * 
 */
package com.botuo.common.service;

import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.persistence.BaseEntity;
import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.DataEntity;
import com.botuo.common.persistence.Page;


/**
 * Service基类
 * 
 * 05-16
 */
@Transactional(readOnly = true)
public abstract class CrudService<D extends CrudDao<T>, T extends DataEntity<T>> extends BaseService {
	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;
	
	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public T get(String id) {
		return dao.get(id);
	}
	
	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	public T get(T entity) {
		return dao.get(entity);
	}
	
	/**
	 * 查询列表数据
	 * @param entity
	 * @return
	 */
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param entity
	 * @return
	 */
	public Page<T> findPage(Page<T> page, T entity) {
		entity.setPage(page);
		page.setList(dao.findList(entity));
		return page;
	}
	/**
	 * 保存数据（插入或更新）
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void save(T entity) {

		if (entity.getIsNewRecord()){
			entity.preInsert();
			dao.insert(entity);
		}else{
			entity.preUpdate();
			dao.update(entity);
		}
	}
	
	/**
	 * 删除数据
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void delete(T entity) {
		dao.delete(entity);
	}
	
	//文本模板替换
	public String replaceTplText(T entity,String tplText){
		return replaceTpl(entity,tplText);
	}
	
	public  String replaceTpl(Object obj,String tplText){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Method[] methods1 = getMethod(obj);
		for (int i = 0;methods1 != null &&  i < methods1.length; i++) {
		     if (methods1[i].getName().startsWith("get") ) {
		    	 try{
		    		 Object obj1 =  methods1[i].invoke(obj); 
		    		 if (obj1 instanceof BaseEntity) {
		    			 //第二层
		    			Method[] methods2 = getMethod(obj1);
	    				for (int ii = 0; ii < methods2.length; ii++) {
	    				     if (methods2[ii].getName().startsWith("get") ) {
	    				    	 try{
	    				    		 Object obj2 =  methods2[ii].invoke(obj1); 
	    				    		 if(obj2 instanceof BaseEntity){
	    				    			 //第三层
	    				    			 /*Method[] methods3 = getMethod(obj2);
	    				    				for (int iii = 0; iii < methods3.length; ii++) {
	    				    				     if (methods3[iii].getName().startsWith("get") ) {
	    				    				    	 try{
	    				    				    		 Object obj3 =  methods3[iii].invoke(obj2); 
	    				    				    		 if(obj3 instanceof BaseEntity){
	    				    				    			 
	    				    				    		 }else{
	    				    				    			 String fieldName = (methods3[iii].getName().substring(3,4)).toLowerCase() + methods3[iii].getName().substring(4);
	    				    					        	 tplText = tplText.replaceAll("##"+fieldName+"##",(String)obj3);
	    				    				    		 }
	    				    				    	 }catch(Exception ex){
	    				    				    		 
	    				    				    	 }
	    				    				     }
	    				    				}*/
	    				    		 }else{
	    				    			 String fieldName = (methods2[ii].getName().substring(3,4)).toLowerCase() + methods2[ii].getName().substring(4);
	    				    			 if(obj2 instanceof String){
	    				    				 tplText = tplText.replaceAll("##"+fieldName+"##",(String)obj2);
	    				    			 }else if(obj2 instanceof Date ){
	    				    				 tplText = tplText.replaceAll("##"+fieldName+"##",sdf.format(obj2));
	    				    			 }else if(obj2 instanceof Double ){
	    				    				 tplText = tplText.replaceAll("##"+fieldName+"##",new DecimalFormat("#.00").format(obj2));
	    				    			 }
	    					        	
	    				    		 }
	    				    	 }catch(Exception ex){
	    				    		 
	    				    	 }
	    				     }
	    				}
		    		 
		    		 }else{
			        	 String fieldName = (methods1[i].getName().substring(3,4)).toLowerCase()+methods1[i].getName().substring(4);
			        	 if(obj1 instanceof String){
		    				 tplText = tplText.replaceAll("##"+fieldName+"##",(String)obj1);
		    			 }else if(obj1 instanceof Date ){
		    				 tplText = tplText.replaceAll("##"+fieldName+"##",sdf.format(obj1));
		    			 }else if(obj1 instanceof Double ){
		    				 tplText = tplText.replaceAll("##"+fieldName+"##",new DecimalFormat("#.00").format(obj1));
		    			 }
			         }
		    	 }catch(Exception ex){
		    		 ex.printStackTrace();
		    	 }
		     }
		}
		return tplText;
	}
	
	public  Method[] getMethod(Object obj){
		 if(obj == null)return null;
		 Method[] methods1 = obj.getClass().getDeclaredMethods();
		 return methods1;
	
	}
	
	public static void main(String[] args) {
		/* String fieldName = ("getAbc".substring(3,4)).toLowerCase()+"getAbc".substring(4);
		 System.out.println(fieldName);
		 String tplText = "aaaaa##tenderMode##cccc##tenderAgencyName##dddd##email##bbbb";
		 Protocol protocol = new Protocol();
		 protocol.setTenderMode("test11111");
		 TenderAgency tenderAgency = new TenderAgency();
		 tenderAgency.setTenderAgencyName("test22222");
		 com.botuo.modules.sys.entity.User user = new com.botuo.modules.sys.entity.User("111");
		 user.setEmail("companyName@163.com");
		 tenderAgency.setUser(user);
		 protocol.setTenderAgency(tenderAgency);
		 //tplText = replaceTpl(protocol,tplText);
		System.out.println(tplText); */
//		Project project = new Project();
//		System.out.println(project.getClass().getName());
	}
}
