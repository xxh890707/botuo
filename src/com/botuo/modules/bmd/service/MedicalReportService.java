/**
 * 
 */
package com.botuo.modules.bmd.service;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.config.Global;
import com.botuo.common.persistence.Page;
import com.botuo.common.service.CrudService;
import com.botuo.common.utils.CacheUtils;
import com.botuo.common.utils.DateUtils;
import com.botuo.common.utils.IdGen;
import com.botuo.common.utils.MathUtil;
import com.botuo.common.utils.QrCodeUtil;
import com.botuo.common.utils.StringUtils;
import com.botuo.entity.User;
import com.botuo.modules.bmd.constants.Constants;
import com.botuo.modules.bmd.dao.MedicalElementDao;
import com.botuo.modules.bmd.dao.MedicalReportDao;
import com.botuo.modules.bmd.dao.MedicalResultDao;
import com.botuo.modules.bmd.entity.MedicalElement;
import com.botuo.modules.bmd.entity.MedicalReport;
import com.botuo.modules.bmd.entity.MedicalResult;
import com.botuo.modules.bmd.entity.OfficeMedicalType;
import com.botuo.modules.sys.utils.UserUtils;

/**
 * 检查报告表Service
 * @author xiaohu
 * @version 2018-01-18
 */
@Service
@Transactional(readOnly = true)
public class MedicalReportService extends CrudService<MedicalReportDao, MedicalReport> {
	@Autowired
	private MedicalElementDao medicalElementDao;
	@Autowired
	private OfficeMedicalTypeService officeMedicalTypeService;
	@Autowired
	private MedicalResultDao medicalResultDao;

	public MedicalReport get(String id) {
		return super.get(id);
	}
	
	public List<MedicalReport> findList(MedicalReport medicalReport) {
		return super.findList(medicalReport);
	}
	
	public Page<MedicalReport> findPage(Page<MedicalReport> page, MedicalReport medicalReport) {
		User user = UserUtils.getUser();
		medicalReport.getSqlMap().put("dsf", dataScopeFilter(user, "o",null));
		return super.findPage(page, medicalReport);
	}
	
	public Page<MedicalReport> searchPage(Page<MedicalReport> page, MedicalReport medicalReport){
		medicalReport.setPage(page);
		User user = UserUtils.getUser();
		medicalReport.getSqlMap().put("dsf", dataScopeFilter(user, "o",null));
		page.setList(dao.findReportPage(medicalReport));
		return page;
	}
	
	@Transactional
	public void save(MedicalReport medicalReport) {
		if(StringUtils.isEmpty(medicalReport.getId())){
			medicalReport.setId(IdGen.uuid());
		}
		try {
//			if(medicalReport.getResults().size() >0){
//				for (MedicalResult result : medicalReport.getResults()) {
//					if(StringUtils.isNotEmpty(result.getValue())){
//						result.setId(IdGen.uuid());
//						result.setMedicalReportId(medicalReport.getId());
//						medicalResultDao.insert(result);
//					}
//				}
//			}
			medicalReport.setIsNewRecord(true);
//			String date = DateUtils.formatDate(new Date(), "yyyyMMdd");
//			//客户二维码
//			String textt = Global.getConfig("contentUrl")+"/f/report/form?id="+medicalReport.getId()+"&type="+medicalReport.getType();
//			QrCodeUtil.encode(textt,medicalReport.getId()+"1",Global.getConfig("qrcode")+date,true);
//			medicalReport.setQrcode("/qrcode/"+date+"/"+medicalReport.getId()+"1.jpg");
//			//公司二维码
//			String qr = Global.getConfig("contentUrl")+"/f/report/detail?id="+medicalReport.getId()+"&type="+medicalReport.getType();
//			QrCodeUtil.encode(qr,medicalReport.getId()+"2",Global.getConfig("qrcode")+date,true);
//			medicalReport.setGscode("/qrcode/"+date+"/"+medicalReport.getId()+"2.jpg");
			dao.insert(medicalReport);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	public void saveImport(Map<String, String> map,MedicalReport medicalReport) throws Exception{
		User user = UserUtils.getUser();
		String deliverUnit = map.get("deliverUnit");
		if(deliverUnit.contains("金沙")){
			deliverUnit = "金沙街";
		}else if(deliverUnit.contains("彩虹街")){
			deliverUnit = "彩虹街";
		}else if(deliverUnit.contains("南源")){
			deliverUnit = "南源街";
		}else if(deliverUnit.contains("站前")){
			deliverUnit = "站前街";
		}else if(deliverUnit.contains("洪桥")){
			deliverUnit = "洪桥街";
		}else if(deliverUnit.contains("逢源")){
			deliverUnit = "逢源街";
		}else if(deliverUnit.contains("冲口")){
			deliverUnit = "冲口街";
		}else if(deliverUnit.contains("白鹤洞")){
			deliverUnit = "白鹤洞";
		}else if(deliverUnit.contains("黄村")){
			deliverUnit = "黄村";
		}else if(deliverUnit.contains("同德")){
			deliverUnit = "同德";
		}else if(deliverUnit.contains("石门")){
			deliverUnit = "石门";
		}else if(deliverUnit.contains("桥中")){
			deliverUnit = "桥中";
		}else if(deliverUnit.contains("文船") || deliverUnit.contains("火电") || deliverUnit.contains("红山")){
			deliverUnit = "红山街";
		}else if(deliverUnit.contains("亿仁") || deliverUnit.contains("文冲")){
			deliverUnit = "文冲街";
		}else if(deliverUnit.contains("穗东")){
			deliverUnit = "穗东";
		}else if(deliverUnit.contains("黄埔街")){
			deliverUnit = "黄埔街";
		}else if(deliverUnit.contains("东漖")){
			deliverUnit = "东漖";
		}else if(deliverUnit.contains("中南")){
			deliverUnit = "中南";
		}else if(deliverUnit.contains("海龙")){
			deliverUnit = "海龙";
		}else if(deliverUnit.contains("花地")){
			deliverUnit = "花地";
		}else if(deliverUnit.contains("黄埔红会医院")){
			deliverUnit = "黄埔区红十字会医院";
		}else if(deliverUnit.contains("茅岗") || deliverUnit.contains("金碧") || deliverUnit.contains("鱼珠")){
			deliverUnit = "鱼珠街";
		}else if(deliverUnit.contains("珠吉")){
			deliverUnit = "珠吉";
		}else if(deliverUnit.contains("电力医院")){
			deliverUnit = "电力医院";
		}else if(deliverUnit.contains("荔联") || deliverUnit.contains("沧头")){
			deliverUnit = "荔联";
		}else if(deliverUnit.contains("南岗")){
			deliverUnit = "南岗";
		}
		List<OfficeMedicalType> officeMedicalTypes = officeMedicalTypeService.findByOfficeName(map.get("type"), deliverUnit);
		if(officeMedicalTypes.size() != 1){//当查询不到街道，为主公司
			officeMedicalTypes = officeMedicalTypeService.findByOfficeName(map.get("type"), "博拓");
		}
		List<MedicalElement> list = medicalElementDao.findByType(officeMedicalTypes.get(0).getMedicalType().getId());
		if(StringUtils.isNoneEmpty(map.get("reportNum"))){
			Double reportNum = Double.valueOf(map.get("reportNum"));
			medicalReport.setReportNum(reportNum.intValue());
		}
		medicalReport.setOfficeMedicalType(officeMedicalTypes.get(0));
		medicalReport.setBatch(map.get("batch"));
		medicalReport.setPerson(map.get("person"));
		if(StringUtils.isNotEmpty(map.get("detectionDate")))
			medicalReport.setDetectionDate(DateUtils.parseDate(map.get("detectionDate"), "yyyy-MM-dd"));
		String sex = "";
		if(map.get("sex").equals("男")){
			sex ="1";
		} else if (map.get("sex").equals("女")){
			sex ="0";
		}
		medicalReport.setSex(sex);
		medicalReport.setAge(map.get("age"));
		medicalReport.setPhone(map.get("phone"));
		medicalReport.setUser(user);
		medicalReport.setType(map.get("type"));
		medicalReport.setDeliverUnit(map.get("deliverUnit"));
		List<MedicalResult> results = new ArrayList<MedicalResult>();
		Map<String, double[]> elements = null;
		if("1".equals(map.get("type"))){//头发
			elements = Constants.fa;
		}else{
			elements = Constants.xue;
		}
		Class c = medicalReport.getClass();  
		for (MedicalElement medicalElement : list) {
			if(StringUtils.isNotEmpty(map.get(medicalElement.getEname()))){
				//MedicalResult r = new MedicalResult();
				double v = MathUtil.round(Double.valueOf(map.get(medicalElement.getEname())), (int)elements.get(medicalElement.getEname())[2]);
				if(v!=0){
//					r.setElementId(medicalElement.getId());
//					r.setValue(v+"");
//					results.add(r);
					Field f = c.getDeclaredField(medicalElement.getEname().toLowerCase());
					f.setAccessible(true);
					f.set(medicalReport, v);
				}
				
			}
		}
		////拆分数据
//		medicalReport.setResults(results);
		save(medicalReport);
		
	}
	
	
	public boolean checkElement(List<Map<String, String>> list,String type) throws Exception{
		Map<String, double[]> elements = null;
		if("1".equals(type)){//头发
			elements = Constants.fa;
		}else{
			elements = Constants.xue;
		}
		for (Map<String, String> map : list) {
			if(StringUtils.isNotEmpty(map.get("person"))){
				for (String key : map.keySet()) {
					if(null != elements.get(key) ){
						if(StringUtils.isNotEmpty(map.get(key))){
							double v = MathUtil.round(Double.valueOf(map.get(key)), (int)elements.get(key)[2]);
							if(Double.doubleToLongBits(elements.get(key)[0]) <= Double.doubleToLongBits(v) 
									&& Double.doubleToLongBits(v) <= Double.doubleToLongBits(elements.get(key)[1])){
								continue;
							}else{
								throw new Exception("导入失败：<br/>姓名 "+map.get("person")+"的"+key+"元素不达标！");
							}
						}
					}
				}
			}
		}
		
		return true;
	}
	
	@Transactional(readOnly = false)
	public void update(MedicalReport medicalReport){
		
		try {
			MedicalResult result = new MedicalResult();
			result.setMedicalReportId(medicalReport.getId());
			List<MedicalResult> results = medicalResultDao.findList(result);
			for (MedicalResult r : results) {
				String getter = "get" + r.getEname();    
				Method method = medicalReport.getClass().getMethod(getter, new Class[] {});    
				Object value = method.invoke(medicalReport, new Object[] {});
				if(!r.getValue().equals(value)){
					r.setValue((String)value);
					medicalResultDao.update(r);
				}
			}
			dao.update(medicalReport);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	@Transactional(readOnly = false)
	public void delete(MedicalReport medicalReport) {
		MedicalResult r = new MedicalResult();
		r.setMedicalReportId(medicalReport.getId());
		File f=new File(Global.getConfig("userfiles.realdir")+medicalReport.getQrcode());  
		if (f.isFile()) {	//删除二维码图片
		     f.delete();
		}
		File f1=new File(Global.getConfig("userfiles.realdir")+medicalReport.getGscode());  
		if (f1.isFile()) {	//删除二维码图片
		     f1.delete();
		}
		List<MedicalResult> results = medicalResultDao.findList(r);
		for (MedicalResult result : results) {	//删除结果列表
			medicalResultDao.delete(result);
		}
		super.delete(medicalReport);
	}
	
	public List<MedicalElement> findByReport(String reportId){
		return medicalElementDao.findByReport(reportId);
	}
	
	@Transactional(readOnly = false)
	public List<MedicalReport> findPrint(MedicalReport medicalReport){
		//List<MedicalReport> reports = (List<MedicalReport>)CacheUtils.get(REPORT_CACHE, "REPORT_CACHE_ID_" + medicalReport.getId());
		List<MedicalReport> list =  dao.findReportPage(medicalReport);
		dao.updateBatch(list);
		return list;
	}
	
	public String checkTemp(MedicalReport report){
		int fail = 0;
		Field[] fields = report.getClass().getDeclaredFields();
		try {
			for (Field field : fields) {
				
				if (Double.class == field.getType()) {
					field.setAccessible(true);
					if(null != field.get(report) && 0<(Double)field.get(report)){
						fail ++;
					}
					
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(fail >8){
			fail = 20;
		}//else{
//			fail = 8;
//		}
		return fail+"";
	}
}