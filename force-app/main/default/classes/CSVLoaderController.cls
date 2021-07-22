public with sharing class CSVLoaderController {
    public Blob csvFile {get; set;}
    public String csvAsString {get; set;}
    public String[] rows {get; set;}
    public String splitRowsRegex {get; set;}
    public String splitColumnsRegex {get; set;}
    public List<Case> newCases {get; set;}

    public CSVLoaderController() {
        rows = new String[]{};
        newCases = new List<Case>();
        // Regex to split rows by CRLF or LF
        splitRowsRegex = '\r\n|\n';
        // Regex to find comma or semicolon outsite quotes
        splitColumnsRegex = '(,|;)(?=(?:[^"]*"[^"]*")*[^"]*$)';
    }

    public void importCSVFile() {
        clearImportedRecords();

        csvAsString = csvFile.toString();

        // Split CSV file rows
        rows = csvAsString.split(splitRowsRegex);
        // Split CSV header columns
        String[] header = rows[0].split(splitColumnsRegex);

        // Check if the CSV header columns exists as fields in the target SObject
        if(!checkHeaderColumns(header)) {
            addPageError('Invalid column field on the header');
            return;
        }

        // Loop through CSV file rows skipping the header row
        for (Integer row = 1; row < rows.size(); row++) {
            // Split each row in columns
            String[] columns = rows[row].split(splitColumnsRegex);

            // Make sure header and columns are the same size
            if (header.size() == columns.size()) {
                Case newCase = new Case();

                // Dynamically populates the fields of the new object
                for (Integer col = 0; col < header.size(); col++) {
                    newCase.put(header[col], columns[col]);
                }

                newCases.add(newCase);
            } else {
                addPageError('The number of columns in the row "' + row + '" is different from the header of the file.');
            }
        }
    }

    public void insertNewRecords() {
        if (!newCases.isEmpty()) {
            try {
                insert newCases;
            } catch (Exception e) {
                addPageError(e.getMessage());
            }
        }
    }

    // Helper method to clear the newCases list
    private void clearImportedRecords() {
        if (!newCases.isEmpty()) {
            newCases.clear();
        }
    }

    // Helper method to check if the header columns exists as fields on the target object
    private Boolean checkHeaderColumns(String[] header) {
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('Case');
        
        Map<String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();

        for (String column : header) {
            if(fieldMap.get(column.toLowerCase()) == null) {
                return false;
            }
        }

        return true;
    }

    // Helper method to add error messages on the Visualforce page
    private void addPageError(String errorMessage) {
        ApexPages.Message pageErrorMessage = new ApexPages.Message(ApexPages.severity.ERROR, errorMessage);
        ApexPages.addMessage(pageErrorMessage);
    }
}
