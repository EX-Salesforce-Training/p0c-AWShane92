/* 	This trigger while be invoked when ever a new contact is made.
	It'll check the contact and see if it has any possible matching
	Accounts. If it finds an Account it'll add the Account to that Contact, 
	unless the new Contact already has an Account associated with it.
*/
trigger FindAccounts on Contact (before insert) 
{
	for(Contact con: Trigger.new)
    {
        if(con.AccountId == null) RelateContactToAccount.relateAccount(con);
    }
}