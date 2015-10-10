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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
			//d = b % 60; //초

			System.out.println(hour + "시" + min + "분");

		} else if (time<3600 && time>60) {

			min = time/60;
			//d = time % 60;//초

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
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  
		//세션에서 로그인정보 가져오기
		
		ArrayList<HashMap<String, Object>> lists;

		lists = info.getInfoList();

		req.setAttribute("lists", lists);


		return "redirect:/myPlanTest";

		//return "plan/newplan";
	}
	/*@ResponseBody
	public ResponseEntity<String> choice(HttpServletRequest req,HttpServletResponse res, Integer contentid,Integer areaCode) throws IOException{

		System.out.println(areaCode);
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList ?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey
				+ "&areaCode="+areaCode;
				//+ "&contentid="+contentid;

		JSONResponseUtil util = new JSONResponseUtil();

		return util.getJSONResponse(res, url);
	}*/

	@RequestMapping("/startPut")
	public String startPut(PlanInfoDTO pdto,int durTime,int hour,int min,String address1,String address2,HttpServletRequest req,HttpServletResponse res, Integer contentid) {

		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");

		int endTime = 60*60*hour+60*min+durTime; //도착시간
		String startDate = pdto.getStartDate() + " " + hour + ":" + min + ":00";

		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address1);
		pdto.setStartDate(startDate);
		pdto.setLongTime(0);

		//dao.planInfoInsert(pdto);//출발 insert


		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address2);
		pdto.setStartDate(startDate);
		pdto.setLongTime(durTime);

		//dao.planInfoInsert(pdto);//도착 insert

		System.out.println(pdto.getStartDate());
		System.out.println(hour);
		System.out.println(min);
		System.out.println(address1);
		System.out.println(address2);
		System.out.println(endTime);
		//System.out.println(durTime);
		//System.out.println(durTime);
		//req.setAttribute("durTime", durTime);
		req.setAttribute("startDate", gp.getStartDate());
		req.setAttribute("endTime", endTime);
		req.setAttribute("address2", address2);//다음 관광지와 거리는 시간 구하기위해

		return "newPlan";
	}

	//�����Ϸ�
	@RequestMapping("/register")
	public String register(HttpServletRequest req,HttpServletResponse res) {

		System.out.println("re��ister ����");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo"); 
		
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
			//hMap.put("groupNum", dao.planInfoGroupMax()+1);
			dao.planInfoInsertForhMap(hMap);
			
		}	
		
		listchk(lists);
		session.removeAttribute("groupDate");

		return "planInfo";
	}
	
	//모달창
	@RequestMapping("/planAdd")
	public String planAdd(PlanDTO pdto,HttpServletRequest req,HttpServletResponse res) {

		return "plan/planAdd";
	}

	//모달창
	@RequestMapping("/startPlace")
	public String startPlace(String startDate,HttpServletRequest req,HttpServletResponse res) {

		req.setAttribute("startDate", startDate);

		return "plan/startPlace";
	}


	//관광일정추가
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
	
	
	//내일정보기
	@RequestMapping("/myPlan")                                    
	public String myPlan(HttpServletRequest req) {

		int groupNum = 1;

		List<PlanInfoDTO> lists = dao.getLists(groupNum);

		req.setAttribute("lists", lists);

		return "myPlan";
	}

/*	//내일정보기
	@RequestMapping("/dayAdd")                                 
	public String dayAdd(HttpServletRequest req){
		
		req.setAttribute("startDate", "2015-10-10");
		return "plan/tiles/dayAdd";
	}*/
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
	//내일정보기
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

		return "myPlanTest";
	}



	//------------------임시저장소관련---------------------

	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {                   //�������̺� �ϳ� �޾Ƽ� ����Ʈ�� �߰� (�α��ο���ó�� �ʿ�) 

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                      
			//리스트 추가한적없으면 객체 새로하나 만듬.
			lists = new  ArrayList<HashMap<String,Object>>();               
			System.out.println("infolist is null");
		}else{
			lists = info.getInfoList();
			System.out.println("not null");
		}

		lists.add(hMap);                                             
		//리스트에 일정추가

		info.setInfoList(lists);

		session.setAttribute("loginInfo", info);                      
		//세션에 리스트 올림
		/*		PlanInfoListCompartor planComp = new PlanInfoListCompartor("order");               //����...  ��� PN���� �ص� �ɵ�? �˻����� �׽�Ʈ �Ϸ�.
		Collections.sort(lists,planComp);*/

		listchk(lists);                    //리스트안확인

		System.out.println("index:"+lists.indexOf(hMap));
		System.out.println("모두출력:"+hMap);
		System.out.println("-----------------구분선");
      

	}


/*	@RequestMapping("/forTest")
	public String forTest (HttpServletRequest req,HttpServletResponse res) throws ParseException, IOException {                                                      //���׽���

		PlanInfoDTO adto = new PlanInfoDTO();
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("order", 4);
		hMap.put("planNum", 1);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 397664);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",60);
		hMap.put("content", "111");
		hMap.put("startDate", "2015-10-1 00:00:00");
		adto = getPlanInfoDTOfromContentID(req, res, 397664);
		hMap.put("firstimage",adto.getFirstimage());
		hMap.put("addr1",adto.getAddr1());
		hMap.put("addr2",adto.getAddr2());
		hMap.put("title",adto.getTitle());
		hMap.put("mapx",adto.getMapx());
		hMap.put("mapy",adto.getMapy());


		insertInfoLists(hMap, req );

		hMap = new HashMap<String, Object>();
		hMap.put("order", 2);
		hMap.put("planNum", 2);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 1331760);
		hMap.put("contenttypeid", 2);
		hMap.put("longTime",60);
		hMap.put("content", "222");
		hMap.put("startDate", "2015-10-1 00:00:01");
		adto = getPlanInfoDTOfromContentID(req, res, 1331760);
		hMap.put("firstimage",adto.getFirstimage());
		hMap.put("addr1",adto.getAddr1());
		hMap.put("addr2",adto.getAddr2());
		hMap.put("title",adto.getTitle());
		hMap.put("mapx",adto.getMapx());
		hMap.put("mapy",adto.getMapy());

		insertInfoLists(hMap, req );

		hMap = new HashMap<String, Object>();
		hMap.put("order", 3);
		hMap.put("planNum", 3);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 1883038);
		hMap.put("contenttypeid", 3);
		hMap.put("longTime",60);
		hMap.put("content", "333");
		hMap.put("startDate", "2015-10-1 00:00:02");
		adto = getPlanInfoDTOfromContentID(req, res, 1883038);
		hMap.put("firstimage",adto.getFirstimage());
		hMap.put("addr1",adto.getAddr1());
		hMap.put("addr2",adto.getAddr2());
		hMap.put("title",adto.getTitle());
		hMap.put("mapx",adto.getMapx());
		hMap.put("mapy",adto.getMapy());

		insertInfoLists(hMap, req );

		return "redirect:/myPlanTest";
	}*/



	public void listchk(List<HashMap<String, Object>> lists){                                                        //����Ʈ����üũ
		if(lists!=null){
			Iterator<HashMap<String, Object>> it = lists.iterator();
			HashMap<String, Object> dto = new HashMap<String, Object>();
			System.out.println("--------------------------");
			while(it.hasNext()){                                      //내용체크
				dto = (HashMap<String, Object>)it.next();
				System.out.println(dto);
			}
			System.out.println("--------------------------");
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

	public void updatetInfoLists (HttpServletRequest req, String[] index) {               //임시저장리스트 수정 메소드 인덱스로 순서바꿈용
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //리스트 추가한적없으면 객체 새로하나 만듬.
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

		session.setAttribute("loginInfo", info);                     
		//세션에 리스트 담아올림
	}

	/*	public void updatetInfoLists (HttpServletRequest req, Integer index) {               //�ӽ����帮��Ʈ ���� �޼ҵ� ������
>>>>>>> 211f19208412f8b26c3618667448b32c6cd7d425
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //���ǿ��� �α���������������

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //����Ʈ �߰���������� ��ü �����ϳ� ����.
			System.out.println("infolist is null");
		}else{
<<<<<<< HEAD
			lists = info.getInfoList();
			System.out.println("not null");

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

	}

=======
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
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //리스트 추가한적없으면 객체 새로하나 만듬.
			System.out.println("infolist is null and index:"+index);
		}else{
			lists = info.getInfoList();
			System.out.println("not null");

			//int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //오브젝트니까 String contentid로 검색될까                   테스트 필요

			lists.remove(index);

			session.setAttribute("loginInfo", info);                      //세션에 리스트 담아올림
		}


		return "redirect:/myPlanTest";
	}

	int getPlanInfoMapIndex(ArrayList<HashMap<String, Object>> lists, String key,Object value){     //값으로 검색해서 index반환 없을시 -1반환 값이 여러개인것으로 검색하면 마지막것만 나옴
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
	public void orderUpdate(HttpServletRequest req,HttpServletResponse res, String[] sortable_item) {             //하늘이가준거 드래그앤 드랍.. 근데 사라짐?;

		for(String value : sortable_item){
			System.out.println(value);
		}
		updatetInfoLists(req, sortable_item);
		System.out.println(sortable_item.length);

	}
	
	
}


