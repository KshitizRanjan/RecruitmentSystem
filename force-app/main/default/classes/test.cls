public class test {
    
    public static void pincode(String pc){
        List<string> strList = pc.trim().split(',');
        System.debug(strList);
        
        
        
        for(String str: strList){
            if(str.length()!=6 || !str.isNumeric())
            
            System.debug(str);
        }
        
        
        
        }
    
    

}