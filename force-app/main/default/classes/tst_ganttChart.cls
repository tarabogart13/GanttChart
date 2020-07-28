@isTest
public with sharing class tst_ganttChart {
    @isTest
    static void ganttChart_getChartData() {
        Date d = Date.today();
        DateTime dt = DateTime.now();

        Resource__c r = new Resource__c(
            Name='Test Resource',
            Default_Role__c='Test Role');
        insert r;

        Allocation__c a = new Allocation__c(
            Resource__c = r.Id,
            Start_Date__c = d,
            End_Date__c = d);
        insert a;

        Test.startTest();
        Map<String, Object> chartData = ganttChart.getChartData(
            String.valueOf(dt.getTime()),
            String.valueOf(dt.getTime()),
            1,
            '');
        Test.stopTest();


        System.assert(chartData.containsKey('resources'));
        List<Object> resources = (List<Object>)chartData.get('resources');
        System.assertEquals(1, resources.size());
        Map<String, Object> resourceMap = (Map<String, Object>)resources.get(0);
        System.assertEquals(r.Id, (String)resourceMap.get('Id'));
    }

    @isTest
    static void ganttChart_getChartData_withFilters() {
        Date d = Date.today();
        DateTime dt = DateTime.now();

        Resource__c r = new Resource__c(
            Name='Test Resource',
            Default_Role__c='Test Role');
        insert r;

        Allocation__c a = new Allocation__c(
            Resource__c = r.Id,
            Effort__c = 'High',
            Status__c = 'Active',
            Start_Date__c = d,
            End_Date__c = d);
        insert a;

        Test.startTest();
        Map<String, Object> chartData = ganttChart.getChartData(
            String.valueOf(dt.getTime()),
            String.valueOf(dt.getTime()),
            1,
            a.Status__c);
        Test.stopTest();

        System.assert(chartData.containsKey('resources'));
        List<Object> resources = (List<Object>)chartData.get('resources');
        System.assertEquals(1, resources.size());
        Map<String, Object> resourceMap = (Map<String, Object>)resources.get(0);
        System.assertEquals(r.Id, (String)resourceMap.get('Id'));

    }

    @isTest
    static void ganttChart_getResources() {
        Resource__c r = new Resource__c(
            Name='Test Resource',
            Default_Role__c='Test Role');
        insert r;

        Test.startTest();
        List<Object> resources = ganttChart.getResources();
        Test.stopTest();

        System.assertEquals(1, resources.size());
        System.assertEquals(r.Id, ((Map<String, Object>)resources.get(0)).get('Id'));
        System.assertEquals(r.Default_Role__c, ((Map<String, Object>)resources.get(0)).get('Default_Role__c'));
    }
}
