public with sharing class MovieController {
    @AuraEnabled(cacheable=true scope='global')
    public static Movie__c[] getMovies() {
        return [
            SELECT
                Id,
                Title__c,
                Description__c,
                Genre__c,
                picture_URL__c,
                video_URL__c,
                Status__c,
                Duration__c
            FROM Movie__c
            WITH SECURITY_ENFORCED
            ORDER BY Title__c
            LIMIT 50
        ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static Movie__c[] searchMovies(String searchKey) {
        // Return all bears when no search term
        searchKey = searchKey.trim();
        if (searchKey == '') {
            return getMovies();
        }
        // Prepare query paramters
        searchKey = '%' + searchKey + '%';
        // Execute search query
        return [
            SELECT
                Id,
                Title__c,
                Description__c,
                Genre__c,
                picture_URL__c,
                video_URL__c,
                Status__c,
                Duration__c
            FROM Movie__c
            WHERE Title__c LIKE :searchKey
            WITH SECURITY_ENFORCED
            ORDER BY Title__c
            LIMIT 50
        ];
    }

    // @AuraEnabled(cacheable=true scope='global')
    // public static Movie__c[] searchMoviesByDate(Date dateStr1, Date dateStr2) {
        
    //     if (dateStr1 == null && dateStr2 == null) {
    //         return getMovies();
    //     }

    //     // Prepare query parameters
    //     Date searchDate1 = dateStr1;
    //     Date searchDate2 = dateStr2;

    //     return [
    //         SELECT
    //             Id,
    //             Title__c,
    //             Description__c,
    //             Genre__c,
    //             picture_URL__c,
    //             video_URL__c,
    //             Status__c,
    //             Duration__c
    //         FROM Movie__c
    //         WHERE Id IN (
    //             SELECT Movie__c
    //             FROM ShowTime__c
    //             WHERE ShowDate__c >= :searchDate1 AND ShowDate__c <= :searchDate2)
    //         WITH SECURITY_ENFORCED
    //         ORDER BY Title__c
    //         LIMIT 50
    //     ];
    // }

//     @AuraEnabled(cacheable=true scope='global')
    // public static Movie__c[] searchMovies(String searchKey, Date startDate, Date endDate) {
    //     // Return all movies when no search term and no date range
    //     searchKey = searchKey.trim();
    //     if (searchKey == '' && startDate == null && endDate == null) {
    //         return getMovies();
    //     }
    //     // Prepare query parameters
    //     searchKey = '%' + searchKey + '%';
    //     DateTime startDateTime = startDate != null ? DateTime.newInstance(startDate.year(), startDate.month(), startDate.day(), 0, 0, 0) : null;
    //     DateTime endDateTime = endDate != null ? DateTime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23, 59, 59) : null;
        
    //     // Build the dynamic query
    //     String query = 'SELECT Id, Title__c, Description__c, Genre__c, picture_URL__c, video_URL__c, Status__c, Duration__c ' +
    //                    'FROM Movie__c ' +
    //                    'WHERE 1=1 ';
                    
    //     if (searchKey != '') {
    //         query += 'AND Title__c LIKE :searchKey ';
    //     }
    //     if (startDate != null && endDate != null) {
    //         query += 'AND Id IN (SELECT Movie__c FROM ShowTime__c WHERE ShowDate__c >= :startDate AND ShowDate__c <= :endDate) ';
    //     }
        
    //     query += 'WITH SECURITY_ENFORCED ORDER BY Title__c LIMIT 50';
        
    //     // Execute search query
    //     return Database.query(query);
    // }
}