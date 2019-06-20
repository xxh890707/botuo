/**
 * 
 */
package com.botuo.modules.bmd.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.botuo.common.utils.StringUtils;
import com.botuo.common.web.BaseController;
import com.botuo.modules.bmd.entity.MedicalReport;
import com.botuo.modules.bmd.service.MedicalReportService;

/**
 * @since 2018年1月21日 下午2:53:19
 * @author xiaohu
 * @version v1.0
 */
@Controller
@RequestMapping(value = "${frontPath}/report")
public class ReportController extends BaseController{

	@Autowired
	private MedicalReportService medicalReportService;
	
	
	@RequestMapping(value = "form")
	public String form(MedicalReport medicalReport, Model model) {
		List<MedicalReport> list = medicalReportService.findPrint(medicalReport);
		model.addAttribute("medicalReport", list.get(0));
		String template = "";
		if(StringUtils.isBlank(template)){
			template = medicalReportService.checkTemp(list.get(0));
		}
		if("1".equals(medicalReport.getType())){
			template= "fa_6";
		}else{
			template= "xue_"+template;
		}
		return "modules/bmd/kehu/view/"+template;
	}
	
	@RequestMapping(value = "detail")
	public String detail(HttpServletRequest request,MedicalReport medicalReport, Model model) {
//		List<MedicalElement> elements = medicalReportService.findByReport(medicalReport.getId());
		
		List<MedicalReport> list = medicalReportService.findPrint(medicalReport);
		model.addAttribute("medicalReport", list.get(0));
		String template = request.getParameter("num");
		if(StringUtils.isBlank(template)){
			template = medicalReportService.checkTemp(list.get(0));
		}
		if("1".equals(medicalReport.getType())){
			
				template = "fa_"+template;
		}else{
			template = "xue_"+template;
		}
		return "modules/bmd/temp/"+template;
	}
}
