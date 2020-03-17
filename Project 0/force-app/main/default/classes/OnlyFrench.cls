public with sharing class OnlyFrench 
{
    public OnlyFrench() 
    {

    }

    public static void toFrench()
    {
        List<Contact> contactIds = [SELECT Id FROM Contact]; 

        for(Contact c : contactIds)
        {
            if(c.Languages__c != 'Spanish')
            {
                c.Languages__c = 'French';
            }
        }

        try
        {
            update contactIds;
        }
        catch(DMLException e)
        {
           System.debug('An unexpected error has occured ' + e.getMessage());
        }
    }        
}