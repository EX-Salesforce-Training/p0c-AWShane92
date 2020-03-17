/////////////////////////////////////////////////////////////////
//
// Name: Project 0 Bravo
// Author: Akeem Shane (awshane420@gmail.com)
// Date: 02/24/2020
// Description: Series of apex methods to demonstrate
// basic understanding of coding concepts.
//
/////////////////////////////////////////////////////////////////

public class P0B {
    
    // Returns the nth number in the Fibonnaci sequence using recursion
	public static Integer nFibonnaci(Integer n)
    {
        if(n == 0) return 0;
        if(n == 1) return 1;
        
        return nFibonnaci(n - 1) + nFibonnaci(n - 2); //recursive algorithm.
    }
    
    //Returns a sorted integer array/list using bubblesort
    public static Integer[] sortArray(Integer[] intList)
    {
        Integer temp = 0;
        Boolean sorted = false;
        
        //Sorting Algorithm.
        while(!sorted)
        {
            sorted = true; //assuming that the list is sorted.
            for(Integer i = 0; i < intList.size() - 1; i++)
        	{
           		if(intList[i] > intList[i + 1])
            	{
                	temp = intList[i];
                	intList[i] = intList[i + 1];
                	intList[i + 1] = temp;
                    sorted = false; //assumes the list is still unsorted.
            	}
        	}          
        }
        return intList;
    }
    
    //Returns the factorial of the integer using recursion.
    public static Integer nFactorial(Integer n)
    {
        if(n == 0 || n == 1) return 1; //Base case.
        
        return n * nFactorial(n - 1); //recursive algorithm.
    }
    
    //Shifts the elements in an Array left by the specified number of times. 
    public static Integer[] rotateLeftNTimes(Integer[] iArray, Integer n)
    {
        Integer remainder, length = iArray.size();
        Integer[] shiftedArray = new Integer[length];
        
        /* If n is greater than the lenght of the array, sets n to the difference.
         * This is allowed because if we shift the elements of the array by the size of the
         * array then all the elements would be in the same position. Thus the remainder 
         * will be the required shifts necessary. 
		 */
        while(n >= length) n-= length;
        //If the elements shifted to left is 0 return the array.
        if(n == 0) return iArray;
                    
        for(Integer i = 0; i < length; i++)
        {
            /* Determines if the element to be shifted left is out-of-bounds 
			 * and if so then count from the right the new position. Else insert
			 * into the new array normally.
			 */
           if(i - n < 0)
           {
               shiftedArray[length - (n - i)] = iArray[i]; 
           }
           else
           {
            	shiftedArray[i - n] = iArray[i];    
           }
        }      
        return shiftedArray;
    }
    /* Determines if a string of brackets are balanced or not. 
     */
    public static Boolean bracketsAreBalanced(String s)
    {
        //String of an odd length isn't a balanced string. 
        if(isOdd(s.length())) return false;
        //These indexers are used to the track the count of the brackets from the center.  
        Integer parenthesesIndexer, curlyIndexer, squareIndexer;
        parenthesesIndexer = curlyIndexer = squareIndexer = s.length()/2;
        
        Boolean isBalanced;
        
        for(Integer i = s.length()/2 - 1; i > -1; i--)
        {
            switch on s.charAt(i)
            {
                when 40, 41
                {    
                    if(s.charAt(i) == 40)
                    {
                      	//In the case the char is '(' find the closing bracket and determine if it's balanced.
                    	parenthesesIndexer = s.indexOfChar(41,parenthesesIndexer);
                    	isBalanced = parenthesesIndexer  > -1 ? isOdd(parenthesesIndexer - i): false;
                    	parenthesesIndexer++;  
                    }
                    else
                    {
                        //In the case the char is ')' find the opening bracket and determine if it's balanced.
                    	parenthesesIndexer = s.indexOfChar(40,parenthesesIndexer);
                    	isBalanced = parenthesesIndexer  > -1 ? isOdd(parenthesesIndexer - i): false;
                    	parenthesesIndexer++; 
                    }                   
                }
                when 91, 93
                {	                   
                    if(s.charAt(i) == 91)
                    {
                    	//In the case the char is '[' find the closing bracket and determine if it's balanced. 
                    	squareIndexer = s.indexOfChar(93,squareIndexer);
                    	isBalanced = squareIndexer > -1 ? isOdd(squareIndexer - i): false;
                    	squareIndexer++;  
                    }
                    else
                    {
                        //In the case the char is ']' find the opening bracket and determine if it's balanced. 
                    	squareIndexer = s.indexOfChar(91,squareIndexer);
                    	isBalanced = squareIndexer > -1 ? isOdd(squareIndexer - i): false;
                    	squareIndexer++; 
                    }                   
                }
                when 123, 125
                {
                    if(s.charAt(i) == 123)
                    {
                    	//In the case the char is '{' find the closing bracket and determine if it's balanced.
                    	curlyIndexer = s.indexOfChar(125,curlyIndexer);
                    	isBalanced = curlyIndexer > -1 ? isOdd(curlyIndexer - i): false;
                    	curlyIndexer++;
                    }
                    else
                    {
                        //In the case the char is '}' find the opening bracket and determine if it's balanced.
                    	curlyIndexer = s.indexOfChar(123,curlyIndexer);
                    	isBalanced = curlyIndexer > -1 ? isOdd(curlyIndexer - i): false;
                    	curlyIndexer++;                        
                    }    
                }
                when else { continue; }
            }
        }       
        return isBalanced;
    }
	//This method is used for the the brackertsAreBalanced method, returns true if an odd number is passed.
    public static Boolean isOdd(Integer n)
    {
        Decimal r = (Decimal) n; 
        n /= 2; 
        r /= (Decimal) 2;
        
        if(n == r) return false; //If both number being returned are integers then the number is an even number.
       	else return true; 
    }
    //This method queries all Accounts and sets the Size__c field to either 
    //Small, Medium or Large depending on the NumberOfEmployees field.
    public static void updateAccountSize()
    {	
        //Get the Name, Size__c, NumberOfEmployees from all accounts.
		List<Account> accounts = [SELECT Name, Size__c,NumberOfEmployees FROM Account];
        //Iterate thourgh the retrieved accounts and update the Size__c field.
        for(Account acc : accounts)
        {
            if(1 <= acc.NumberOfEmployees && acc.NumberOfEmployees <= 1000) acc.Size__c = 'Small';
            
            if(1001 <= acc.NumberOfEmployees && acc.NumberOfEmployees <= 10000) acc.Size__c = 'Medium';
            
            if(10000 < acc.NumberOfEmployees) acc.Size__c = 'Large';            					            
        }     
		update accounts;
    }
    //This method queries the database for all Leads and
    //if any Lead has an address in California it updates that 
    //lead to 'Closed - Not Converted' and adds the description 
    //'We are no longer doing business in California.'
    public static void updateCALeads()
    {	
        /*** Initial attempt at using SOSL did return the accurate results, please review ***/
        //List<List<sObject>> caQuery = [FIND 'CA' IN ALL FIELDS RETURNING Lead(Name, State, Status, Description)];
    	//Lead[] leads  = (Lead[]) caQuery[0];
        List<Lead> leads = [SELECT Name, State, Status, Description FROM Lead];
                
        for(Lead l : Leads)
        {
            //If the state is equal to CA the update the status and description of the lead.
        	if(l.State == 'CA')
            {
                l.Status = 'Closed - Not Converted';
                l.Description = 'We are no longer doing business in California';
            }            
        }         
        update leads;
    }
    //This method queries the database for all Opportunities that has a
    //Stage that doesn't equal 'Closed Won' and is pass its Closed Date
    //It then updates those Opportunities Stage to 'Closed Lost.'
    public static void closePastDueOpportunities( ) 
    {
        //Querying of the database for all Opportunities with a StageName that doesn't equal 
        //'Closed Won' and is pass its Closed Date. 
        List<Opportunity> opportunities = [SELECT CloseDate, StageName FROM Opportunity 
                                           WHERE StageName != 'Closed Won' AND CloseDate < :Date.today()];
        
        for(Opportunity opp: opportunities)
        { 
          opp.StageName = 'Closed Lost';
        }
        update opportunities;
	}
}