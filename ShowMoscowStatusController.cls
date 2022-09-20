public class ShowMoscowStatusController {
        @AuraEnabled
        public static MoscowWrapper getStatus(ID projectId){
            List<featureboard__Feature__c> musthaveLst = new List<featureboard__Feature__c>();
            List<featureboard__Feature__c> shouldhaveLst = new List<featureboard__Feature__c>();
            List<featureboard__Feature__c> couldhaveLst = new List<featureboard__Feature__c>();
            List<featureboard__Feature__c> wonthaveLst = new List<featureboard__Feature__c>();
            List<featureboard__Feature__c> tbdLst = new List<featureboard__Feature__c>();
            List<featureboard__Process_Flow_Segment__c> pfsLst = new List<featureboard__Process_Flow_Segment__c>();
            
            //System.debug(LoggingLevel.INFO,projectId);
            
            List<featureboard__Feature__c> featureList =[Select Id,Name,featureboard__MoSCoW_Priority__c,featureboard__Project__c, featureboard__Process_Flow_Segment__r.Name From featureboard__Feature__c where featureboard__Project__c =: projectId ];
            
            //System.debug(LoggingLevel.INFO,featureList.size());
            
            if(featureList!= null && featureList.size()>0)
            {
                for(featureboard__Feature__c c : featureList)
                {
                    if(c.featureboard__MoSCoW_Priority__c == 'M'){
                        musthaveLst.add(c);
                        if(!pfsLst.contains(c.featureboard__Process_Flow_Segment__r))
                        pfsLst.add(c.featureboard__Process_Flow_Segment__r);
                    }
                    else if(c.featureboard__MoSCoW_Priority__c == 'S'){
                        shouldhaveLst.add(c);
                        if(!pfsLst.contains(c.featureboard__Process_Flow_Segment__r))
                         pfsLst.add(c.featureboard__Process_Flow_Segment__r);
                    }
                    else if(c.featureboard__MoSCoW_Priority__c == 'C'){
                        couldhaveLst.add(c);
                        if(!pfsLst.contains(c.featureboard__Process_Flow_Segment__r))
                         pfsLst.add(c.featureboard__Process_Flow_Segment__r);
                    }
                    else if(c.featureboard__MoSCoW_Priority__c == 'W'){
                        wonthaveLst.add(c);
                        if(!pfsLst.contains(c.featureboard__Process_Flow_Segment__r))
                         pfsLst.add(c.featureboard__Process_Flow_Segment__r);
                    }
                    else if(c.featureboard__MoSCoW_Priority__c == 'TBD'){
                        tbdLst.add(c);
                        if(!pfsLst.contains(c.featureboard__Process_Flow_Segment__r))
                         pfsLst.add(c.featureboard__Process_Flow_Segment__r);
                    }
                }
                MoscowWrapper mw = new MoscowWrapper();
                mw.musthaveList = musthaveLst;
                mw.shouldhaveList = shouldhaveLst;
                mw.couldhaveList = couldhaveLst;
                mw.wonthaveList = wonthaveLst;
                mw.tbdList = tbdLst;
                mw.totalCount = featureList.size();
                mw.pfsList = pfsLst;
                //System.debug(LoggingLevel.Info, mw);
                
                return mw;
            }
            return null;
        }
        
        @AuraEnabled
        public static MoscowWrapper UpdateMoscow(Id featureID, String Status)
        {
            featureboard__Feature__c feature = new featureboard__Feature__c();
            feature.Id= featureID;
            feature.featureboard__MoSCoW_Priority__c = status;
            update feature;
            
            featureboard__Feature__c feature1 = [Select Id,featureboard__Project__c from featureboard__Feature__c where Id =: featureID Limit 1];
            //System.debug(LoggingLevel.INFO, feature1);
            //System.debug(LoggingLevel.INFO, feature1.featureboard__Project__c);
            return getStatus(feature1.featureboard__Project__c);
        }
        
        public class MoscowWrapper
        {
            @AuraEnabled
            public List<featureboard__Feature__c> musthaveList;
            @AuraEnabled
            public List<featureboard__Feature__c> shouldhaveList;
            @AuraEnabled
            public List<featureboard__Feature__c> couldhaveList;
            @AuraEnabled
            public List<featureboard__Feature__c> wonthaveList;
            @AuraEnabled
            public List<featureboard__Feature__c> tbdList;
            @AuraEnabled
            public Integer totalCount;
            @AuraEnabled
            public List<featureboard__Process_Flow_Segment__c> pfsList;
        }
    }