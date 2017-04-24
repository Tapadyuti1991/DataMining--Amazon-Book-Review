/**********************************************************************************************
 * Copyright 2009 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file 
 * except in compliance with the License. A copy of the License is located at
 *
 *       http://aws.amazon.com/apache2.0/
 *
 * or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS"
 * BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under the License. 
 *
 * ********************************************************************************************
 *
 *  Amazon Product Advertising API
 *  Signed Requests Sample Code
 *
 *  API Version: 2009-03-31
 *
 */

package com.azure.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import java.io.IOException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;

import java.io.FileWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;

/*
 * This class shows how to make a simple authenticated ItemLookup call to the
 * Amazon Product Advertising API.
 * 
 * See the README.html that came with this sample for instructions on
 * configuring and running the sample.
 */
public class awsApi extends Thread{
	
	//static String ipath = "C:/finalData.txt";
	
	//private static  String output = "F:\\sentimentAnalysis.txt";
    /*
     * Your AWS Access Key ID, as taken from the AWS Your Account page.
     */
    private static final String AWS_ACCESS_KEY_ID = "AKIAJLKCTNZ42G5C5IEA";

    /*
     * Your AWS Secret Key corresponding to the above ID, as taken from the AWS
     * Your Account page.
     */
    private static final String AWS_SECRET_KEY = "Nu5oWUODRD01Hm+J56Q+X/dArFjCkFgergjtoDi5";

    /*
     * Use one of the following end-points, according to the region you are
     * interested in:
     * 
     *      US: ecs.amazonaws.com 
     *      CA: ecs.amazonaws.ca 
     *      UK: ecs.amazonaws.co.uk 
     *      DE: ecs.amazonaws.de 
     *      FR: ecs.amazonaws.fr 
     *      JP: ecs.amazonaws.jp
     * 
     */
    private static final String ENDPOINT = "ecs.amazonaws.com";

    /*
     * The Item ID to lookup. The value below was selected for the US locale.
     * You can choose a different value if this value does not work in the
     * locale of your choice.
     */
    //private static final String ITEM_ID = "000100039X";
    
   // static String content="";
    //static LinkedList<String>conte = new LinkedList<String>();

    public static String getDetails(String itemAsin) throws IOException {
    	
    	
        
    	SignedRequestsHelper helper = null;
        
        	
        	if(itemAsin.length() !=10)
        	{
        		int addition = 10 - itemAsin.length();
        		for(int i = 0 ; i <addition; i++){
        			itemAsin= "0"+itemAsin;
        		}
        	}
              try {
                   helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
                  } catch (Exception e) {
                           e.printStackTrace();
                  }
        
              String requestUrl = null;
              String title = null;

 
              Map<String, String> params = new HashMap<String, String>();
              params.put("Service", "AWSECommerceService");
              params.put("Version", "2009-03-31");
              params.put("Operation", "ItemLookup");
              params.put("ItemId", itemAsin.replaceAll("\t", ""));
              params.put("IdType", "ISBN");
              params.put("AssociateTag", "tapadyuti");
              params.put("SearchIndex", "All");
              params.put("ResponseGroup", "Large");

              requestUrl = helper.sign(params);
 

              title = fetchTitle(requestUrl);
 
            //  String queryString = "Service=AWSECommerceService&Version=2009-03-31&Operation=ItemLookup&ResponseGroup=Large&SearchIndex=All&AssociateTag=tapadyuti&IdType=ISBN&ItemId="
           //           + itemAsin.replaceAll("\t", "");
            //  requestUrl = helper.sign(queryString);
 

              //title = fetchTitle(requestUrl);
              
              
              title=title.substring(0, title.indexOf(".jpg"));
              System.out.println("Inside awsApi \"" + title + "\"");
              String output = title+".jpg";
              
              //System.out.println(inputAsin.size());
            try {Thread.sleep(10);} catch (Exception e) {System.out.println("Clock error");}
        
        
    return output;

              
    }
    
   

    /*
     * Utility function to fetch the response from the service and extract the
     * title from the XML.
     */
    private static String fetchTitle(String requestUrl) {
        String imageText = null;
       
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            //Node titleNode = doc.getElementsByTagName("Title").item(0);
            Node Medimage = doc.getElementsByTagName("MediumImage").item(0).getNextSibling();
            
            if(Medimage.getTextContent()!= null ||Medimage.getTextContent().equals("")){
            imageText = Medimage.getTextContent();
            
            System.out.println("Mongo"+imageText);
            }
            else{
            	imageText="https://images-na.ssl-images-amazon.com/images/I/51qhaqPbtEL._SL160_.jpg";
            }
            
        } catch (Exception e) {
        	imageText=" ";
             
           // throw new RuntimeException(e);
        }
        return imageText;
    }

}
