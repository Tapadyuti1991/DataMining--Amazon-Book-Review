package com.azure.api;

import static java.lang.Math.ceil;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.azure.pojo.Pojoo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	public static String jsonBody;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * 
	 * @throws IOException
	 */

	LinkedList<String> awsImage = new LinkedList<String>();

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String homeredirect(Locale locale, Model model, HttpServletRequest request) throws IOException {

		LinkedList<Pojoo> result = MongoDAO.MongoConnection();

		LinkedList<String> genre = MongoDAO.MongoConnection2();
		LinkedList<String> author = MongoDAO.MongoConnection3();
		// System.out.println("Size of Images
		// fetcheddddddddddddd:+"+awsImage.size()+ "and the last one i" );
		// awsImage.get(9);
		// awsImage = result.getStringResult();
		// result.get(0).getStringResult();
		request.setAttribute("image", result);
		// System.out.println("Size offfffffff"+awsImage.size());
		request.setAttribute("genre", genre);
		request.setAttribute("author", author);
		// genre.clear();
		// author.size();
		// System.out.println("Afterr"+genre.size());
		// awsImage.clear();
		// System.out.println("Afterr genre"+genre.size()+"Afterr
		// image"+awsImage.size());
		// request.setAttribute("image2",
		// "https://images-na.ssl-images-amazon.com/images/I/41mJvd7-PTL.jpg");

		return "dictionary";
	}

	@RequestMapping(value = "/dictionary", method = RequestMethod.GET)
	public String dictionary(Locale locale, Model model, HttpServletRequest request) throws IOException {
		// MongoDAO.MongoConnection();

		HomeController hw = new HomeController();
		hw.homeredirect(locale, model, request);

		return "dictionary";
	}

}