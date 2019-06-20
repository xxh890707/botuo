/**
 * 
 */
package com.botuo.modules.bmd.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.botuo.common.config.Global;
import com.botuo.common.persistence.Page;
import com.botuo.common.utils.DateUtils;
import com.botuo.common.utils.StringUtils;
import com.botuo.common.utils.excel.ExportExcel;
import com.botuo.common.utils.excel.ImportExcelUtil;
import com.botuo.common.web.BaseController;
import com.botuo.entity.Office;
import com.botuo.modules.bmd.constants.Constants;
import com.botuo.modules.bmd.dto.ReportDTO;
import com.botuo.modules.bmd.entity.MedicalElement;
import com.botuo.modules.bmd.entity.MedicalReport;
import com.botuo.modules.bmd.entity.OfficeMedicalType;
import com.botuo.modules.bmd.service.MedicalElementService;
import com.botuo.modules.bmd.service.MedicalReportService;
import com.botuo.modules.bmd.service.OfficeMedicalTypeService;
import com.botuo.modules.sys.service.OfficeService;

/**
 * 检查报告表Controller
 * @author xiaohu
 * @version 2018-01-18
 */
@Controller
@RequestMapping(value = "${adminPath}/bmd/medicalReport")
public class MedicalReportController extends BaseController {

	@Autowired
	private MedicalReportService medicalReportService;
	@Autowired
	private MedicalElementService medicalElementService;
	@Autowired
	private OfficeMedicalTypeService officeMedicalTypeService;
	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute
	public MedicalReport get(@RequestParam(required=false) String id) {
		MedicalReport entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = medicalReportService.get(id);
		}
		if (entity == null){
			entity = new MedicalReport();
		}
		return entity;
	}
	
	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = {"index"})
	public String index(Model model) {
		return "modules/bmd/medicalReportIndex";
	}
	
	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = {"list", ""})
	public String list(MedicalReport medicalReport, HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes, String exportFlag) {
		int size = 100;
		if("export".equals(exportFlag)){
			size = 10000;
		}
		Page<MedicalReport> page = medicalReportService.searchPage(new Page<MedicalReport>(request, response,size),medicalReport);
		model.addAttribute("page", page);
		if("export".equals(exportFlag)){
			try {
				String fileName = "用户数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
				new ExportExcel("用户数据", ReportDTO.class).setDataList(page.getList()).write(response, fileName).dispose();
				return null;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "modules/bmd/medicalReportList";
	}
	
	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = {"reportList"})
	public String reportList(MedicalReport medicalReport, HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes, String exportFlag) {
		Page<MedicalReport> page = medicalReportService.searchPage(new Page<MedicalReport>(request, response,100),medicalReport);
		model.addAttribute("page", page);
		return "modules/bmd/reportList";
	}

	
	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = {"manager"})
	public String manager(MedicalReport medicalReport, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MedicalReport> page = medicalReportService.findPage(new Page<MedicalReport>(request, response), medicalReport); 
		model.addAttribute("page", page);
		return "modules/bmd/medicalReportManager";
	}
	
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = {"changeOffice"})
	public String changeOffice(HttpServletRequest request, Model model){
		model.addAttribute("type", request.getParameter("type"));
		return "modules/bmd/changeOffice";
	}
	
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = {"update"})
	public String update(MedicalReport medicalReport, Model model){
		List<MedicalElement> elements = medicalReportService.findByReport(medicalReport.getId());
		List<MedicalReport> list = medicalReportService.findPrint(medicalReport);
		model.addAttribute("elements", elements);
		model.addAttribute("report", list.get(0));
		return "modules/bmd/medicalReportForm";
	}
	
	
	/**
	 * 变更单位
	 * @param medicalReport
	 * @param request
	 * @param model
	 * @return
	 * @since 2018年3月18日 上午11:38:37
	 * @author xiaohu
	 * @version v1.0
	 */
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = {"change"})
	public String change(MedicalReport medicalReport,RedirectAttributes redirectAttributes, HttpServletRequest request, Model model){
		String printId = request.getParameter("printId");
		String[] ids = printId.split(",");
		try {
			Office office = officeService.get(medicalReport.getOffice().getId());
			List<OfficeMedicalType> types = officeMedicalTypeService.findByOfficeName(medicalReport.getType(), office.getName());
			for (String id : ids) {
				if(StringUtils.isNoneEmpty(id)){
					MedicalReport report = medicalReportService.get(id);

					report.setOfficeMedicalType(types.get(0));
					medicalReportService.update(report);
				}
			}
		} catch (Exception e) {
			addMessage(redirectAttributes, "变更失败，该街道没有对应模板！");
		}
		addMessage(redirectAttributes, "变更街道成功");
		return "redirect:" + adminPath + "/bmd/medicalReport/officeReport/?repage&type="+medicalReport.getType()+"&office.id="+medicalReport.getOffice().getId();
	}
	
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = {"officeReport"})
	public String officeReport(MedicalReport medicalReport, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<MedicalReport> page = medicalReportService.searchPage(new Page<MedicalReport>(request, response,100),medicalReport);
		model.addAttribute("page", page);
		return "modules/bmd/officeReportList";
	}
	

	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = "form")
	public String form(MedicalReport medicalReport, Model model) {
		List<MedicalElement> elements = medicalReportService.findByReport(medicalReport.getId());
		String template = "";
		List<MedicalReport> list = medicalReportService.findPrint(medicalReport);
		model.addAttribute("medicalReport", list.get(0));
		if("1".equals(medicalReport.getType())){
			if(elements.size() > 8){
				template+= "fa_20";
			}else
				template+= "fa_8";
		}else{
			template+= "xue_6";
		}
		return "modules/bmd/temp/"+template;
	}
	
	@RequiresPermissions("bmd:medicalReport:view")
	@RequestMapping(value = "add")
	public String add(MedicalReport medicalReport, Model model) {
		model.addAttribute("medicalReport", medicalReport);
		OfficeMedicalType officeMedicalType = officeMedicalTypeService.get(medicalReport.getOfficeMedicalType().getId());
		MedicalElement medicalElement = new MedicalElement();
		medicalElement.setMedicalType(officeMedicalType.getMedicalType());
		List<MedicalElement> elements = medicalElementService.findList(medicalElement);
		model.addAttribute("elements", elements);
		return "modules/bmd/addReport";
	}

	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = "save")
	public String save(MedicalReport medicalReport, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, medicalReport)){
			return form(medicalReport, model);
		}
		medicalReportService.update(medicalReport);
		addMessage(redirectAttributes, "保存检查报告表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalReport?repage&type="+medicalReport.getType();
	}
	
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = "print")
	public String print(MedicalReport medicalReport, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request){
		String printId = request.getParameter("printId");
		
		if(StringUtils.isEmpty(printId)){
			addMessage(redirectAttributes, "请先选择要打印的数据");
			return "redirect:" + adminPath + "/bmd/medicalReport?repage&type="+medicalReport.getType();
		}
		String[] ids = printId.split(",");
		medicalReport.setIds(ids);
		List<MedicalReport> list = medicalReportService.findPrint(medicalReport);
		model.addAttribute("reports", list);
		String company = request.getParameter("company"); // 判断是否客户打印
		if("0".equals(company)){
			String template = medicalReportService.checkTemp(list.get(0));
			if("1".equals(medicalReport.getType())){
				template = "fa_6";
			}else{
				template = "xue_"+template;
			}
			return "modules/bmd/kehu/print/"+template;
		}
		return "modules/bmd/print/"+medicalReport.getTemplate();
	}
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = "import")
	public String importXls(MultipartFile file,MedicalReport medicalReport, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			String type= request.getParameter("type");
			List<Map<String, String>> list = ImportExcelUtil.readExcelIgnoreFistAndLastRow(Constants.heads, file.getInputStream());
			if(medicalReportService.checkElement(list, type)){//检查是否有元素不达标
				for (Map<String, String> map : list) {
					if(StringUtils.isEmpty(map.get("batch"))){
						continue;
					}
					try{
						map.put("type", type);
						MedicalReport report = new MedicalReport();
						medicalReportService.saveImport(map,report);
						successNum++;
					}catch (Exception ex) {
						ex.printStackTrace();
						failureNum++;
						failureMsg.append("导入失败："+ex.getMessage());
					}
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条检测报告"+failureMsg);
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入检测报告失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/bmd/medicalReport/list?repage&type="+medicalReport.getType();
	}
	
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = "delete")
	public String delete(MedicalReport medicalReport, RedirectAttributes redirectAttributes) {
		medicalReportService.delete(medicalReport);
		addMessage(redirectAttributes, "删除检查报告表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalReport/list?repage";
	}
	
	@RequiresPermissions("bmd:medicalReport:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(MedicalReport medicalReport, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		String string= request.getParameter("ids");
		String type = request.getParameter("type");
		if(StringUtils.isNoneEmpty(string)){
			String[] ids = string.split(",");
			for (String id : ids) {
				medicalReportService.delete(new MedicalReport(id));
			}
		}
		
		addMessage(redirectAttributes, "删除检查报告表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalReport/list?type="+type;
	}

}