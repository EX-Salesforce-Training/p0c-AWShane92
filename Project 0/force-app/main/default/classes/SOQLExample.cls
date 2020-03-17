public class SOQLExample 
{
	public static List<Account> getAccounts()
    {
        //Parent-to-Child relationships
        List<Account> accounts = [SELECT Id, (SELECT LastName FROM Contacts) FROM Account WHERE Name='Edge Communications'];
        //Child-to-Parent relationship  
        List<Contact> contacts = [SELECT Id, Account.Name FROM Contact];
        
        return accounts;
    }
    
    public static List<Opportunity> wildCard()
    {
        //The % is a wildcard in SOQL/SOSL that represents any number of characters
        //from 1 to 1000.
        //The _ is a wildcard in SOQL/SOSL that represents only one character.
        //The LIKE keyword is used to compare partial strings and supports wildcard operators.
        //The IN keyword is used to compare a value to a list of values.
        //List<Account> accList = [SELECT Name FROM Account WHERE Name LIKE 'Edge%'];
        //List<Opportunity> accList = [SELECT Name FROM Opportunity WHERE Type IN ('Existing Business','New Business')];
        //AND, OR, NOT
        //List<Opportunity> accList = [SELECT Amount FROM Opportunity WHERE Type ='Existing Business' AND Account.Name LIKE'Edge%'];
		//List<Opportunity> accList = [SELECT Amount FROM Opportunity WHERE Type ='Existing Business' OR Account.Name LIKE 'Edge%'];
		List<Opportunity> accList = [SELECT Amount FROM Opportunity WHERE Account.Name LIKE 'Edge%' AND (NOT Type = 'Existing Business')];


        return accList;
    }
    
    public static List<AggregateResult> dateThings()
    {	//Allows us to filter or group by specific dates
        //CALENDAR_MONTH, CALENDAR_QUARTER, CALENDAR_YEAR, FISCAL_MONTH, FISCAL_QUARTER, DAY_IN_WEEK, DAY_IN_MONTH, DAY_IN_YEAR
        List<AggregateResult> aggList = [SELECT DAY_IN_MONTH(CreatedDate), COUNT(Name) FROM Account GROUP BY DAY_IN_MONTH(CreatedDate)];
        
        return aggList;
    }
  
}