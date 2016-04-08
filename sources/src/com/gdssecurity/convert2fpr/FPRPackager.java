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
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public class FPRPackager {

	private static final String BASE_ZIP = "/com/gdssecurity/convert2fpr/output/out.zip";
	private static final Integer BUFFER_SIZE = 2048;

	protected void addFilesToExistingZip(File auditFile, String filename) throws IOException  {

		File outFPRFile = new File(filename);

		byte[] buf = new byte[BUFFER_SIZE];
		ZipInputStream baseZipFile = new ZipInputStream(getClass().getResourceAsStream(BASE_ZIP));
		ZipOutputStream outZipFile = null;
		InputStream auditFileStream = null;
		try{
			outZipFile = new ZipOutputStream(new FileOutputStream(outFPRFile));
			ZipEntry entry = baseZipFile.getNextEntry();
			while (entry != null) {
				String name = entry.getName();
				outZipFile.putNextEntry(new ZipEntry(name));
				int len;
				while ((len = baseZipFile.read(buf)) > 0) {
					outZipFile.write(buf, 0, len);
				}
				entry = baseZipFile.getNextEntry();
			}
			baseZipFile.close();
			auditFileStream = new FileInputStream(auditFile);
			outZipFile.putNextEntry(new ZipEntry(auditFile.getName()));
			int len;
			while ((len = auditFileStream.read(buf)) > 0) {
				outZipFile.write(buf, 0, len);
			}
			outZipFile.closeEntry();
			auditFileStream.close();
			outZipFile.close();
			baseZipFile.close();
			if(auditFile!=null)
				auditFile.delete();
		
		}
		catch(IOException e){
			e.printStackTrace();
		} finally{
			auditFileStream.close();
			outZipFile.close();
			baseZipFile.close();
		}
	}
} 
