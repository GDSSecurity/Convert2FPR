/*
 *  Gotham Digital Science LLC
 *  @author Andrea Scaduto
 *  @Email ascaduto@gdssecurity.com
 *  @Blogpost https://blog.gdssecurity.com/labs/2015/6/13/converting-findbugs-xml-to-hp-fortify-sca-fpr.html
 
  / ___|___  _ ____   _____ _ __| |_|___ \|  ___|  _ \|  _ \ 
 | |   / _ \| '_ \ \ / / _ \ '__| __| __) | |_  | |_) | |_) |
 | |__| (_) | | | \ V /  __/ |  | |_ / __/|  _| |  __/|  _ < 
  \____\___/|_| |_|\_/ \___|_|   \__|_____|_|   |_|   |_| \_\

 */
package com.gdssecurity.convert2fpr;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

public class GDSConverter {

	private XMLTransformer transformer = new XMLTransformer();
	private FPRPackager packager = new FPRPackager(); 
	private static HashMap<String, String> availableFormats = new HashMap<String, String>();
	private static HashMap<String, String> availableMessages = new HashMap<String, String>();
	
	static{
		//for each input format add an entry in the availableFormats map pointing to XSL file
		availableFormats.put("findbugs", "com/gdssecurity/convert2fpr/findbugs/fvdl.xsl");
        availableFormats.put("findbugs-fast", "com/gdssecurity/convert2fpr/findbugs-fast/fvdl.xsl");
        availableFormats.put("eslint", "com/gdssecurity/convert2fpr/eslint/fvdl.xsl");
        availableFormats.put("pmd", "com/gdssecurity/convert2fpr/pmd/fvdl.xsl");

		//add an entry for the correspondent finding descriptions file
		availableMessages.put("findbugs", "com/gdssecurity/convert2fpr/findbugs/messages.xml");
        availableMessages.put("findbugs-fast", "com/gdssecurity/convert2fpr/findbugs/messages.xml");
	}

	private void run(String format, String sourceFile, String messages){

		String XslTransformation = availableFormats.get(format);
		if(XslTransformation!=null){
			String XslPath = getClass().getClassLoader().getResource(XslTransformation).toString();
			File outputAuditFile = null;
			String messagesPath = null;
			if(messages==null){
				String messagesEnrichment = availableMessages.get(format);
				if(messagesEnrichment!=null)
					messagesPath = getClass().getClassLoader().getResource(messagesEnrichment).toString();
			}
			else{
				File messagesFile = new File(messages);
				if(messagesFile.exists()){
					messagesPath = messages;
				}
				else{
					System.out.println("Sorry the XML file you specified could not be found.");	
				}
			}
			try {
				System.out.println("Processing...");
				outputAuditFile = transformer.applyTransformation(sourceFile, XslPath, messagesPath, format);
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				packager.addFilesToExistingZip(outputAuditFile, sourceFile.substring(0, sourceFile.lastIndexOf('.'))+".fpr");
				System.out.println("Done. Output file is: "+sourceFile.substring(0, sourceFile.lastIndexOf('.'))+".fpr");

			} catch (IOException e) {
				//do nothing, addFilesToExistingZip finally block exceptions should not be handled here.
			}
		}
		else{
			System.err.println("Sorry the requested format is currently not available. Please refer to the usage or contact Gotham Digital Science for further information.");
			System.exit(1);
		}
	}

	public static void main(String args[]){

		GDSConverter mc = new GDSConverter();
		String format= null, sourceFile = null, messages = null;
		if (args.length < 2) {
			System.err.println("Usage: java -jar convert2FPR.jar findbugs report.xml");
			System.exit(1);
		}
		else if(args.length==2){
			format = args[0];
			sourceFile = args[1];
			messages = null;
		}
		else if(args.length==3){
			format = args[0];
			sourceFile = args[2];
			messages = args[1];
		}

		File source = new File(sourceFile);

		if(source.exists()){
			mc.run(format, sourceFile, messages);
		}
		else{
			System.err.println("Sorry the XML file you specified could not be found. Please refer to the usage or contact Gotham Digital Science for further information.");	
		}
	}
}
