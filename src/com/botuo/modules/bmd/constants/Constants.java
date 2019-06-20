/**
 * 
 */
package com.botuo.modules.bmd.constants;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @since 2016年3月16日 下午2:34:06
 * @author chengj<chengj@everygold.com>
 * @version v1.0
 */
public class Constants {

	public static final int PAGESIZE = 30;
	
	public final static Map<String, String> heads = new HashMap<String, String>();
	public final static List<String> titles = new ArrayList<String>();
	
	 static  {
		 heads.put("批次", "batch");
		 heads.put("检测号","reportNum");
		 heads.put("编号","reportNum");
		 heads.put("姓名","person");
		 heads.put("性别","sex");
		 heads.put("年龄","age");
		 heads.put("电话", "phone");
		 heads.put("送样单位", "deliverUnit");
		 heads.put("出单日期", "detectionDate");
		 heads.put("日期", "detectionDate");
		 heads.put("锌", "Zn");
		 heads.put("铁", "Fe");
		 heads.put("铜", "Cu");
		 heads.put("钙", "Ca");
		 heads.put("镁", "Mg");
		 heads.put("铅", "Pb");
		 heads.put("锰", "Mn");
		 heads.put("锶", "Sr");
		 heads.put("镉", "Cd");
		 heads.put("铝", "Al");
		 heads.put("铬", "Cr");
		 heads.put("镍", "Ni");
		 heads.put("钼", "Mo");
		 heads.put("钴", "Co");
		 heads.put("钡", "Ba");
		 heads.put("钒", "V");
		 heads.put("钛", "Ti");
		 heads.put("硼", "B");
		 heads.put("锡", "Sn");
		 heads.put("钾", "K");
		 heads.put("磷", "P");
	 }
	 
	 static {
		 titles.add("批次");
		 titles.add("检测号");
		 titles.add("姓名");
		 titles.add("性别");
		 titles.add("年龄");
		 titles.add("电话");
		 titles.add("送样单位");
		 titles.add("出单日期"); 
		 titles.add("锌");
		 titles.add("铁");
		 titles.add("铜");
		 titles.add("钙");
		 titles.add("镁");
		 titles.add("铅");
		 titles.add("锰"); 
		 titles.add("锶");
		 titles.add("镉");
		 titles.add("铝"); 
		 titles.add("铬");
		 titles.add("镍");
		 titles.add("钼");
		 titles.add("钴");
		 titles.add("钡");
		 titles.add("钒");
		 titles.add("钛");
		 titles.add("硼");
		 titles.add("锡");
		 titles.add("钾"); 
		 titles.add("磷");
		 
	 }
	
	
	
	public final static Map<String, double[]> xue = new HashMap<String, double[]>();

	static {
		double[] xue_zn = {3.7,8.6,2};
		double[] xue_fe = {239,510,0};
		double[] xue_cu = {0.69,1.6,2};
		double[] xue_ca = {49,110,1};
		double[] xue_mg = {27.9,59.3,1};
		double[] xue_pb = {0.029,0.111,3};
		double[] xue_mn = {0.005,0.062,3};
		double[] xue_k = {1075,1758,1};
		xue.put("Zn", xue_zn);
		xue.put("Fe", xue_fe);
		xue.put("Cu", xue_cu);
		xue.put("Ca", xue_ca);
		xue.put("Mg", xue_mg);
		xue.put("Pb", xue_pb);
		xue.put("Mn",xue_mn);
		xue.put("K", xue_k);
	}

	
	public final static Map<String, double[]> fa = new HashMap<String, double[]>();

	static {
		double[] fa_zn = {80,150.1,1};
		double[] fa_fe = {15,60,1};
		double[] fa_cu = {7.9,18.1,1};
		double[] fa_ca = {530,1200,0};
		double[] fa_mg = {40,110.1,1};
		double[] fa_pb = {3.8,11,1};
		double[] fa_mn = {2.4,7.1,1};
		double[] fa_k = {98,280.1,1};
		double[] fa_sr = {0.99,3.01,2};
		double[] fa_cd = {0.09,0.51,2};
		double[] fa_al = {34.9,65.1,1};
		double[] fa_cr = {0.69,1.81,2};
		double[] fa_ni = {0.17,1.61,2};
		double[] fa_mo = {0.24,1.81,2};
		double[] fa_co = {0.02,0.71,2};
		double[] fa_ba = {0.59,3.01,2};
		double[] fa_v = {0.03,0.51,2};
		double[] fa_ti = {2.95,10.01,2};
		double[] fa_b = {0.39,3.01,2};
		double[] fa_sn = {0.49,1.61,2};
		double[] fa_p = {89,270,1};
		fa.put("Zn", fa_zn);
		fa.put("Fe", fa_fe);
		fa.put("Cu", fa_cu);
		fa.put("Ca", fa_ca);
		fa.put("Mg", fa_mg);
		fa.put("Pb", fa_pb);
		fa.put("Mn", fa_mn);
		fa.put("K", fa_k);
		fa.put("Sr", fa_sr);
		fa.put("Cd", fa_cd);
		fa.put("Al", fa_al);
		fa.put("Cr", fa_cr);
		fa.put("Ni", fa_ni);
		fa.put("Mo", fa_mo);
		fa.put("Co", fa_co);
		fa.put("Ba", fa_ba);
		fa.put("V", fa_v);
		fa.put("Ti", fa_ti);
		fa.put("B", fa_b);
		fa.put("Sn", fa_sn);
		fa.put("P",fa_p);
	}

}
