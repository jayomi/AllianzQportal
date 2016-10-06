package com.allianz.qportalapp.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class UpdateImageImpl {
	
	public String setImagePath(File folder,String formId,String segmentId, String questionId){
		
		//String filePath=getServletContext().getRealPath("qportal_img");
		//File folder = new File("G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages\\"+segmentId+"_"+qid);
		
		String predefineValues="";
		
		File[] listOfFiles = folder.listFiles();
		List<String> pathList=new ArrayList<String>();
		
		for (File file : listOfFiles) {
		    if (file.isFile()) {
		    	
		        //System.out.println("file name"+file.getName());
		       // System.out.println("Absolute Path: "+file.getAbsolutePath());
		        String absolutePath=file.getAbsolutePath();
		        System.out.println("Absolute Path: update Image Impl"+absolutePath);
		    	String imgName=absolutePath.substring(absolutePath.lastIndexOf("\\")+1);
			      
		    	System.out.println("image Name: "+ imgName);
			        pathList.add(imgName);
		    	
		       // pathList.add(file.getAbsolutePath());
		       // System.out.println("Canonical Path"+file.getCanonicalPath());
		    }
		    
		}

		 predefineValues = pathList.toString();
		 
		 //change imge path of the predefine_answer table
		 
		 String fileArray[]=predefineValues.replaceAll("\\[", "").replaceAll("\\]","").replaceAll("\\s+","").split(",");
		 List<String> imageList=new ArrayList<String>();
			for(int k=0;k<fileArray.length;k++){
				System.out.println("img: "+fileArray[k]);
				String path="app\\qportal_img\\"+formId+"_"+segmentId+"_"+questionId+"\\"+fileArray[k];
				imageList.add(path);				
				
			}
			predefineValues=imageList.toString();
			predefineValues = predefineValues.replace("\\", "/");
		 
			return predefineValues;
		
		//predefineValues = predefineValues.replace("\\", "/");
		//System.out.println("inside image: prevalues.... "+predefineValues );
	}

}
