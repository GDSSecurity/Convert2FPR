# Convert2FPR

The application is packaged in a single runnable jar and can be used as follows:
 
$ java -­‐jar convert2FPR.jar findbugs report.xml
 
To supply a custom messages.xml file, use as follows:
 
$ java -­‐jar convert2FPR.jar findbugs messages.xml report.xml
 
The output file, in both cases is ./report.fpr .
 
The first parameter (findbugs) represents the input format and maps the correspondent XSL (see below):
 
static{
    formats.put("findbugs","com/gds/convert2fpr/findbugs/fvdl.xsl");
}
 
In order to extend the tool to support further input formats, we need to include a new XSL file and add just one line to the above code for each added XSL stylesheet.