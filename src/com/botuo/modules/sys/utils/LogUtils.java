/**
 * 
 */
package com.botuo.modules.sys.utils;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggingEvent;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.method.HandlerMethod;

import com.botuo.common.config.Global;
import com.botuo.common.utils.CacheUtils;
import com.botuo.common.utils.Exceptions;
import com.botuo.common.utils.SpringContextHolder;
import com.botuo.common.utils.StringUtils;
import com.botuo.entity.Log;
import com.botuo.entity.Menu;
import com.botuo.entity.User;
import com.botuo.modules.sys.dao.LogDao;
import com.botuo.modules.sys.dao.MenuDao;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;


/**
 * 字典工具类
 * 
 * 11-7
 */
public class LogUtils {
	
	public static final String CACHE_MENU_NAME_PATH_MAP = "menuNamePathMap";
	
	private static LogDao logDao = SpringContextHolder.getBean(LogDao.class);
	private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
	
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, String title){
		saveLog(request, null, null, title);
	}
	
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, Object handler, Exception ex, String title){
		User user = UserUtils.getUser();
		if (user != null && user.getId() != null){
			Log log = new Log();
			log.setTitle(title);
			log.setType(ex == null ? Log.TYPE_ACCESS : Log.TYPE_EXCEPTION);
			log.setRemoteAddr(StringUtils.getRemoteAddr(request));
			log.setUserAgent(request.getHeader("user-agent"));
			log.setRequestUri(request.getRequestURI());
			log.setParams(request.getParameterMap());
			log.setMethod(request.getMethod());
			// 异步保存日志
			new SaveLogThread(log, handler, ex).start();
		}
	}
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, Object handler, Exception ex, String title,String params){
		User user = UserUtils.getUser();
		if (user != null && user.getId() != null){
			Log log = new Log();
			log.setTitle(title);
			log.setType(ex == null ? Log.TYPE_ACCESS : Log.TYPE_EXCEPTION);
			log.setRemoteAddr(StringUtils.getRemoteAddr(request));
			log.setUserAgent(request.getHeader("user-agent"));
			log.setRequestUri(request.getRequestURI());
			log.setParams(params);
			log.setMethod(request.getMethod());
			// 异步保存日志
			new SaveLogThread(log, handler, ex).start();
		}
	}
	/**
	 * 保存日志线程
	 */
	public static class SaveLogThread extends Thread{
		
		private Log log;
		private Object handler;
		private Exception ex;
		
		public SaveLogThread(Log log, Object handler, Exception ex){
			super(SaveLogThread.class.getSimpleName());
			this.log = log;
			this.handler = handler;
			this.ex = ex;
		}
		
		@Override
		public void run() {
			// 获取日志标题
			if (StringUtils.isBlank(log.getTitle())){
				String permission = "";
				if (handler instanceof HandlerMethod){
					Method m = ((HandlerMethod)handler).getMethod();
					RequiresPermissions rp = m.getAnnotation(RequiresPermissions.class);
					permission = (rp != null ? StringUtils.join(rp.value(), ",") : "");
				}
				log.setTitle(getMenuNamePath(log.getRequestUri(), permission));
			}
			// 如果有异常，设置异常信息
			log.setException(Exceptions.getStackTraceAsString(ex));
			// 如果无标题并无异常日志，则不保存信息
			if (StringUtils.isBlank(log.getTitle()) && StringUtils.isBlank(log.getException())){
				return;
			}
			// 保存日志信息
//			log.setCurrentUser(UserUtils.getUser());
//			log.preInsert();
//			logDao.insert(log);
		}
	}

	/**
	 * 获取菜单名称路径（如：系统设置-机构用户-用户管理-编辑）
	 */
	public static String getMenuNamePath(String requestUri, String permission){
		String href = StringUtils.substringAfter(requestUri, Global.getAdminPath());
		@SuppressWarnings("unchecked")
		Map<String, String> menuMap = (Map<String, String>)CacheUtils.get(CACHE_MENU_NAME_PATH_MAP);
		if (menuMap == null){
			menuMap = Maps.newHashMap();
			List<Menu> menuList = menuDao.findAllList(new Menu());
			for (Menu menu : menuList){
				// 获取菜单名称路径（如：系统设置-机构用户-用户管理-编辑）
				String namePath = "";
				if (menu.getParentIds() != null){
					List<String> namePathList = Lists.newArrayList();
					for (String id : StringUtils.split(menu.getParentIds(), ",")){
						if (Menu.getRootId().equals(id)){
							continue; // 过滤跟节点
						}
						for (Menu m : menuList){
							if (m.getId().equals(id)){
								namePathList.add(m.getName());
								break;
							}
						}
					}
					namePathList.add(menu.getName());
					namePath = StringUtils.join(namePathList, "-");
				}
				// 设置菜单名称路径
				if (StringUtils.isNotBlank(menu.getHref())){
					menuMap.put(menu.getHref(), namePath);
				}else if (StringUtils.isNotBlank(menu.getPermission())){
					for (String p : StringUtils.split(menu.getPermission())){
						menuMap.put(p, namePath);
					}
				}
				
			}
			CacheUtils.put(CACHE_MENU_NAME_PATH_MAP, menuMap);
		}
		String menuNamePath = menuMap.get(href);
		if (menuNamePath == null){
			for (String p : StringUtils.split(permission)){
				menuNamePath = menuMap.get(p);
				if (StringUtils.isNotBlank(menuNamePath)){
					break;
				}
			}
			if (menuNamePath == null){
				return "";
			}
		}
		return menuNamePath;
	}

	/**
	 * 获取日对象
	 * 
	 * @param obj
	 *            对象
	 * @return
	 */
	public static Logger get(Object obj) {
		return get(obj.getClass());
	}

	/**
	 * 获取日志对象
	 * 
	 * @param cls
	 *            类型
	 * @return
	 */
	public static Logger get(Class<?> cls) {
		return get(cls.getName());
	}

	/**
	 * 获取日志对象
	 * 
	 * @param name
	 *            名称
	 * @return
	 */
	public static Logger get(String name) {
		return Logger.getLogger(name);
	}

	/**
	 * 提示
	 * 
	 * @param message
	 *            消息
	 */
	public static void info(Object message) {
		log(Level.INFO, message, null);
	}

	/**
	 * 警告
	 * 
	 * @param message
	 *            消息
	 */
	public static void warn(Object message) {
		log(Level.WARN, message, null);
	}

	/**
	 * 调试
	 * 
	 * @param message
	 *            消息
	 */
	public static void debug(Object message) {
		log(Level.DEBUG, message, null);
	}

	/**
	 * 错误
	 * 
	 * @param message
	 *            消息
	 */
	public static void error(Object message) {
		log(Level.ERROR, message, null);
	}

	/**
	 * 错误
	 * 
	 * @param e
	 *            异常
	 */
	public static void error(Throwable e) {
		log(Level.ERROR, e.getMessage(), e);
	}

	/**
	 * 错误
	 * 
	 * @param message
	 *            消息
	 * @param e
	 *            异常
	 */
	public static void error(Object message, Throwable e) {
		log(Level.ERROR, message, e);
	}

	/**
	 * 打印日志
	 * 
	 * @param level
	 *            日志等级
	 * @param message
	 *            消息
	 * @param e
	 *            异常
	 */
	public static void log(Level level, Object message, Throwable e) {
		Logger logger = null;

		StackTraceElement[] stack = Thread.currentThread().getStackTrace();
		if (stack[2].getClassName().equals(LogUtils.class.getName())) {
			logger = get(stack[3].getClassName());
		} else {
			logger = get(stack[2].getClassName());
		}

		if (logger != null) {
			int levelFlag = -1;
			if (level.getClass().equals(Level.INFO)) {
				levelFlag = Level.ERROR_INT;
			} else if (level.getClass().equals(Level.WARN)) {
				levelFlag = Level.WARN_INT;
			} else if (level.getClass().equals(Level.DEBUG)) {
				levelFlag = Level.DEBUG_INT;
			} else if (level.getClass().equals(Level.ERROR)) {
				levelFlag = Level.ERROR_INT;
			}

			if (levelFlag == -1) {
				if (!logger.getLoggerRepository().isDisabled(levelFlag) && level.isGreaterOrEqual(logger.getEffectiveLevel())) {
					logger.callAppenders(new LoggingEvent(LogUtils.class.getName(), logger, level, message, e));
				}
			}
		}
	}
}
