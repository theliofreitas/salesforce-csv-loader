public with sharing class CSVLoaderController {
    public Blob csvFile {get; set;}
    public String csvAsString {get; set;}
    public String[] rows {get; set;}
    public String splitRowsRegex {get; set;}
    public String splitColumnsRegex {get; set;}

    public CSVLoaderController() {
        rows = new String[]{};
        // Regex to split rows by CRLF or LF
        splitRowsRegex = '\r\n|\n';
        // Regex to find comma or semicolon outsite quotes
        splitColumnsRegex = '(,|;)(?=(?:[^"]*"[^"]*")*[^"]*$)';
    }

    public void importCSVFile() {
        csvAsString = csvFile.toString();

        // Split CSV file rows
        rows = csvAsString.split(splitRowsRegex);
        // Split CSV header columns
        String[] header = rows[0].split(splitColumnsRegex);

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
                System.debug(newCase);
            }
        }
    }
}
