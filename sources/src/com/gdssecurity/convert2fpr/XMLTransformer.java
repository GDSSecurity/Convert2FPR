/*
 *  Gotham Digital Science LLC
 *  @author Andrea Scaduto
 *  @Email ascaduto@gdssecurity.com - andreascaduto@me.com
 *  @Blogpost https://blog.gdssecurity.com/labs/2015/6/13/converting-findbugs-xml-to-hp-fortify-sca-fpr.html

  / ___|___  _ ____   _____ _ __| |_|___ \|  ___|  _ \|  _ \ 
 | |   / _ \| '_ \ \ / / _ \ '__| __| __) | |_  | |_) | |_) |
 | |__| (_) | | | \ V /  __/ |  | |_ / __/|  _| |  __/|  _ < 
  \____\___/|_| |_|\_/ \___|_|   \__|_____|_|   |_|   |_| \_\
                                                          
*/

package com.gdssecurity.convert2fpr;

import java.io.File;
import java.io.IOException;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;

public class XMLTransformer {
	
	private static final String FORTIFY_AUDIT_FILENAME = "audit.fvdl";
	private static final String TMP_FILE = "tmp.xml";
	private static final String FEATURE = "http://apache.org/xml/features/disallow-doctype-decl";
	
	
	protected File applyTransformation(String xmlSource, String xsl, String messages, String format) throws ParserConfigurationException, SAXException, IOException, TransformerException {
		String sourceFile = xmlSource;
		if(messages!=null){
			if(format.equals("findbugs")||format.equals("findbugs-fast"))	
				mergeFindbugsXML(xmlSource, messages);
			sourceFile = TMP_FILE;
		}
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setNamespaceAware(true);
		factory.setFeature(FEATURE, true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		DOMSource source = new DOMSource(builder.parse(sourceFile));
		
		TransformerFactory transfomerFactory = new net.sf.saxon.TransformerFactoryImpl();
		transfomerFactory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

		Transformer transformer = transfomerFactory.newTransformer(new StreamSource(xsl));
		File outputAuditFile = new File(FORTIFY_AUDIT_FILENAME);
		StreamResult result = new StreamResult(outputAuditFile);
		transformer.transform(source, result);
		
		File tmp = new File(TMP_FILE);
		if(tmp.exists())
			tmp.delete();
		
		return outputAuditFile;
	}
	
	protected void mergeFindbugsXML(String xmlSource, String messages) throws ParserConfigurationException, SAXException, IOException{
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setFeature(FEATURE, true);
		DocumentBuilder builder = dbFactory.newDocumentBuilder();
		Document doc1 = builder.parse(xmlSource);
		Document doc2 = builder.parse(messages);
		generateDocument(doc1,doc2,"/BugCollection", "/MessageCollection");
	}
	
	private void generateDocument(Document root, Document insertDoc, String toPath, String fromPath) {
		StreamResult result = null;
		if (null != root) {
			try {
				Node element = getNode(insertDoc, fromPath);
				Node dest = root.importNode(element, true);
				Node node = getNode(root, toPath);
				node.insertBefore(dest, null);
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(root);
				result = new StreamResult(new File(TMP_FILE));
				transformer.transform(source, result);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	private Node getNode(Document doc, String strXpathExpression)
			throws ParserConfigurationException, SAXException, IOException,
			XPathExpressionException {

		XPath xpath = XPathFactory.newInstance().newXPath();
		XPathExpression expr = xpath.compile(strXpathExpression);
		Node node = (Node) expr.evaluate(doc, XPathConstants.NODE);

		return node;
	}

}