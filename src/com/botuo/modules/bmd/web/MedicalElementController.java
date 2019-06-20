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
import com.botuo.common.utils.StringUtils;
import com.botuo.common.web.BaseController;
import com.botuo.modules.bmd.entity.MedicalElement;
import com.botuo.modules.bmd.service.MedicalElementService;

/**
 * 医学元素表Controller
 * @author xiaohu
 * @version 2018-01-15
 */
@Controller
@RequestMapping(value = "${adminPath}/bmd/medicalElement")
public class MedicalElementController extends BaseController {

	@Autowired
	private MedicalElementService medicalElementService;
	
	@ModelAttribute
	public MedicalElement get(@RequestParam(required=false) String id) {
		MedicalElement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = medicalElementService.get(id);
		}
		if (entity == null){
			entity = new MedicalElement();
		}
		return entity;
	}
	
	@RequiresPermissions("bmd:medicalElement:view")
	@RequestMapping(value = {"index"})
	public String index(Model model) {
		return "modules/bmd/medicalElementIndex";
	}
	
	@RequiresPermissions("bmd:medicalElement:view")
	@RequestMapping(value = {"list", ""})
	public String list(MedicalElement medicalElement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MedicalElement> page = medicalElementService.findPage(new Page<MedicalElement>(request, response), medicalElement); 
		model.addAttribute("page", page);
		model.addAttribute("medicalType", medicalElement.getMedicalType());
		return "modules/bmd/medicalElementList";
	}

	@RequiresPermissions("bmd:medicalElement:view")
	@RequestMapping(value = "form")
	public String form(MedicalElement medicalElement, Model model) {
		model.addAttribute("medicalElement", medicalElement);
		return "modules/bmd/medicalElementForm";
	}

	@RequiresPermissions("bmd:medicalElement:edit")
	@RequestMapping(value = "save")
	public String save(MedicalElement medicalElement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, medicalElement)){
			return form(medicalElement, model);
		}
		medicalElementService.save(medicalElement);
		addMessage(redirectAttributes, "保存医学元素表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalElement/?repage&medicalType.id="+medicalElement.getMedicalType().getId();
	}
	
	@RequiresPermissions("bmd:medicalElement:edit")
	@RequestMapping(value = "delete")
	public String delete(MedicalElement medicalElement, RedirectAttributes redirectAttributes) {
		medicalElementService.delete(medicalElement);
		addMessage(redirectAttributes, "删除医学元素表成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalElement/?repage";
	}

}