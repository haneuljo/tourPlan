package com.tour.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.PlanDAO;
import com.tour.dao.PlanInfoDAO;
import com.tour.dto.PlanDTO;
import com.tour.dto.PlanInfoDTO;
import com.tour.util.GroupSession;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;

@Controller("PlanInfoController")
public class PlanInfoController {

	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";

	@Autowired
	@Qualifier("PlanInfoDAO")
	PlanInfoDAO dao;

	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO pdao;

	@Autowired
	JSONResponseUtil jsonUtil;

	@RequestMapping("/choice")
	public String choice(int durTime,int endTime,Long contentid,HttpServletRequest req,HttpServletResponse res) throws ParseException, IOException {

		int time=endTime+durTime; //관광지 출발시간
		int tran, min=0;
		int hour=0;

		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");


		if (time > 3600) {
			hour = time/3600;
			tran = time%3600;
			min = tran/60;
			//d = b % 60; //��

			System.out.println(hour + "시" + min + "분");

		} else if (time<3600 && time>60) {

			min = time/60;
			//d = time % 60;//��

			System.out.println(min + "분" );

		} 

		String stratDate = gp.getStartDate() + " " + hour + ":" + min + ":00"; 
		System.out.println("날짜:" + gp.getStartDate()); 
		System.out.println("소요:" + durTime);
		System.out.println("도착:" + endTime);
		System.out.println("컨아이디:" + contentid);
		System.out.println("출발날짜시간:" + stratDate);
		//System.out.println(contentid);
	
		/*인서트 해야하는 변수들
		 planNum : dao.planInfoMax()+1
		 groupNum : gp.getGroupNum()
		 content : 관광지정보
		 startDate : gp.getStartDate()
		 longTime : 0 관광광지에서 머무르는 시간으로 바뀔때마다 update해야함
		 contentid : contentid
		 contenttypeid : 관광지타입
		 
		hMap.put("order", 4);  //이부분은 멀 넣어야할지????
		hMap.put("planNum", dao.planInfoMax()+1);
		hMap.put("groupNum", gp.getGroupNum());
		hMap.put("contentid", contentid);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",0); //default로 0으로
		hMap.put("content", "111");
		hMap.put("startDate", gp.getStartDate());
		 */

		PlanInfoDTO adto = new PlanInfoDTO();
		HashMap<String, Object> hMap = new HashMap<String, Object>();

		adto = getPlanInfoDTOfromContentID(req, res, contentid,stratDate);

		hMap.put("firstimage",adto.getFirstimage());
		hMap.put("addr1",adto.getAddr1());
		hMap.put("addr2",adto.getAddr2());
		hMap.put("title",adto.getTitle());
		hMap.put("mapx",adto.getMapx());
		hMap.put("mapy",adto.getMapy());
		//hMap.put("planNum", dao.planInfoMax()+1);
		hMap.put("groupNum", gp.getGroupNum());
		hMap.put("contentid", contentid);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",0); //default�� 0����
		hMap.put("content", "111");
		hMap.put("startDate", gp.getStartDate());

		insertInfoLists(hMap, req );

		// HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		lists = info.getInfoList();

		req.setAttribute("lists", lists);


		return "redirect:/myPlanTest";

		//return "plan/newplan";
	}
	
	
	@RequestMapping("/dayCal")                                 
	public void dayCal(HttpServletRequest req, HttpServletResponse resp,String day1) throws IOException{

		Calendar cal = Calendar.getInstance();
			

		String[] day= day1.split("-");
		int nowYear =  Integer.parseInt(day[0]);
		int nowMonth = Integer.parseInt(day[1]);
		int nowDay = Integer.parseInt(day[2])+1;
		
		cal.set(nowYear, nowMonth-1, nowDay);
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);//말일
		
		if(nowDay==endDay){
			
			nowMonth ++;
			nowDay=1;
		}
		
		String nextDay=nowYear + "-"+nowMonth + "-"+ nowDay;
		PrintWriter out = resp.getWriter();
		out.print(nextDay);
	}

	@RequestMapping("/startPut")
	public void startPut(PlanInfoDTO pdto,int durTime,int hour,int min,String address1,String address2,HttpServletRequest req,HttpServletResponse res, Integer contentid) throws IOException {

		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");

		int endTime = 60*60*hour+60*min+durTime; //����ð�
		String startDate = pdto.getStartDate() + " " + hour + ":" + min + ":00";

		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address1);
		pdto.setStartDate(startDate);
		pdto.setLongTime(0);

		//dao.planInfoInsert(pdto);//����� �μ�Ʈ


		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address2);
		pdto.setStartDate(startDate);
		pdto.setLongTime(durTime);

		//dao.planInfoInsert(pdto);//������ �μ�Ʈ

		System.out.println(pdto.getStartDate());
		System.out.println(hour);
		System.out.println(min);
		System.out.println(address1);
		System.out.println(address2);
		System.out.println(endTime);
		//System.out.println(durTime);
		//System.out.println(durTime);
		//req.setAttribute("durTime", durTime);
		
		//req.setAttribute("startDate", gp.getStartDate());
		//req.setAttribute("endTime", endTime);
		//req.setAttribute("address2", address2);//���� ������ �Ÿ��� �ð� ���ϱ�����

		PrintWriter out = res.getWriter();
		out.print(endTime);
	}

	//�����Ϸ�
	@RequestMapping("/register")
	public String register(HttpServletRequest req,HttpServletResponse res) {

		System.out.println("re��ister ����");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������
		
		if(info.getInfoList()==null){
			System.out.println("infolists is null");
		}
		
		ArrayList<HashMap<String, Object>> lists = new  ArrayList<HashMap<String,Object>>();               
		lists = info.getInfoList();
		System.out.println("not null");

		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		while(it.hasNext()){
			
			HashMap<String, Object> hMap = (HashMap<String, Object>)it.next();
			hMap.put("planNum", dao.planInfoMax()+1);
			//hMap.put("groupNum", dao.planInfoGroupMax()+1); //�ϳ��� ������ groupNum�ϳ��� insert�ؾ� �Ǽ� +1 ���ص� �ɵ�?
			dao.planInfoInsertForhMap(hMap);
			
		}	
		
		listchk(lists);
		
		session.removeAttribute("groupDate"); //���ο� ������ ���� session���� Ŭ����

		return "planInfo";
	}
	
	//���
	@RequestMapping("/planAdd")
	public String planAdd(PlanDTO pdto,HttpServletRequest req,HttpServletResponse res) {

		return "plan/planAdd";
	}

	//���
	@RequestMapping("/startPlace")
	public String startPlace(String startDate,HttpServletRequest req,HttpServletResponse res) {

		req.setAttribute("startDate", startDate);

		return "plan/startPlace";
	}


	//�������߰�
	@RequestMapping("/planOk")
	public String planOk(PlanDTO pdto,String startDate,HttpServletRequest req,HttpServletResponse res) {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");


		System.out.println(pdto.getTitle());
		System.out.println(startDate);
		GroupSession gp = new GroupSession();


		pdto.setGroupNum(gp.getGroupNum()+1);
		pdto.setEmail(info.getEmail());

		gp.setGroupNum(pdto.getGroupNum());
		gp.setStartDate(startDate);
		//pdao.planInsert(pdto);
		session.setAttribute("groupDate", gp);
		req.setAttribute("startDate", startDate);

		return "newPlan";
	}

	@RequestMapping("/myPlan")                                    //����������
	public String myPlan(HttpServletRequest req) {

		/*int groupNum = 1;

		List<PlanInfoDTO> lists = dao.getLists(groupNum);

		req.setAttribute("lists", lists);*/

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists = info.getInfoList();
		ArrayList<HashMap<String, Object>> lists2 = new ArrayList<HashMap<String,Object>>();
		Object mapxex = null;
		Object mapyex = null;
		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		while(it.hasNext()){
			
			HashMap<String, Object> hMap = (HashMap<String, Object>)it.next();
			if(mapxex!=null){
			hMap.put("mapxex", mapxex);
			hMap.put("mapyex", mapyex);
			}
			mapxex=hMap.get("mapx");
			mapyex=hMap.get("mapy");
			
			lists2.add(hMap);
			
		}	

		req.setAttribute("lists", lists2);

		listchk(lists2);

		return "myPlan";
	}

	@RequestMapping("/myPlanTest")          
	public String myPlanTest(HttpServletRequest req, HttpServletResponse res) throws ParseException, IOException {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  

		ArrayList<HashMap<String, Object>> lists = info.getInfoList();
		ArrayList<HashMap<String, Object>> lists2 = new ArrayList<HashMap<String,Object>>();
		Object mapxex = null;
		Object mapyex = null;
		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		while(it.hasNext()){
			
			HashMap<String, Object> hMap = (HashMap<String, Object>)it.next();
			if(mapxex!=null){
			hMap.put("mapxex", mapxex);
			hMap.put("mapyex", mapyex);
			}
			mapxex=hMap.get("mapx");
			mapyex=hMap.get("mapy");
			
			lists2.add(hMap);
			
		}	

		req.setAttribute("lists", lists2);

		listchk(lists2);

		return "plan/myPlanTest";
	}


	//------------------�ӽ�����Ұ��---------------------


	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {                   //�������̺� �ϳ� �޾Ƽ� ����Ʈ�� �߰� (�α��ο���ó�� �ʿ�) 

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //����Ʈ �߰���������� ��ü �����ϳ� ����.
			System.out.println("infolist is null");
		}else{
			lists = info.getInfoList();
			System.out.println("not null");
		}

		lists.add(hMap);                                             //����Ʈ�� �����߰�

		info.setInfoList(lists);

		session.setAttribute("loginInfo", info);                      //���ǿ� ����Ʈ ��ƿø�

		/*		PlanInfoListCompartor planComp = new PlanInfoListCompartor("order");               //����...  ��� PN���� �ص� �ɵ�? �˻����� �׽�Ʈ �Ϸ�.
		Collections.sort(lists,planComp);*/

		listchk(lists);                                               //����Ʈ��Ȯ��

		System.out.println("index:"+lists.indexOf(hMap));
		System.out.println("������:"+hMap);
		System.out.println("-----------------���м�");

	}





	public void listchk(List<HashMap<String, Object>> lists){                                                        //����Ʈ����üũ
		if(lists!=null){
			Iterator<HashMap<String, Object>> it = lists.iterator();
			HashMap<String, Object> dto = new HashMap<String, Object>();
			System.out.println("����Ʈ����--------------------");
			while(it.hasNext()){                                      //����üũ
				dto = (HashMap<String, Object>)it.next();
				System.out.println(dto);
			}
			System.out.println("����Ʈ��--------------------");
		}else {
			System.out.println("lists is null");
		}
	}



	public class PlanInfoListCompartor implements Comparator<HashMap<String, Object>> {                        //list�˻��������� �ʿ�Ŭ����(��������) �켱�ε�����.

		private final String key;

		public PlanInfoListCompartor(String key) {
			this.key = key;
		}


		@Override
		public int compare(HashMap<String, Object> first, HashMap<String, Object> second) {
			int result = ((Integer) first.get(key)).compareTo((Integer) second.get(key));
			return result;
		}
	}

	public void updatetInfoLists (HttpServletRequest req, String[] index) {               //�ӽ����帮��Ʈ ���� �޼ҵ� �ε����� ��ٲ޿�
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //����Ʈ �߰���������� ��ü �����ϳ� ����.
			System.out.println("infolist is null");
		}else{
			lists = info.getInfoList();
		}

		ArrayList<HashMap<String, Object>> lists2 = new ArrayList<HashMap<String,Object>>();


		System.out.println("not null");

		for(int i = 0;i<index.length;i++) {

			int index2 = Integer.parseInt(index[i]);
			System.out.println(index[i]+"->"+i);
			HashMap<String, Object> hMap = lists.get(index2);
			System.out.println(hMap);

			System.out.println(hMap);
			lists2.add(hMap);	
		}
		info.setInfoList(lists2);

		listchk(lists);        

		session.setAttribute("loginInfo", info);                      //���ǿ� ����Ʈ ��ƿø�



	}

	/*	public void updatetInfoLists (HttpServletRequest req, Integer index) {               //�ӽ����帮��Ʈ ���� �޼ҵ� ������
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //����Ʈ �߰���������� ��ü �����ϳ� ����.
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");

		HashMap<String, Object> hMap = lists.get(index)

		int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //������Ʈ�ϱ� ��ȯ�� �� �˻��ǰ���                   �׽�Ʈ �ʿ�

		HashMap<String, Object> hMap =lists.get(index);
		hMap.put("planNum", dto.getPlanNum());
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("contentid", dto.getContentid());
		hMap.put("contenttypeid", dto.getContenttypeid());
		hMap.put("longTime",dto.getLongTime());
		hMap.put("content", dto.getContent());
		hMap.put("startDate", dto.getStartDate());

		lists.set(index, hMap);

		session.setAttribute("loginInfo", info);                      //���ǿ� ����Ʈ ��ƿø�

		}

	}*/

	@RequestMapping("/deleteTemp")
	public String deleteInfoLists (HttpServletRequest req, PlanInfoDTO dto, int index) {               //�ӽ����帮��Ʈ ���� �޼ҵ�
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //����Ʈ �߰���������� ��ü �����ϳ� ����.
			System.out.println("infolist is null and index:"+index);
		}else{
			lists = info.getInfoList();
			System.out.println("not null");

			//int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //������Ʈ�ϱ� String contentid�� �˻��ɱ�                   �׽�Ʈ �ʿ�

			lists.remove(index);

			session.setAttribute("loginInfo", info);                      //���ǿ� ����Ʈ ��ƿø�
		}

		return "redirect:/myPlanTest";
	}

	int getPlanInfoMapIndex(ArrayList<HashMap<String, Object>> lists, String key,Object value){         //������ �˻��ؼ� index��ȯ ������ -1��ȯ ���� �������ΰ����� �˻��ϸ� �������͸� ����
		int i = -1;
		for (HashMap<String, Object> hMap : lists) {
			for (String mapkey : hMap.keySet()) {
				if (hMap.get(mapkey).equals(value)) {

					i = lists.indexOf(hMap);

				}
			} 
		}
		return i;
	}

	public PlanInfoDTO getPlanInfoDTOfromContentID(HttpServletRequest req,HttpServletResponse res,Long contentid,String startDate) throws ParseException, IOException {                                       //�ϴ��� article.action�����ؼ� contentid  -> api������ȯ���� adto�ι�ȯ

		PlanInfoDTO adto = new PlanInfoDTO();
		System.out.println(contentid);

		String url =
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?contentId="+contentid+"&defaultYN=Y&addrinfoYN=Y&mapinfoYN=Y&firstImageYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTesting&_type=json&ServiceKey="
						+tourAPIKey;

		JSONParser jsonparser = new JSONParser();
		JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(res, url));
		JSONObject json =  (JSONObject) jsonobject.get("response");
		JSONObject jsonbody =  (JSONObject) json.get("body");
		JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
		JSONObject array = (JSONObject)jsonitem.get("item");


		adto.setTitle((String) array.get("title"));
		adto.setAddr1((String) array.get("addr1"));
		adto.setAddr2((String) array.get("addr2"));
		System.out.println("Addr2 : "+(String) array.get("addr2"));
		adto.setContentid(contentid);
		adto.setFirstimage((String) array.get("firstimage"));
		adto.setOverview((String) array.get("overview"));
		System.out.println(array.get("contenttypeid"));
		adto.setContenttypeid((Long) array.get("contenttypeid"));

		if(array.containsKey("mapx")){

			adto.setMapx(array.get("mapx"));
			adto.setMapy(array.get("mapy"));

		}

		return adto;
	}

	@RequestMapping("/orderUpdate")
	public void orderUpdate(HttpServletRequest req,HttpServletResponse res, String[] sortable_item) {             //�ϴ��̰��ذ� �巡�׾� ���.. �ٵ� �����?;

		for(String value : sortable_item){
			System.out.println(value);
		}
		updatetInfoLists(req, sortable_item);
		System.out.println(sortable_item.length);

	}
}


