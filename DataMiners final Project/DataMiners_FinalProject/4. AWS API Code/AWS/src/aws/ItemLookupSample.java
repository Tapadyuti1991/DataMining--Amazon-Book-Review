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

package aws;

import java.util.ArrayList;
import java.util.HashMap;
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
public class ItemLookupSample extends Thread{
	
	static String ipath = "C:/Part13.txt";
	
	private static  String output = "H:\\outputAsinTitle.txt";
    /*
     * Your AWS Access Key ID, as taken from the AWS Your Account page.
     */
    private static final String AWS_ACCESS_KEY_ID = "AKIAIUPILDTZMQZ3V7JA";

    /*
     * Your AWS Secret Key corresponding to the above ID, as taken from the AWS
     * Your Account page.
     */
    private static final String AWS_SECRET_KEY = "1eo9BhS+CPLeZBtScDfmglv2tnDrShIRvdmanBTN";

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
    private static final String ITEM_ID = "000100039X";
    
    static String content="";

    public static void main(String[] args) throws IOException {
    	
    	BufferedWriter bw = null;
		FileWriter fw = null;
    	
    	String line;
    	BufferedReader bf = new BufferedReader(new FileReader(ipath));
    	ArrayList <String>td = new ArrayList<>();
	
    	//for(int x = 0 ; x < 30 ; x++){
    	while((line= bf.readLine()) != null)
    	{
   		 line = line.replaceAll("\t", "");  
   		    line = line.replaceAll("\n", "");  
   		    line = line.replaceAll(" ", ""); 
   	
   		td.add(line);
   	}
    	bf.close();	
        SignedRequestsHelper helper;
        
        fw = new FileWriter(output,true);
        bw = new BufferedWriter(fw);
    
        for(String itemAsin : td){

              try {
                   helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
                  } catch (Exception e) {
                   e.printStackTrace();
                   return;
                  }
        
              String requestUrl = null;
              String title = null;

            //  System.out.println("Map form example:");
              Map<String, String> params = new HashMap<String, String>();
              params.put("Service", "AWSECommerceService");
              params.put("Version", "2009-03-31");
              params.put("Operation", "ItemLookup");
              params.put("ItemId", itemAsin.replaceAll("\t", ""));
              params.put("IdType", "ISBN");
              params.put("AssociateTag", "freddy2961988-20");
              params.put("SearchIndex", "All");
              params.put("ResponseGroup", "Large");

              requestUrl = helper.sign(params);
       //       System.out.println("Signed Request is \"" + requestUrl + "\"");
              
              title = fetchTitle(requestUrl);
        
             
    
            //  System.out.println(title);
              
         //     System.out.println("String form example:");
              String queryString = "Service=AWSECommerceService&Version=2009-03-31&Operation=ItemLookup&ResponseGroup=Large&SearchIndex=All&AssociateTag=freddy2961988-20&IdType=ISBN&ItemId="
                      + itemAsin.replaceAll("\t", "");
              requestUrl = helper.sign(queryString);
         //     System.out.println("Request is \"" + requestUrl + "\"");

              title = fetchTitle(requestUrl);
              
              content = content + (itemAsin + "|"+ title+ "\n");
              System.out.println("Title is \"" + title + "\"");
          //    System.out.println();
  
               	         			try {Thread.sleep(2500);} 
                	         			catch (Exception e) {System.out.println("Clock error");}
                                   
                                    }
 
        bw.write(content);
        bw.close();
        fw.close();
    }
    
   

    /*
     * Utility function to fetch the response from the service and extract the
     * title from the XML.
     */
    private static String fetchTitle(String requestUrl) {
        String title = null;
        String genre1 = null;
        String genre2 = null;
        String author = null;
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            Node titleNode = doc.getElementsByTagName("Title").item(0);
            Node genreN = doc.getElementsByTagName("BrowseNodeId").item(0).getNextSibling();
            Node genreN1 = doc.getElementsByTagName("BrowseNodeId").item(2).getNextSibling();
            Node authorN = doc.getElementsByTagName("Author").item(0);
            
            if(authorN.getTextContent()!= null ||authorN.getTextContent().equals("")
            		&&genreN.getTextContent()!= null||genreN.getTextContent().equals("")
            		&&titleNode.getTextContent()!=null||titleNode.getTextContent().equals("")
            		&&genreN1.getTextContent()!=null||genreN1.getTextContent().equals("")){
            genre1 = genreN.getTextContent().replaceAll(",", " ");
            genre2 = genreN1.getTextContent().replaceAll(",", " ");
            title = titleNode.getTextContent().replaceAll(",", " ");
            author = authorN.getTextContent().replaceAll(",", " ");
            }
            else{
            genre1=" ";
            genre2=" ";
            title=" ";
            author=" ";
            }
            
        } catch (Exception e) {
        	  genre1=" ";
              genre2=" ";
              title=" ";
              author=" ";
           // throw new RuntimeException(e);
        }
        return title+"|"+genre1+"|"+genre2+"|"+ author;
    }

}
