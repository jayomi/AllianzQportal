package com.allianz.qportalapp.model;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;

public class TestImageRead {
	
	public static void main(String[] args) throws IOException {
		
		File folder = new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages\\1_1");
		File[] listOfFiles = folder.listFiles();
		List<String> pathList=new ArrayList<String>();
		
		for (File file : listOfFiles) {
		    if (file.isFile()) {
		    	
		        System.out.println("file name"+file.getName());
		        System.out.println("Absolute Path: "+file.getAbsolutePath());
		        String absoultePath=file.getAbsolutePath();
		        String imgName=absoultePath.substring(absoultePath.lastIndexOf("\\")+1);
		       // pathList.add(file.getAbsolutePath());
		        pathList.add(imgName);
		        
		        System.out.println("imgName: "+imgName);
		        // System.out.println("Canonical Path"+file.getCanonicalPath());
		        
		    }
		}
		System.out.println("pathList: "+pathList.toString());
		String str=pathList.toString();
		String img[]=str.replaceAll("\\[", "").replaceAll("\\]","").split(",");
		for(int k=0;k<img.length;k++){
			System.out.println("img: "+img[k]);
		}
		
		//copy file from one directory to another directory -----------
		File dest = new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages\\1_1");
		File source = new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\qportal_img");
		try {
		    FileUtils.copyDirectory(dest, source);
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		//list sub directoty------------
		File file = new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages");
		String[] names = file.list();

		for(String name : names)
		{
		    if (new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages\\" + name).isDirectory())
		    {
		        System.out.println("sub directory: "+name);
		    }
		}
		
		
		
		
	}
	
	

}
