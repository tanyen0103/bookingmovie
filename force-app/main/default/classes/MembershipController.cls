public with sharing class MembershipController {
@AuraEnabled(cacheable=true)
    public static Membership__c getMemberships() {
        String currentUserId = UserInfo.getUserId();
        List<Membership__c> memberships = [ SELECT Id, Name, Rank__c,Address__c,Email__c 
                                            FROM Membership__c 
                                            WHERE User__c = :currentUserId
                                            LIMIT 1];
        if (memberships != NULL && !memberships.isEmpty()) {
            return memberships.get(0);
        }
        return null;
    }
}