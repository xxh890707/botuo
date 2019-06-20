/**
 * 
 */
package com.botuo.modules.bmd.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.botuo.common.config.Global;
import com.botuo.common.persistence.Page;
import com.botuo.common.utils.StringUtils;
import com.botuo.common.web.BaseController;
import com.botuo.modules.bmd.entity.MedicalType;
import com.botuo.modules.bmd.service.MedicalTypeService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 医学类型Controller
 * @author xiaohu
 * @version 2018-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/bmd/medicalType")
public class MedicalTypeController extends BaseController {

	@Autowired
	private MedicalTypeService medicalTypeService;
	
	@ModelAttribute
	public MedicalType get(@RequestParam(required=false) String id) {
		MedicalType entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = medicalTypeService.get(id);
		}
		if (entity == null){
			entity = new MedicalType();
		}
		return entity;
	}
	
	@RequiresPermissions("bmd:medicalType:view")
	@RequestMapping(value = {"list", ""})
	public String list(MedicalType medicalType, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MedicalType> page = medicalTypeService.findPage(new Page<MedicalType>(request, response), medicalType); 
		model.addAttribute("page", page);
		return "modules/bmd/medicalTypeList";
	}

	@RequiresPermissions("bmd:medicalType:view")
	@RequestMapping(value = "form")
	public String form(MedicalType medicalType, Model model) {
		model.addAttribute("medicalType", medicalType);
		return "modules/bmd/medicalTypeForm";
	}

	@RequiresPermissions("bmd:medicalType:edit")
	@RequestMapping(value = "save")
	public String save(MedicalType medicalType, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, medicalType)){
			return form(medicalType, model);
		}
		medicalTypeService.save(medicalType);
		addMessage(redirectAttributes, "保存检测报告类型成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalType/?repage";
	}
	
	@RequiresPermissions("bmd:medicalType:edit")
	@RequestMapping(value = "delete")
	public String delete(MedicalType medicalType, RedirectAttributes redirectAttributes) {
		medicalTypeService.delete(medicalType);
		addMessage(redirectAttributes, "删除检测报告类型成功");
		return "redirect:"+Global.getAdminPath()+"/bmd/medicalType/?repage";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false)HttpServletResponse response,MedicalType medicalType){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<MedicalType> list = medicalTypeService.findList(medicalType);
		for (int i=0; i<list.size(); i++){
			MedicalType e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParent().getId());
//				map.put("pIds", e.getParentIds());
			map.put("name", e.getName());
//				if (type != null && "3".equals(type)){
//					map.put("isParent", true);
//				}
			mapList.add(map);
			
		}
		return mapList;
	}

}