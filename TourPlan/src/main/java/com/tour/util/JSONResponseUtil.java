package com.tour.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


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
}
