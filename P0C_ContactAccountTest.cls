@isTest
public class P0C_ContactAccountTest 
{
    @isTest
	static void relateAccountTest()
    {
        Account relatedAccount = new Account(Name = 'Related Test Account', BillingStreet = '2264 Astoria Circle',
                                            BillingCity = 'Herndon', BillingState = 'VA', BillingCountry = 'USA');
        
        Contact relatedContact = new Contact(LastName = 'Related Test Contact', MailingStreet = '2264 Astoria Circle',
                                         MailingCity = 'Herndon', MailingState = 'VA', MailingCountry = 'USA');
        
        Contact unrelatedContact = new Contact(LastName = 'Unrelated Test Contact', MailingStreet = '2265 Astoria Circle',
                                              MailingCity = 'Herndon', MailingState = 'VA', MailingCountry = 'United States');
                
        insert relatedAccount;
        insert relatedContact;
        insert unrelatedContact;
   
        Test.startTest();
        relatedContact = [SELECT Name, Account.id FROM Contact WHERE id =: relatedContact.Id];
        unrelatedContact = [SELECT Name, Account.id FROM Contact WHERE id =: unrelatedContact.Id];
        Test.stopTest();
        
        System.assertEquals(relatedAccount.Id, relatedContact.AccountId);
        System.assertNotEquals(relatedAccount.Id, unrelatedContact.AccountId); 
    }
}