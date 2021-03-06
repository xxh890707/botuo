/**
 * 
 */
package com.botuo.modules.sys.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.botuo.common.service.BaseService;
import com.botuo.common.utils.CacheUtils;
import com.botuo.common.utils.SpringContextHolder;
import com.botuo.entity.Menu;
import com.botuo.entity.Office;
import com.botuo.entity.Role;
import com.botuo.entity.User;
import com.botuo.modules.sys.dao.MenuDao;
import com.botuo.modules.sys.dao.OfficeDao;
import com.botuo.modules.sys.dao.RoleDao;
import com.botuo.modules.sys.dao.UserDao;
import com.botuo.modules.sys.security.SystemAuthorizingRealm.Principal;

/**
 * 用户工具类
 * 
 * 12-05
 */
public class UserUtils {

	private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
	private static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
	private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
	/*private static TenderAgencyService tenderAgencyService = SpringContextHolder.getBean(TenderAgencyService.class);
	private static TendererService tendererService = SpringContextHolder.getBean(TendererService.class);
	private static BidderService bidderService = SpringContextHolder.getBean(BidderService.class);
	private static ExpertService expertService = SpringContextHolder.getBean(ExpertService.class);*/
	
	
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);

	public static final String USER_CACHE = "userCache";
	
	public static final String USER_CACHE_WITH_USER_SUBJECT = "userCacheWithUserSubject";
	public static final String USER_CACHE_ID_ = "id_";
	public static final String USER_CACHE_LOGIN_NAME_ = "ln";
	public static final String USER_CACHE_CA_SERIAL_NO_ = "caSerialNo_";
	public static final String USER_CACHE_LIST_BY_OFFICE_ID_ = "oid_";

	public static final String CACHE_ROLE_LIST = "roleList";
	public static final String CACHE_MENU_LIST = "menuList";
	public static final String CACHE_AREA_LIST = "areaList";
	public static final String CACHE_OFFICE_LIST = "officeList";
	public static final String CACHE_OFFICE_ALL_LIST = "officeAllList";
	
	/**
	 * 根据ID获取用户
	 * @param id
	 * @return 取不到返回null
	 */
	public static User get(String id){
		User user = (User)CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
//		User user = null;	//modify by zhangzq
		if (user ==  null){
			user = userDao.get(id);
			if (user == null){
				return null;
			}
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}
	
	


	
	
	
	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return 取不到返回null
	 */
	public static User getByLoginName(String loginName){
		User user = (User)CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ + loginName);
		if (user == null){
			user = userDao.getByLoginName(new User(null, loginName));
			if (user == null){
				return null;
			}
			//加入角色
			user.setRoleList(getRoleListByUser(user));
			//只有通过审核的才能赋予权限   by xiaohu
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}

	
	/**
	 * 清除当前用户缓存
	 */
	public static void clearCache(){
		removeCache(CACHE_ROLE_LIST);
		removeCache(CACHE_MENU_LIST);
		removeCache(CACHE_AREA_LIST);
		removeCache(CACHE_OFFICE_LIST);
		removeCache(CACHE_OFFICE_ALL_LIST);
		UserUtils.clearCache(getUser());
	}
	
	/**
	 * 清除指定用户缓存
	 * @param user
	 */
	public static void clearCache(User user){
		CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getOldLoginName());
		if (user.getOffice() != null && user.getOffice().getId() != null){
			CacheUtils.remove(USER_CACHE, USER_CACHE_LIST_BY_OFFICE_ID_ + user.getOffice().getId());
		}
	}
	
	/**
	 * 获取当前用户
	 * @return 取不到返回 new User()
	 */
	public static User getUser(){
		Principal principal = getPrincipal();
		if (principal!=null){
			User user = get(principal.getId());
			if (user != null){
				return user;
			}
			return new User();
		}
		// 如果没有登录，则返回实例化空的User对象。
		return new User();
	}

	/**
	 * 获取当前用户角色列表
	 * @return
	 */
	public static List<Role> getRoleList(){
		@SuppressWarnings("unchecked")
		List<Role> roleList = (List<Role>)getCache(CACHE_ROLE_LIST);
		if (roleList == null){
			User user = getUser();
			if (user != null && user.isAdmin()){
				roleList = roleDao.findAllList(new Role());
			}else{
				Role role = new Role();
				if(UserUtils.getUser() != null && StringUtils.isNotEmpty(UserUtils.getUser().getId())){
					role.getSqlMap().put("dsf", BaseService.dataScopeFilter(UserUtils.getUser(), "o", "u"));
				}else{
					role.getSqlMap().put("dsf","");
				}
				roleList = roleDao.findList(role);
			}
			putCache(CACHE_ROLE_LIST, roleList);
		}
		return roleList;
	}
	
	/**
	 * 获取指定用户角色列表
	 * @param user
	 * @return
	 * 20171120	add by zhangzq
	 */
	public static List<Role> getRoleListByUser(User user){
		List<Role> roleList = new ArrayList<Role>();
		Role role = new Role();
		if(user != null && StringUtils.isNotEmpty(user.getId())){
			role.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "o", "u"));
		}else{
			role.getSqlMap().put("dsf","");
		}
		roleList = roleDao.findList(role);
		return roleList;
	}
	
	/**
	 * 获取当前用户授权菜单
	 * @return
	 */
	public static List<Menu> getMenuList(){
		@SuppressWarnings("unchecked")
		List<Menu> menuList = (List<Menu>)getCache(CACHE_MENU_LIST);
		if (menuList == null){
			User user = getUser();
			if (user.isAdmin()){
				menuList = menuDao.findAllList(new Menu());
			}else{
				Menu m = new Menu();
				m.setUserId(user.getId());
				menuList = menuDao.findByUserId(m);
			}
			putCache(CACHE_MENU_LIST, menuList);
		}
		return menuList;
	}
	

	
	/**
	 * 获取当前用户有权限访问的部门
	 * @return
	 */
	public static List<Office> getOfficeList(){
		@SuppressWarnings("unchecked")
		List<Office> officeList = (List<Office>)getCache(CACHE_OFFICE_LIST);
		if (officeList == null){
			User user = getUser();
			if (user.isAdmin()){
				officeList = officeDao.findAllList(new Office());
			}else{
				Office office = new Office();
				office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
				officeList = officeDao.findList(office);
			}
			putCache(CACHE_OFFICE_LIST, officeList);
		}
		return officeList;
	}

	/**
	 * 获取当前用户有权限访问的部门
	 * @return
	 */
	public static List<Office> getOfficeAllList(){
		@SuppressWarnings("unchecked")
		List<Office> officeList = (List<Office>)getCache(CACHE_OFFICE_ALL_LIST);
		if (officeList == null){
			officeList = officeDao.findAllList(new Office());
		}
		return officeList;
	}
	
	/**
	 * 获取授权主要对象
	 */
	public static Subject getSubject(){
		return SecurityUtils.getSubject();
	}
	
	/**
	 * 获取当前登录者对象
	 */
	public static Principal getPrincipal(){
		try{
			Subject subject = SecurityUtils.getSubject();
			Principal principal = (Principal)subject.getPrincipal();
			if (principal != null){
				return principal;
			}
//			subject.logout();
		}catch (UnavailableSecurityManagerException e) {
			
		}catch (InvalidSessionException e){
			
		}
		return null;
	}
	
	public static Session getSession(){
		try{
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(false);
			if (session == null){
				session = subject.getSession();
			}
			if (session != null){
				return session;
			}
//			subject.logout();
		}catch (InvalidSessionException e){
			
		}
		return null;
	}
	
	// ============== User Cache ==============
	
	public static Object getCache(String key) {
		return getCache(key, null);
	}
	
	public static Object getCache(String key, Object defaultValue) {
//		Object obj = getCacheMap().get(key);
		Object obj = getSession().getAttribute(key);
		return obj==null?defaultValue:obj;
	}

	public static void putCache(String key, Object value) {
//		getCacheMap().put(key, value);
		getSession().setAttribute(key, value);
	}

	public static void removeCache(String key) {
//		getCacheMap().remove(key);
		getSession().removeAttribute(key);
	}
	
//	public static Map<String, Object> getCacheMap(){
//		Principal principal = getPrincipal();
//		if(principal!=null){
//			return principal.getCacheMap();
//		}
//		return new HashMap<String, Object>();
//	}
	
	/**
	 * 检查当前用户是否包含角色
	 * @param roleIdentifier
	 * @return
	 */
	public static boolean checkRole(String roleIdentifier){
		try {
			Subject subject = SecurityUtils.getSubject();
			subject.checkRole(roleIdentifier);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/**
	 * 判断是否已经登录
	 * @return
	 * @since 2017年11月23日 下午6:05:31
	 * @author chenguojun<chengj@everygold.com>
	 * @version v1.0
	 */
	public static boolean isLogin(){
		Principal principal = getPrincipal();
		if(principal!=null && StringUtils.isNoneBlank(principal.getLoginName())){
			return true;
		}
		return false;
	}

}
