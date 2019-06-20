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
import com.botuo.modules.bmd.entity.MedicalResult;
import com.botuo.modules.bmd.service.MedicalResultService;

/**
 * 报告结果Controller
 * @author xiaohu
 * @version 2018-01-15
 */
@Controller
@RequestMapping(value = "${adminPath}/bmd/bmdMedicalResult")
public class MedicalResultController extends BaseController {

	@Autowired
	private MedicalResultService bmdMedicalResultService;
	
	@ModelAttribute
	public MedicalResult get(@RequestParam(required=false) String id) {
		MedicalResult entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bmdMedicalResultService.get(id);
		}
		if (entity == null){
			entity = new MedicalResult();
		}
		return entity;
	}
	
	@RequiresPermissions("bmd:bmdMedicalResult:view")
	@RequestMapping(value = {"list", ""})
	public String list(MedicalResult bmdMedicalResult, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MedicalResult> page = bmdMedicalResultService.findPage(new Page<MedicalResult>(request, response), bmdMedicalResult); 
		model.addAttribute("page", page);
		return "modules/bmd/bmdMedicalResultList";
	}

	@RequiresPermissions("bmd:bmdMedicalResult:view")
	@RequestMapping(value = "form")
	public String form(MedicalResult bmdMedicalResult, Model model) {
		model.addAttribute("bmdMedicalResult", bmdMedicalResult);
		return "modules/bmd/bmdMedicalResultForm";
	}

	@RequiresPermissions("bmd:bmdMedicalResult:edit")
	@RequestMapping(value = "save")
	public String save(MedicalResult bmdMedicalResult, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bmdMedicalResult)){
			return form(bmdMedicalResult, model);
		}
		bmdMedicalResultService.save(bmdMedicalResult);
		addMessage(redirectAttributes, "保存报告结果成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/bmdMedicalResult/?repage";
	}
	
	@RequiresPermissions("bmd:bmdMedicalResult:edit")
	@RequestMapping(value = "delete")
	public String delete(MedicalResult bmdMedicalResult, RedirectAttributes redirectAttributes) {
		bmdMedicalResultService.delete(bmdMedicalResult);
		addMessage(redirectAttributes, "删除报告结果成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/bmdMedicalResult/?repage";
	}

}