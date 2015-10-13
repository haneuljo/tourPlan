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

import oracle.net.aso.h;

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
	
	@RequestMapping("/test")
	public String test(HttpServletRequest req,HttpServletResponse res) throws ParseException, IOException {
		
		return "/plan/test";
	}
	

	@RequestMapping("/choice")
	public String choice(int durTime,int endTime,Long contentid,HttpServletRequest req,HttpServletResponse res) throws ParseException, IOException {

		int time=endTime+durTime; //愿�愿묒� 異쒕컻�떆媛�
		int tran, min=0;
		int hour=0;

		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");


		if (time > 3600) {
			hour = time/3600;
			tran = time%3600;
			min = tran/60;
			//d = b % 60; //占쏙옙

			System.out.println(hour + "�떆" + min + "遺�");

		} else if (time<3600 && time>60) {

			min = time/60;
			//d = time % 60;//占쏙옙

			System.out.println(min + "遺�" );

		} 

		String stratDate = gp.getStartDate() + " " + hour + ":" + min + ":00"; 
		System.out.println("�궇吏�:" + gp.getStartDate()); 
		System.out.println("�냼�슂:" + durTime);
		System.out.println("�룄李�:" + endTime);
		System.out.println("而⑥븘�씠�뵒:" + contentid);
		System.out.println("異쒕컻�궇吏쒖떆媛�:" + stratDate);
		//System.out.println(contentid);
	
		/*�씤�꽌�듃 �빐�빞�븯�뒗 蹂��닔�뱾
		 planNum : dao.planInfoMax()+1
		 groupNum : gp.getGroupNum()
		 content : 愿�愿묒��젙蹂�
		 startDate : gp.getStartDate()
		 longTime : 0 愿�愿묎킅吏��뿉�꽌 癒몃Т瑜대뒗 �떆媛꾩쑝濡� 諛붾�붾븣留덈떎 update�빐�빞�븿
		 contentid : contentid
		 contenttypeid : 愿�愿묒����엯
		 
		hMap.put("order", 4);  //�씠遺�遺꾩� 硫� �꽔�뼱�빞�븷吏�????
		hMap.put("planNum", dao.planInfoMax()+1);
		hMap.put("groupNum", gp.getGroupNum());
		hMap.put("contentid", contentid);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",0); //default濡� 0�쑝濡�
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
		hMap.put("longTime",0); //default占쏙옙 0占쏙옙占쏙옙
		hMap.put("content", "111");
		hMap.put("startDate", gp.getStartDate());

		insertInfoLists(hMap, req );

		// HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //占쏙옙占실울옙占쏙옙 占싸깍옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙

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
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);//留먯씪
		
		if(nowDay==endDay){
			
			nowMonth ++;
			nowDay=1;
		}
		
		String nextDay=nowYear + "-"+nowMonth + "-"+ nowDay;
		PrintWriter out = resp.getWriter();
		out.print(nextDay);
	}

	@RequestMapping("/startPut")
	public void startPut(String mapx, String mapy, PlanInfoDTO pdto,int durTime,int hour,int min,String address1,String address2,HttpServletRequest req,HttpServletResponse res, Integer contentid) throws IOException {

		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");

		int endTime = 60*60*hour+60*min+durTime; //占쏙옙占쏙옙챨占�
		String startDate = pdto.getStartDate() + " " + hour + ":" + min + ":00";

		pdto.setContent(address1);
		pdto.setStartDate(startDate);
		pdto.setLongTime(0);
		pdto.setContenttypeid(888);
		pdto.setMapx(mapx);
		pdto.setMapy(mapy);
		pdto.setContent(mapx+","+mapy);
		
		gp.setSdto(pdto);


		pdto.setContent(address2);
		pdto.setStartDate(startDate);
		pdto.setLongTime(durTime);
		pdto.setContenttypeid(999);
		pdto.setMapx(mapx);
		pdto.setMapy(mapy);
		pdto.setContent(mapx+","+mapy);

		gp.setEdto(pdto);

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
		//req.setAttribute("address2", address2);//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占신몌옙占쏙옙 占시곤옙 占쏙옙占싹깍옙占쏙옙占쏙옙
		
		gp.setMapx(mapx);
		gp.setMapy(mapy);

		PrintWriter out = res.getWriter();
		out.print(endTime);
	}

	//占쏙옙占쏙옙占싹뤄옙
	@RequestMapping("/register")
	public String register(HttpServletRequest req,HttpServletResponse res) {

		System.out.println("re占쏙옙ister 占쏙옙占쏙옙");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");
		
		if(info.getInfoList()==null){
			System.out.println("infolists is null");
		}
		
		ArrayList<HashMap<String, Object>> lists = new  ArrayList<HashMap<String,Object>>();               
		lists = info.getInfoList();
		
		PlanDTO pdto = new PlanDTO();
		int groupNum = dao.planInfoGroupMax()+1;
		String email = info.getEmail();
		pdto.setGroupNum(groupNum+1);
		pdto.setEmail(email);
		pdto.setTitle(gp.getTitle());
		pdao.planInsert(pdto);
		
		PlanInfoDTO dto = new PlanInfoDTO();
		
		dto = gp.getSdto();
		dto.setPlanNum(dao.planInfoMax()+1);
		dto.setGroupNum(groupNum);
		dao.planInfoInsert(dto);
		
		dto = gp.getEdto();
		dto.setPlanNum(dao.planInfoMax()+1);
		dto.setGroupNum(groupNum);
		dao.planInfoInsert(dto);
		
		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		while(it.hasNext()){
			
			HashMap<String, Object> hMap = (HashMap<String, Object>)it.next();
			hMap.put("planNum",dao.planInfoMax()+1);
			hMap.put("groupNum", groupNum);

			dao.planInfoInsertForhMap(hMap);
			
		}	
		session.removeAttribute("groupDate"); //占쏙옙占싸울옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 session占쏙옙占쏙옙 클占쏙옙占쏙옙

		return "planInfo";
	}
	
	//占쏙옙占�
	@RequestMapping("/planAdd")
	public String planAdd(PlanDTO pdto,HttpServletRequest req,HttpServletResponse res) {
		return "plan/planAdd";
	}

	//占쏙옙占�
	@RequestMapping("/startPlace")
	public String startPlace(String startDate,HttpServletRequest req,HttpServletResponse res) {

		req.setAttribute("startDate", startDate);

		return "plan/startPlace";
	}


	//占쏙옙占쏙옙占쏙옙占쌩곤옙
	@RequestMapping("/planOk")
	public String planOk(PlanDTO pdto,String startDate,HttpServletRequest req,HttpServletResponse res) {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");
		String title = pdto.getTitle();
		System.out.println(title);
		System.out.println(startDate);
		

		pdto.setEmail(info.getEmail());
		
		gp.setTitle(title);
		gp.setGroupNum(pdto.getGroupNum());
		gp.setStartDate(startDate);
		//pdao.planInsert(pdto);
		session.setAttribute("groupDate", gp);
		req.setAttribute("startDate", startDate);

		return "newPlan";
	}

	@RequestMapping("/myPlan")                                    //   db에저장된 일정들
	public String myPlan(HttpServletRequest req) {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");
		
		String email = info.getEmail();
		List<PlanDTO> lists = pdao.getMyPlan(email);
		
		
		req.setAttribute("lists", lists);
		req.setAttribute("listsSize", lists.size());


		return "plan/myPlan";
	}
	
	@RequestMapping("/myPlanCompl")                                    //   db에저장된 일정들
	public String myPlanCompl(HttpServletRequest req, HttpServletResponse res, int groupNum) throws ParseException, IOException {
		
		List<PlanInfoDTO> lists = dao.getLists(groupNum);
		ListIterator<PlanInfoDTO> it = lists.listIterator();
		
		Object mapxex = null;
		Object mapyex = null;
		
		String startDate="임시";          //어디서 가져옴?;
		
		while(it.hasNext()){
			PlanInfoDTO dto = it.next();
			dto = (getPlanInfoDTOfromContentID(req, res, dto, startDate));
			
			if(mapxex!=null){
				dto.setMapxex(mapxex);
				dto.setMapyex(mapyex);
			}
			
			mapxex = dto.getMapx();
			mapyex = dto.getMapy();
			
			System.out.println(dto.getFirstimage());
		}
				
		req.setAttribute("lists", lists);

		return "plan/myPlanCompl";
	}

	@RequestMapping("/myPlanTest")          
	public String myPlanTest(HttpServletRequest req, HttpServletResponse res) throws ParseException, IOException {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  
		GroupSession gp = (GroupSession) session.getAttribute("groupDate");
		ArrayList<HashMap<String, Object>> lists = info.getInfoList();
		ArrayList<HashMap<String, Object>> lists2 = new ArrayList<HashMap<String,Object>>();
		Object mapxex = null;
		Object mapyex = null;
		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		int i = 0;
		while(it.hasNext()){
			
			HashMap<String, Object> hMap = (HashMap<String, Object>)it.next();
			if(mapxex!=null){
			hMap.put("mapxex", mapxex);
			hMap.put("mapyex", mapyex);
			}
			if(i==0){
				hMap.put("mapxex", gp.getMapx());
				hMap.put("mapyex", gp.getMapy());
				System.out.println("출발도착지점좌표:"+gp.getMapx());
			}
			mapxex=hMap.get("mapx");
			mapyex=hMap.get("mapy");
			
			lists2.add(hMap);
			i++;
		}	

		req.setAttribute("lists", lists2);

		listchk(lists2);

		return "plan/myPlanTest";
	}


	//------------------占쌈쏙옙占쏙옙占쏙옙柰占쏙옙---------------------


	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {                   //占쏙옙占쏙옙占쏙옙占싱븝옙 占싹놂옙 占쌨아쇽옙 占쏙옙占쏙옙트占쏙옙 占쌩곤옙 (占싸깍옙占싸울옙占쏙옙처占쏙옙 占십울옙) 

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //占쏙옙占실울옙占쏙옙 占싸깍옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //占쏙옙占쏙옙트 占쌩곤옙占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙체 占쏙옙占쏙옙占싹놂옙 占쏙옙占쏙옙.
			System.out.println("infolist is null");
		}else{
			lists = info.getInfoList();
			System.out.println("not null");
		}

		lists.add(hMap);                                             //占쏙옙占쏙옙트占쏙옙 占쏙옙占쏙옙占쌩곤옙

		info.setInfoList(lists);

		session.setAttribute("loginInfo", info);                      //占쏙옙占실울옙 占쏙옙占쏙옙트 占쏙옙틸첩占�

		/*		PlanInfoListCompartor planComp = new PlanInfoListCompartor("order");               //占쏙옙占쏙옙...  占쏙옙占� PN占쏙옙占쏙옙 占쌔듸옙 占심듸옙? 占싯삼옙占쏙옙占쏙옙 占쌓쏙옙트 占싹뤄옙.
		Collections.sort(lists,planComp);*/

		listchk(lists);                                               //占쏙옙占쏙옙트占쏙옙확占쏙옙

		System.out.println("index:"+lists.indexOf(hMap));
		System.out.println("占쏙옙占쏙옙占쏙옙:"+hMap);
		System.out.println("-----------------占쏙옙占싻쇽옙");

	}





	public void listchk(List<HashMap<String, Object>> lists){                                                        //占쏙옙占쏙옙트占쏙옙占쏙옙체크
		if(lists!=null){
			Iterator<HashMap<String, Object>> it = lists.iterator();
			HashMap<String, Object> dto = new HashMap<String, Object>();
			System.out.println("리스트시작--------------------");
			while(it.hasNext()){                                      //占쏙옙占쏙옙체크
				dto = (HashMap<String, Object>)it.next();
				System.out.println(dto);
			}
			System.out.println("리스트끝--------------------");
		}else {
			System.out.println("lists is null");
		}
	}



	public class PlanInfoListCompartor implements Comparator<HashMap<String, Object>> {                        //list占싯삼옙占쏙옙占쏙옙占쏙옙占쏙옙 占십울옙클占쏙옙占쏙옙(占쏙옙占쏙옙占쏙옙占쏙옙) 占쎌선占싸듸옙占쏙옙占쏙옙.

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

	public void updateInfoLists (HttpServletRequest req, String[] index) {               //占쌈쏙옙占쏙옙占썲리占쏙옙트 占쏙옙占쏙옙 占쌨소듸옙 占싸듸옙占쏙옙占쏙옙 占쏙옙侮乍占�
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //占쏙옙占실울옙占쏙옙 占싸깍옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //占쏙옙占쏙옙트 占쌩곤옙占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙체 占쏙옙占쏙옙占싹놂옙 占쏙옙占쏙옙.
			System.out.println("infolist is null");
		}else{
			lists = info.getInfoList();
		}

		ArrayList<HashMap<String, Object>> lists2 = new ArrayList<HashMap<String,Object>>();


		System.out.println("not null");

		for(int i = 0;i<index.length;i++) {

			int index2 = Integer.parseInt(index[i]);
			System.out.println(index2+"->"+i);
			HashMap<String, Object> hMap = lists.get(index2);
			lists2.add(hMap);	
		}
		info.setInfoList(lists2);

		listchk(lists2);        

		session.setAttribute("loginInfo", info);                      //占쏙옙占실울옙 占쏙옙占쏙옙트 占쏙옙틸첩占�



	}

	/*	public void updatetInfoLists (HttpServletRequest req, Integer index) {               //占쌈쏙옙占쏙옙占썲리占쏙옙트 占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙占쏙옙
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //占쏙옙占실울옙占쏙옙 占싸깍옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //占쏙옙占쏙옙트 占쌩곤옙占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙체 占쏙옙占쏙옙占싹놂옙 占쏙옙占쏙옙.
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");

		HashMap<String, Object> hMap = lists.get(index)

		int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //占쏙옙占쏙옙占쏙옙트占싹깍옙 占쏙옙환占쏙옙 占쏙옙諍� 占싯삼옙占실곤옙占쏙옙                   占쌓쏙옙트 占십울옙

		HashMap<String, Object> hMap =lists.get(index);
		hMap.put("planNum", dto.getPlanNum());
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("contentid", dto.getContentid());
		hMap.put("contenttypeid", dto.getContenttypeid());
		hMap.put("longTime",dto.getLongTime());
		hMap.put("content", dto.getContent());
		hMap.put("startDate", dto.getStartDate());

		lists.set(index, hMap);

		session.setAttribute("loginInfo", info);                      //占쏙옙占실울옙 占쏙옙占쏙옙트 占쏙옙틸첩占�

		}

	}*/

	@RequestMapping("/deleteTemp")
	public String deleteInfoLists (HttpServletRequest req, PlanInfoDTO dto, int index) {               //占쌈쏙옙占쏙옙占썲리占쏙옙트 占쏙옙占쏙옙 占쌨소듸옙
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //占쏙옙占실울옙占쏙옙 占싸깍옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙

		ArrayList<HashMap<String, Object>> lists;

		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //占쏙옙占쏙옙트 占쌩곤옙占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙체 占쏙옙占쏙옙占싹놂옙 占쏙옙占쏙옙.
			System.out.println("infolist is null and index:"+index);
		}else{
			lists = info.getInfoList();
			System.out.println("not null");

			//int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //占쏙옙占쏙옙占쏙옙트占싹깍옙 String contentid占쏙옙 占싯삼옙占심깍옙                   占쌓쏙옙트 占십울옙

			lists.remove(index);

			session.setAttribute("loginInfo", info);                      //占쏙옙占실울옙 占쏙옙占쏙옙트 占쏙옙틸첩占�
		}

		return "redirect:/myPlanTest";
	}

	int getPlanInfoMapIndex(ArrayList<HashMap<String, Object>> lists, String key,Object value){         //占쏙옙占쏙옙占쏙옙 占싯삼옙占쌔쇽옙 index占쏙옙환 占쏙옙占쏙옙占쏙옙 -1占쏙옙환 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占싸곤옙占쏙옙占쏙옙 占싯삼옙占싹몌옙 占쏙옙占쏙옙占쏙옙占싶몌옙 占쏙옙占쏙옙
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

	public PlanInfoDTO getPlanInfoDTOfromContentID(HttpServletRequest req,HttpServletResponse res,Long contentid,String startDate) throws ParseException, IOException {                                       //占싹댐옙占쏙옙 article.action占쏙옙占쏙옙占쌔쇽옙 contentid  -> api占쏙옙占쏙옙占쏙옙환占쏙옙占쏙옙 adto占싸뱄옙환

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

	public PlanInfoDTO getPlanInfoDTOfromContentID(HttpServletRequest req,HttpServletResponse res,PlanInfoDTO dto,String startDate) throws ParseException, IOException {                                       //占싹댐옙占쏙옙 article.action占쏙옙占쏙옙占쌔쇽옙 contentid  -> api占쏙옙占쏙옙占쏙옙환占쏙옙占쏙옙 adto占싸뱄옙환

		PlanInfoDTO adto = dto;

		String url =
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?contentId="+dto.getContentid()+"&defaultYN=Y&addrinfoYN=Y&mapinfoYN=Y&firstImageYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTesting&_type=json&ServiceKey="
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
		adto.setContentid(dto.getContentid());
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
	public String orderUpdate(HttpServletRequest req,HttpServletResponse res, String[] sortable_item) {             //占싹댐옙占싱곤옙占쌔곤옙 占썲래占쌓억옙 占쏙옙占�.. 占쌕듸옙 占쏙옙占쏙옙占�?;

		System.out.println("orderUpdate");
		for(String value : sortable_item){
			System.out.println(value);
		}
		updateInfoLists(req, sortable_item);
		System.out.println(sortable_item.length);

		return "redirect:/myPlanTest";
	}
}


