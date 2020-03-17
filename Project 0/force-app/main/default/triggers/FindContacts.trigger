trigger FindContacts on Account (after insert) 
{
	for(Account acc : Trigger.new)
    {
       if(acc.BillingStreet != null) RelateContactToAccount.relateContact(acc); 
    }
}