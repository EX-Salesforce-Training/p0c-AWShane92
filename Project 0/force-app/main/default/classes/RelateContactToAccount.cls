public class RelateContactToAccount 
{
	public static void relateAccount(Contact con)
    {        
        if(con.MailingStreet == null) return;        
        else
        {
            try
            {
            	Account acc = [SELECT Id, Name, BillingAddress FROM Account
                   WHERE (BillingStreet =: con.MailingStreet AND BillingCity =: con.MailingCity)
                   AND (BillingState =: con.MailingState) LIMIT 1]; 
                
                con.AccountId = acc.Id;
            }
            catch(System.QueryException e)
            {
                return;
            }                        
        }
    }

    public static void relateContact(Account acc)
    {
        Contact con;
        
        try
        {
            con = [SELECT AccountId FROM Contact
                   WHERE (MailingStreet =:acc.BillingStreet AND MailingCity =: acc.BillingCity) 
                   AND (MailingState =: acc.BillingState) LIMIT 1];
            
            con.AccountId = acc.Id;
            update con;
        }
        catch(System.QueryException e)
        {
            return;
        }
    }
}