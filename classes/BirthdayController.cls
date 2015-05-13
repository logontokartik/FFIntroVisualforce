public class BirthdayController {

    public List<Contact> contacts {get;set;}
    public String contactid {get;set;}
    
    public BirthdayController() {
        contacts = new List<Contact>();
        contacts = [Select Id, Name, BirthDate, MailingStreet, MailingCity, Email, Phone, Image__c,Image_URL__c from Contact];
    }
    
    @RemoteAction
    public static void sendGreeting(String conId, String greeting){
        Contact con = [Select Id, Name, Email from Contact where id = :conId];
        
        if(con.email == null){
            return;
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {con.Email}; 
        
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName(UserInfo.getName());
        
        // Specify the subject line for your email address.
        mail.setSubject('Happy Birthday');
        
        
        // Specify the text content of the email.
        mail.setPlainTextBody(greeting);
        
        mail.setHtmlBody(greeting);
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
    
}