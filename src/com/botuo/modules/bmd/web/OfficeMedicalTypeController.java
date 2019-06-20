/**
 * 
 */
package com.botuo.modules.bmd.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.botuo.common.config.Global;
import com.botuo.common.persistence.Page;
import com.botuo.common.web.BaseController;
import com.botuo.common.utils.StringUtils;
import com.botuo.modules.bmd.entity.OfficeMedicalType;
import com.botuo.modules.bmd.service.OfficeMedicalTypeService;

/**
 * 公司报告类型表Controller
 * @author xiaohu
 * @version 2018-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/bmd/officeMedicalType")
public class OfficeMedicalTypeController extends BaseController {

	@Autowired
	private OfficeMedicalTypeService officeMedicalTypeService;
	
	@ModelAttribute
	public OfficeMedicalType get(@RequestParam(required=false) String id) {
		OfficeMedicalType entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = officeMedicalTypeService.get(id);
		}
		if (entity == null){
			entity = new OfficeMedicalType();
		}
		return entity;
	}
	
	@RequiresPermissions("bmd:officeMedicalType:view")
	@RequestMapping(value = {"index"})
	public String index(Model model) {
		return "modules/bmd/medicalOfficeIndex";
	}
	
	@RequiresPermissions("bmd:officeMedicalType:view")
	@RequestMapping(value = {"list", ""})
	public String list(OfficeMedicalType officeMedicalType, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OfficeMedicalType> page = officeMedicalTypeService.findPage(new Page<OfficeMedicalType>(request, response), officeMedicalType); 
		model.addAttribute("page", page);
		model.addAttribute("office", officeMedicalType.getOffice());
		return "modules/bmd/officeMedicalTypeList";
	}

	@RequiresPermissions("bmd:officeMedicalType:view")
	@RequestMapping(value = "form")
	public String form(OfficeMedicalType officeMedicalType, Model model) {
		model.addAttribute("officeMedicalType", officeMedicalType);
		return "modules/bmd/officeMedicalTypeForm";
	}

	@RequiresPermissions("bmd:officeMedicalType:edit")
	@RequestMapping(value = "save")
	public String save(OfficeMedicalType officeMedicalType, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, officeMedicalType)){
			return form(officeMedicalType, model);
		}
		officeMedicalTypeService.save(officeMedicalType);
		addMessage(redirectAttributes, "保存公司报告类型表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/officeMedicalType/?repage";
	}
	
	@RequiresPermissions("bmd:officeMedicalType:edit")
	@RequestMapping(value = "delete")
	public String delete(OfficeMedicalType officeMedicalType, RedirectAttributes redirectAttributes) {
		officeMedicalTypeService.delete(officeMedicalType);
		addMessage(redirectAttributes, "删除公司报告类型表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/officeMedicalType/?repage";
	}

}