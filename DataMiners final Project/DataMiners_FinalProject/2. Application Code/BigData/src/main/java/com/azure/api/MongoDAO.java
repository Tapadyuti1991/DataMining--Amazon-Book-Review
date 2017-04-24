/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.azure.api;



import com.azure.pojo.Pojoo;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
 

/**
 *
 * @author Big_Data
 */
public class MongoDAO {

    public static LinkedList<Pojoo>  MongoConnection() throws IOException {
      
        MongoClient mongo = new MongoClient("localhost", 27017);
 
        DB db = mongo.getDB("test");
 
        DBCollection table = db.getCollection("DataFinal");

        List<String> uniId = table.distinct("Asin");
 
        
        
	//BasicDBObject searchQuery = new BasicDBObject();
	//searchQuery.put("Asin", "000100039X");
	DBObject groupFields = new BasicDBObject( "_id", "$Asin");
	
	groupFields.put("count", new BasicDBObject( "$sum", 1));
	//DBObject group = new BasicDBObject("$group", groupFields );
	DBObject sortFields = new BasicDBObject("count", -1);
	//AggregationOutput output = table.aggregate(group, new BasicDBObject("$sort", sortFields ));
	//System.out.println(output.results());//Top reviews 
	
	groupFields.put("average", new BasicDBObject( "$avg", "$Ratings"));
	DBObject group2 = new BasicDBObject("$group", groupFields);
	
	AggregationOutput output2 = table.aggregate(group2,new BasicDBObject("$sort", sortFields ));
	
	
	Iterable<DBObject> iterable =output2.results();
 
	//LinkedList<String>stringResult = new LinkedList<String>();
	 
	//LinkedList<String>stringrating = new LinkedList<String>();

	//if(awsResult.size()!=0){awsResult.remove();}
	//if(stringResult.size()!=0){stringResult.remove();}
	
	//System.out.println("fffffffffffffffff"+stringResult.size());
	
	int count =0;
	
	LinkedList<Pojoo> uiList = new LinkedList<Pojoo>();
    for (DBObject res : output2.results()) {
    	
    	//System.out.println("TTTTTTTT "+res.get("_id").toString());
    	//System.out.println("VVVVVVVV "+res.get("average").toString());
    	String awsResult = awsApi.getDetails(res.get("_id").toString());
    	//stringResult.add(res.get("_id").toString());
    	//stringrating.add(res.get("average").toString());
    	 Pojoo polo = new Pojoo();
    	 polo.setStringResult(awsResult);
         polo.setStringrating(res.get("average").toString());
         uiList.add(polo);
    	
    	count++;
    	if(count==8)
    		{res=null;
    		break;
    		}
    }
    
   
    
    count=0;
    
    
    //awsResult = awsApi.getDetails(stringResult);
    //for(String htp: awsResult){
    //Pojoo polo = new Pojoo();
    //polo.setStringResult(htp);
	//polo.setStringrating(res.get("average").toString());
	//uiList.add(polo);
    //}
    
    
   // System.out.println("WWWWWW"+awsResult);
    //Pojoo img = new Pojoo();
    //img.setStringrating(stringrating);
    //img.setStringResult(awsResult);
    //stringResult.remove();
	
    //System.out.println("eeeeeeeeeeeeeee"+awsResult.size());
    //for(String ret:awsResult)
    //{
    //	System.out.println(ret);
    //}
    
    
    
    return uiList;


    }
    
    public static LinkedList<String>  MongoConnection2() throws IOException {
    
    	MongoClient mongo = new MongoClient("localhost", 27017);
    	 
        DB db = mongo.getDB("test");
 
        DBCollection table = db.getCollection("DataFinal");
        DBObject sortFields = new BasicDBObject("count", -1);
        DBObject groupGenreFields = new BasicDBObject( "_id", "$Genre1");
    	groupGenreFields.put("count", new BasicDBObject( "$sum", 1));
    	DBObject genregroup = new BasicDBObject("$group", groupGenreFields );
    	AggregationOutput Genreoutput = table.aggregate(genregroup, new BasicDBObject("$sort", sortFields ));
    	
    	
    	LinkedList<String>stringResult = new LinkedList<String>();
    	
    	int count =0;
        for (DBObject res : Genreoutput.results()) {
        	stringResult.add(res.get("_id").toString());
        	System.out.println(res.get("_id").toString());
        	count++;
        	if(count==8)
        		break;
        	
        }
 
        System.out.print("strinResult Size"+stringResult.size());
 
    	return stringResult;
 
    }
    
    
    
    public static LinkedList<String>  MongoConnection3() throws IOException {
        
    	MongoClient mongo = new MongoClient("localhost", 27017);
    	 
        DB db = mongo.getDB("test");
 
        DBCollection table = db.getCollection("DataFinal");
        DBObject sortFields = new BasicDBObject("count", -1);
        DBObject groupGenreFields = new BasicDBObject( "_id", "$Author");
    	groupGenreFields.put("count", new BasicDBObject( "$sum", 1));
    	DBObject genregroup = new BasicDBObject("$group", groupGenreFields );
    	AggregationOutput Genreoutput = table.aggregate(genregroup, new BasicDBObject("$sort", sortFields ));
    	
    	
    	LinkedList<String>stringResult = new LinkedList<String>();
    	
    	int count =0;
        for (DBObject res : Genreoutput.results()) {
        	stringResult.add(res.get("_id").toString());
        	System.out.println(res.get("_id").toString());
        	count++;
        	if(count==8)
        		break;
        	
        }
 
        System.out.print("strinResult Size"+stringResult.size());
 
    	return stringResult;
 
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
