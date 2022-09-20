@isTest
public class ShowMoscowStatusControllerTest {
    
    @TestSetup
    public static void makeData()
    {
        //Insert Project
        featureboard__Project__c testProject = new featureboard__Project__c(Name = 'Test Project 01', featureboard__Summary__c='Test Project 01', featureboard__Planned_Start_Date__c = System.today(),featureboard__Template__c=false);
        insert testProject;
        
        featureboard__Project__c testProject02 = new featureboard__Project__c(Name = 'Test Project 02', featureboard__Summary__c='Test Project 02', featureboard__Planned_Start_Date__c = System.today(),featureboard__Template__c=false);
        insert testProject02;
        
        //Insert PFS
        featureboard__Process_Flow_Segment__c testPFS = new featureboard__Process_Flow_Segment__c(Name='Test Process Flow Segment 01',featureboard__Project__c=testProject.Id,featureboard__Order__c=1);
        insert testPFS;
        
        //Insert Features
        List<featureboard__Feature__c> featuresList = new List<featureboard__Feature__c>();
        featureboard__Feature__c testFeature_TBD = new featureboard__Feature__c(Name = 'Test Feature TBD', featureboard__Process_Flow_Segment__c = testPFS.Id, featureboard__MoSCoW_Priority__c='TBD', featureboard__Project__c = testProject.Id,featureboard__Status__c='New');
        featureboard__Feature__c testFeature_S = new featureboard__Feature__c(Name = 'Test Feature Should Have', featureboard__Process_Flow_Segment__c = testPFS.Id, featureboard__MoSCoW_Priority__c='S', featureboard__Project__c = testProject.Id,featureboard__Status__c='New');
        featureboard__Feature__c testFeature_C = new featureboard__Feature__c(Name = 'Test Feature Could Have', featureboard__Process_Flow_Segment__c = testPFS.Id, featureboard__MoSCoW_Priority__c='C', featureboard__Project__c = testProject.Id,featureboard__Status__c='New');
        featureboard__Feature__c testFeature_M = new featureboard__Feature__c(Name = 'Test Feature Must Have', featureboard__Process_Flow_Segment__c = testPFS.Id, featureboard__MoSCoW_Priority__c='M', featureboard__Project__c = testProject.Id,featureboard__Status__c='New');
        featureboard__Feature__c testFeature_W = new featureboard__Feature__c(Name = 'Test Feature Wont Have', featureboard__Process_Flow_Segment__c = testPFS.Id, featureboard__MoSCoW_Priority__c='W', featureboard__Project__c = testProject.Id,featureboard__Status__c='New');
        
        featuresList.add(testFeature_TBD);
        featuresList.add(testFeature_S);
        featuresList.add(testFeature_C);
        featuresList.add(testFeature_M);
        featuresList.add(testFeature_W);
        
        insert featuresList;
    }
    
    @isTest
    public static void getStatusNotNullTest()
    {
        featureboard__Project__c testproj = [Select Id,Name from featureboard__Project__c where Name='Test Project 01' LIMIT 1];
        ShowMoscowStatusController.MoscowWrapper mw = ShowMoscowStatusController.getStatus(testproj.Id);
        System.assertNotEquals(null,mw);
    }
    
    @isTest
    public static void getStatusNullTest()
    {
        featureboard__Project__c testproj = [Select Id,Name from featureboard__Project__c where Name='Test Project 02' LIMIT 1];
        ShowMoscowStatusController.MoscowWrapper mw = ShowMoscowStatusController.getStatus(testproj.Id);
        System.assertEquals(null,mw);
    }
    
    @isTest
    public static void UpdateMoscowTest()
    {
        featureboard__Feature__c feature = [Select Id,featureboard__Project__c from featureboard__Feature__c where Name='Test Feature TBD' LIMIT 1];
        ShowMoscowStatusController.MoscowWrapper mw = ShowMoscowStatusController.UpdateMoscow(feature.Id, 'S');
        System.assertNotEquals(null,mw);
    }
}