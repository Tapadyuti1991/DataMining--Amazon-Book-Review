/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package nlp;
import org.ejml.simple.SimpleMatrix;
import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.neural.rnn.RNNCoreAnnotations;
import edu.stanford.nlp.pipeline.Annotation;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;
import edu.stanford.nlp.sentiment.SentimentCoreAnnotations.SentimentAnnotatedTree;
import edu.stanford.nlp.trees.Tree;
import edu.stanford.nlp.util.CoreMap;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

/**
 *
 * @author Lenovo
 */
public class NLP {

    static StanfordCoreNLP pipeline;

    static String ipath = "H:/nlpinput1.txt";

    private static String output = "H:\\sentimentAnalysis.txt";

    public static void init() {
        Properties props = new Properties();
        
        // By adding the "sentiment" to the list of annotators we are analysing
        // the text.
        // ssplit is used to split the sentence into tokens
        // tokenizer saves the character offset of each token in input text.
        // parse provides full syntactic analysis
        props.setProperty("annotators", "tokenize, ssplit, parse, sentiment");

        // Creates a StanfordCoreNLP object with parsing and sentiment analysis.
        pipeline = new StanfordCoreNLP(props);
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, IOException {

        try{init();

        BufferedWriter bw = null;
        FileWriter fw = null;

        String line;

        int count= 0; 
        BufferedReader bf = new BufferedReader(new FileReader(ipath));
        bf.readLine();
        StringBuilder Soutput = new StringBuilder();
        fw = new FileWriter(output, true);
    	bw = new BufferedWriter(fw);
        while ((line = bf.readLine()) != null) {
            
          String input[] = line.split(",");

            int TextScore = findSentiment(input[6]);
            
            int SummaryScore = findSentiment(input[7]);
            System.out.println(input[7]);
            double averageScore = (TextScore + SummaryScore)/2;
            
            
            double userRating = Double.parseDouble(input[10].replaceAll("[^\\w\\s]",""))/10;
            
            double diff = userRating - averageScore;
            
            if(diff > 2){
            
            Soutput = Soutput.append(line+","+String.valueOf(diff)+","+"I"+"\n");
            }
            else
            {
              Soutput = Soutput.append(line+","+String.valueOf(diff)+","+"NI"+"\n");  
            }
            
            System.out.println(count++);
            bw.write(Soutput.toString());
           // if(count == 10)
            //    break;
        }
        
        
    	bf.close();
        
        
        
        
        bw.close();
        fw.close();
        }
        catch(Exception e){
        System.out.println(e.toString());
        }
        

    }

    public static int findSentiment(String review) {

        int mainSentiment = 0;
        // checking if the length of the review is > 0 or not. Therefore
        // checking if any review is present or not.
        if (review != null && review.length() > 0) {
            int longest = 0;
            try {
                // Process the reviews with the annotators in the
                // StanfordCoreNLP object.
                Annotation annotation = pipeline.process(review);

                // a CoreMap is essentially a Map that uses class objects as
                // keys and has values with custom types
                for (CoreMap sentence : annotation.get(CoreAnnotations.SentencesAnnotation.class)) {
                    // Parses the sentence in the tree structure
                    Tree tree = sentence.get(SentimentAnnotatedTree.class);

                    // Recursively traverse through the tree. Performs Recursive
                    // Neural Network.
                    // It gets the sentiment score of that sentence.
                    int sentiment = RNNCoreAnnotations.getPredictedClass(tree);
                    SimpleMatrix sentiment_new = RNNCoreAnnotations.getPredictions(tree);

                    // converting String to text
                    String partText = sentence.toString();

                    // Checking the size of the text.
                    if (partText.length() > longest) {
                        mainSentiment = sentiment;
                        // Saving the length of the text which will be used for
                        // sentences larger than the sentence.
                        longest = partText.length();
                    }
                }
            } catch (Exception e) {
                // System.out.println("Exception is " + e.printStackTrace());
                e.printStackTrace();
            }
        }
        // returning the sentiment score.
        return mainSentiment;
    }

}
