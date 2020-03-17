@isTest
public class OnlyFrenchTest 
{
    @testSetup
    public static void setup()
    {
        List<Contact> testContacts = new List<Contact>();
        List<Account> testAccounts = new List<Account>();
        
        for(Integer i = 0; i < 50; i++)
        {
            testContacts.add(new Contact(LastName = ('TestContact ' + i)));
            testAccounts.add(new Account(Name = ('TestAccount ' + i), SLAExpirationDate__c = Date.newInstance(1960 + i, 1, 1)));
        }
        
        insert testContacts;
        insert testAccounts;
    }
    @isTest
    public static void toFrenchTest()
    {
       	OnlyFrench.toFrench();
       
        for(Contact c: [SELECT Id, Languages__c FROM Contact])
        {
            if(c.Languages__c != 'Spanish') System.assertEquals('French', c.Languages__c);            
        }
    }
    @isTest
    public static void updateAccountExpirationDateTest()
    {
     	OnlyFrench.updateAccountExpirationDate();
        Date t = Date.today();
        
        for(Account a: [SELECT Id, SLAExpirationDate__c FROM Account])
        {
            if(a.SLAExpirationDate__c.year() <= t.year())
            {
               //System.assertEquals(expected, actual);   
            }
        }
    }
}