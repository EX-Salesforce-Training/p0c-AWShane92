@isTest
public class P0B_Test {
    
    @isTest
    public static void nFibonnaciTest()
    {
        Integer fib = P0B.nFibonnaci(0);
        System.assertEquals(0, fib);
        
        fib = P0B.nFibonnaci(1);
        System.assertEquals(1, fib);
        
        fib = P0B.nFibonnaci(2);
        System.assertEquals(1, fib);
        
        fib = P0B.nFibonnaci(10);
        System.assertEquals(55, fib);
    }
    
    @isTest
    public static void sortArrayTest()
    {
        Integer[] testArray = P0B.sortArray(new List<Integer>{2,4,5,1,3,1});
        System.assertEquals(new List<Integer>{1,1,2,3,4,5},testArray);
        
        testArray = P0B.sortArray(new List<Integer>{5,4,3,2,1});
        System.assertEquals(new List<Integer>{1,2,3,4,5}, testArray);
    }
    
    @isTest
    public static void nFactorialTest()
    {
       	Integer factorial = P0B.nFactorial(0);
       	System.assertEquals(1, factorial);
        
        factorial = P0B.nFactorial(1);
        System.assertEquals(1, factorial);
        
        factorial = P0B.nFactorial(3);
        System.assertEquals(6, factorial);    
    }
    
    @isTest
    public static void rotateLeftNTimesTest()
    {
        Integer[] testArray = P0B.rotateLeftNTimes(new List<Integer>{1,2,3,4,5}, 1);
        System.assertEquals(new List<Integer>{2,3,4,5,1}, testArray);
        
        testArray = P0B.rotateLeftNTimes(new List<Integer>{1,2,3,4,5}, 6);
        System.assertEquals(new List<Integer>{2,3,4,5,1}, testArray);
        
        testArray = P0B.rotateLeftNTimes(new List<Integer>{1,2,3,4,5}, 3);
        System.assertEquals(new List<Integer>{4,5,1,2,3}, testArray);       
    }
    
    @isTest
    public static void bracketsAreBalancedTest()
    {
        Boolean isBalanced = P0B.bracketsAreBalanced('()');
        System.assertEquals(true, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('()()');
        System.assertEquals(true, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('(())');
        System.assertEquals(true, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('({[]})');
        System.assertEquals(true, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('(');
        System.assertEquals(false, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced(')');
        System.assertEquals(false, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('(()');
        System.assertEquals(false, isBalanced);
        
        isBalanced = P0B.bracketsAreBalanced('([)]');
        System.assertEquals(false, isBalanced);
    }
    
    @isTest
    public static void isOddTest()
    {
        Boolean isOdd = P0B.isOdd(10);
        System.assertEquals(false, isOdd);
        
        isOdd = P0B.isOdd(9);
        System.assertEquals(true, isOdd);
    }
    @isTest
    public static void updateAccountSizeTest()
    {
        List<Account> accounts = new List<Account>();
        Integer ne = 500;
        
        for(Integer i = 1; i <= 100; i++)
        {
            if(i == 33 || i == 66)
            {
                ne*=10;
            }           
            accounts.add(new Account(Name = 'TestAccount: ' + i, NumberOfEmployees = ne));
        }
        insert accounts;
        
        Test.startTest();
        //Verifying that before the code is run that all account's size is null
        for(Account acc: accounts) System.assertEquals(null, acc.Size__c);
        //Running code;
        P0B.updateAccountSize();
        Test.stopTest();
        
        for(Account acc: [SELECT Size__c, NumberOfEmployees FROM Account]) 
        {
            if(1 <= acc.NumberOfEmployees && acc.NumberOfEmployees <= 1000) System.assertEquals('Small', acc.Size__c);
            
            if(1001 <= acc.NumberOfEmployees && acc.NumberOfEmployees <= 10000) System.assertEquals('Medium', acc.Size__c);
            
            if(10000 < acc.NumberOfEmployees) System.assertEquals('Large', acc.Size__c);
        }            
    }
    @isTest
    public static void updateCALeadsTest()
    {
        List<Lead> leads = new List<Lead>();
        String st = 'CA';
        
        for(Integer i = 1; i <= 100; i++)
        {
            if(i == 51) st = 'NY';
            
            leads.add(new Lead(LastName = 'TestCALead: ' + i, Company = 'Revature',
                               Status = 'Open - Not Contacted', State = st));
        }
        insert leads;
        
        Test.startTest();
        P0B.updateCALeads();
        Test.stopTest();
        
        String leadStatus = 'Closed - Not Converted';
        String description = 'We are no longer doing business in California';
       
        for(Lead l: [SELECT Name, Status, Description FROM Lead WHERE State LIKE 'CA'])
        {
            System.assertEquals(leadStatus, l.Status);
            System.assertEquals(description, l.Description);
        }
        System.assertEquals(50, [SELECT count() FROM Lead WHERE State LIKE 'CA']);
    }
    @isTest
    public static void closePastDueOpportunitiesTest()
    {
        List<Opportunity> opportunities = new List<Opportunity>();
        Integer year = 2019;
        
        for(Integer i = 1; i <=100; i++)
        {
            if(i == 51) year++;
            
            opportunities.add(new Opportunity(Name = 'TestOpportunity: ' + i, 
                                              StageName = 'Needs Analysis', CloseDate = Date.newInstance(year, 12, 31)));
            
        }
        insert opportunities;
        
        Test.startTest();
        P0B.closePastDueOpportunities();
        Test.stopTest();
        
        String stage = 'Closed Lost';
        Opportunity[] updatedOpportunities = [SELECT CloseDate, StageName FROM Opportunity];
        
        for(Opportunity o: updatedOpportunities)
        {
            if(o.CloseDate < Date.today())
            {
                System.assertEquals(stage, o.StageName);
            }
            else
            {
                System.assertNotEquals(stage, o.StageName);
            }
        }
    }
}