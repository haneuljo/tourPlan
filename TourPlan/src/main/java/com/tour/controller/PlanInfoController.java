package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
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
import com.tour.dto.ArticleDTO;
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
	
	@RequestMapping("/newplan")
	public String newplan(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "plan/selPlan";
	}
	
	@RequestMapping("/choice")
	@ResponseBody
	public ResponseEntity<String> choice(HttpServletRequest req,HttpServletResponse res, Integer contentid,Integer areaCode) throws IOException{
		
		System.out.println(areaCode);
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList ?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey
				+ "&areaCode="+areaCode;
				//+ "&contentid="+contentid;
		
		JSONResponseUtil util = new JSONResponseUtil();
		
		return util.getJSONResponse(res, url);
	}
	
	@RequestMapping("/startPut")
	public String startPut(PlanInfoDTO pdto,int durTime,int hour,int min,String address1,String address2,HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		HttpSession session = req.getSession();
		GroupSession gp = (GroupSession) session.getAttribute("groupNum");
		
		String startDate = pdto.getStartDate() + " " + hour + ":" + min + ":00";
		
		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address1);
		pdto.setStartDate(startDate);
		pdto.setLongTime(0);

		dao.planInfoInsert(pdto);
		
		pdto.setPlanNum(dao.planInfoMax()+1);
		pdto.setGroupNum(gp.getGroupNum());
		pdto.setContent(address2);
		pdto.setStartDate(startDate);
		pdto.setLongTime(durTime);
		
		dao.planInfoInsert(pdto);
		
		System.out.println(pdto.getStartDate());
		System.out.println(durTime);
		System.out.println(hour);
		System.out.println(min);
		System.out.println(address1);
		System.out.println(address2);
		//System.out.println(durTime);
		//System.out.println(durTime);
		//req.setAttribute("durTime", durTime);
		
		return "plan/newplan";
	}
	
	//일정완료
	@RequestMapping("/register")
	public String register(PlanInfoDTO pdto,HttpServletRequest req,HttpServletResponse res, Integer contentid[],String sday[],String stime[],String eday[],String etime[]) {
		
			
		
			//System.out.println("컨아이디:" + contentid[i]);
			//String start = sday[i] +" " + stime[i];
			//String end = eday[i] + " " + etime[i];
		//	System.out.println("시작:" + start );
			//System.out.println("끝:" + end);
			
			pdto.setPlanNum(dao.planInfoMax()+1);
			pdto.setGroupNum(1);
			pdto.setContent("관광지");
		//	pdto.setStartDate(start);
			//pdto.setLongTime(end);
		//	pdto.setContentid(contentid[i]);
			pdto.setContenttypeid(12);
			
			dao.planInfoInsert(pdto);
			
		return "plan/planInfo";
	}
	
	@RequestMapping("/planAdd")
	public String planAdd(PlanDTO pdto,HttpServletRequest req,HttpServletResponse res) {
	
		
		return "plan/planAdd";
	}
	
	
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
		session.setAttribute("groupNum", gp);
		req.setAttribute("startDate", startDate);
		
		return "plan/newplan";
	}
	
	@RequestMapping("/myPlan")                                    //내일정보기
	public String myPlan(HttpServletRequest req) {
		
		int groupNum = 1;
		
		List<PlanInfoDTO> lists = dao.getLists(groupNum);
			
		req.setAttribute("lists", lists);
			
		return "plan/myPlan";
	}
	
	@RequestMapping("/myPlanTest")                                    //내일정보기
	public String myPlanTest(HttpServletRequest req, HttpServletResponse res) throws ParseException, IOException {
		
		forTest(req);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기
		
		ArrayList<HashMap<String, Object>> lists = info.getInfoList();
		
		req.setAttribute("lists", lists);

		ListIterator<HashMap<String, Object>> it = lists.listIterator();
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		ArticleDTO adto = new ArticleDTO();
		List<ArticleDTO> alists = new ArrayList<ArticleDTO>();
		
		while(it.hasNext()){
			
			hMap = it.next();
			Integer contentid = (Integer) hMap.get("contentid");
			adto = getADTOfromContentID(req, res, contentid);
			alists.add(adto);
		}					
		
		req.setAttribute("alists", alists);
		
		
		return "plan/myPlanTest";
	}
	
	
	//------------------임시저장소관련---------------------
	
	
	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {                   //일정테이블 하나 받아서 리스트에 추가 (로그인예외처리 필요) 
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기

		ArrayList<HashMap<String, Object>> lists;
		
		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //리스트 추가한적없으면 객체 새로하나 만듬.
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");
		}

		lists.add(hMap);                                             //리스트에 일정추가
		
		info.setInfoList(lists);
		
		session.setAttribute("loginInfo", info);                      //세션에 리스트 담아올림
		
/*		PlanInfoListCompartor planComp = new PlanInfoListCompartor("order");               //정렬...  순서는 PN으로 해도 될듯? 검색정렬 테스트 완료.
		Collections.sort(lists,planComp);*/
		
		listchk(lists);                                               //리스트안확인
		
		System.out.println("index:"+lists.indexOf(hMap));
		System.out.println("모두출력:"+hMap);
		System.out.println("-----------------구분선");
		
	}
	

	public void forTest (HttpServletRequest req) {                                                      //걍테스팅
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("order", 4);
		hMap.put("planNum", 1);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 397664);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",60);
		hMap.put("content", "111");
		hMap.put("startDate", "2015-10-1 00:00:00");
		
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
		
		insertInfoLists(hMap, req );

	}

	//dragTest
	
	@RequestMapping("/dragTest")
	public String dragTest(HttpServletRequest req,HttpServletResponse res, Integer contentid) {             //하늘이가준거 드래그앤 드랍.. 근데 사라짐?;
	
		return "plan/dragTest";
	}


public void listchk(List<HashMap<String, Object>> lists){                                                        //리스트내용체크

	Iterator<HashMap<String, Object>> it = lists.iterator();
	HashMap<String, Object> dto = new HashMap<String, Object>();
		
		while(it.hasNext()){                                      //내용체크
			dto = (HashMap<String, Object>)it.next();
			System.out.println(dto);
		}
	}



	public class PlanInfoListCompartor implements Comparator<HashMap<String, Object>> {                        //list검색정렬위한 필요클래스(오름차순) 우선인덱스로.

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
	
	public void updatetInfoLists (HttpServletRequest req, PlanInfoDTO dto) {               //임시저장리스트 수정 메소드
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기

		ArrayList<HashMap<String, Object>> lists;
		
		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //리스트 추가한적없으면 객체 새로하나 만듬.
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");
		
		int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //오브젝트니까 형변환이 없어도 검색되겠지                   테스트 필요
		
		HashMap<String, Object> hMap =lists.get(index);
		hMap.put("planNum", dto.getPlanNum());
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("contentid", dto.getContentid());
		hMap.put("contenttypeid", dto.getContenttypeid());
		hMap.put("longTime",dto.getLongTime());
		hMap.put("content", dto.getContent());
		hMap.put("startDate", dto.getStartDate());
		
		lists.set(index, hMap);
		
		session.setAttribute("loginInfo", info);                      //세션에 리스트 담아올림
		
		}
		
	}
	
	public void deleteInfoLists (HttpServletRequest req, PlanInfoDTO dto) {               //임시저장리스트 삭제 메소드
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기

		ArrayList<HashMap<String, Object>> lists;
		
		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();               //리스트 추가한적없으면 객체 새로하나 만듬.
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");
		
		int index = getPlanInfoMapIndex(lists, "planNum", dto.getPlanNum());                //오브젝트니까 String contentid로 검색될까                   테스트 필요
		
		lists.remove(index);
		
		session.setAttribute("loginInfo", info);                      //세션에 리스트 담아올림
		}
	}
	
	int getPlanInfoMapIndex(ArrayList<HashMap<String, Object>> lists, String key,Object value){         //값으로 검색해서 index반환 없을시 -1반환 값이 여러개인것으로 검색하면 마지막것만 나옴
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
	
	public ArticleDTO getADTOfromContentID(HttpServletRequest req,HttpServletResponse res,Integer contentid) throws ParseException, IOException {                                       //하늘이 article.action수정해서 contentid  -> api정보반환만듬 adto로반환
		
		ArticleDTO adto = new ArticleDTO();
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
        
        	if(array.containsKey("mapx")){
			
			adto.setMapx(array.get("mapx"));
			adto.setMapy(array.get("mapy"));
			
        	}
		
		return adto;
	}
}
