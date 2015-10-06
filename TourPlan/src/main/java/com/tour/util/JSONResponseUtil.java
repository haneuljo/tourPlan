package com.tour.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.tour.dto.ClipBoardDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class JSONResponseUtil {
	
	public ResponseEntity<String> getJSONResponse(HttpServletResponse response, String apiUrl) throws IOException {
		BufferedReader reader = null;
        try {
            URL url = new URL(apiUrl);

            reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String str = "";

            StringBuffer buffer = new StringBuffer();
            while ((str= reader.readLine()) != null)
            {
            	buffer.append(new String(str));
            }
            HttpHeaders responseHeaders = new HttpHeaders();

            responseHeaders.add("Content-Type", "text/html; charset=UTF-8");
            //System.out.println(buffer.toString());
            return new ResponseEntity<String>(buffer.toString(), responseHeaders, HttpStatus.CREATED);
        } finally {
            if (reader != null)
                reader.close();
        }

	}
	public String getJSONResponseString(HttpServletResponse response, String apiUrl) throws IOException {
		BufferedReader reader = null;
		try {
			URL url = new URL(apiUrl);
			
			reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			String str = "";
			
			StringBuffer buffer = new StringBuffer();
			while ((str= reader.readLine()) != null)
			{
				buffer.append(new String(str));
			}
			HttpHeaders responseHeaders = new HttpHeaders();
			
			responseHeaders.add("Content-Type", "text/html; charset=UTF-8");
			//System.out.println(buffer.toString());
			return buffer.toString();
		} finally {
			if (reader != null)
				reader.close();
		}
		
	}
	
	public void clipPage(List<ClipBoardDTO> clipList, HttpServletRequest req){
		
		HttpSession session = req.getSession(true); 
		ClipSession clipSe = new ClipSession();
		
		JSONObject clipObj = new JSONObject();
		JSONObject josnObj = new JSONObject();
		JSONObject itemObj =new JSONObject();
		JSONObject pageObj =new JSONObject();
			
		int count =1;
		int page=1;
		JSONArray clipArr = new JSONArray();
		JSONArray itemArray = new JSONArray();
		
		for(ClipBoardDTO dto : clipList){
			
			JSONObject clipJSON =JSONObject.fromObject(dto);
			
			
			if(count%12==0 || count==clipList.size()){
				
				//ites에 담을것
				itemArray.add(clipJSON);
				
				clipObj.put("page", page);
				clipObj.put("item", itemArray);
				clipArr.add(clipObj);
				
				pageObj.put("items", clipArr);
				page++;
				//clipArray = new JSONArray();
			}else{
				itemArray.add(clipJSON);
			}
			
			
			count++;
			
		}
			
		josnObj.put("body", pageObj);
		//JSONObject dd = (JSONObject) clipArray.get(2);
		//System.out.print(dd.get("page"));
		
	
		clipSe.setClipList(josnObj);
		clipSe.setTotalPage(page);
		session.setAttribute("clipJSON", clipSe);
		
	}
}
