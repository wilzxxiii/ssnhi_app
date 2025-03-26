// const String depId =
//     "AKfycbxBqgQprYpAo6TVVbkacpxHxHA1etdjprTmWFqf75E26_CN_Fn2Sa1O0FFHWWRdw9lTkg";

// const String gSheetAppScriptUrl =
//     "https://script.google.com/macros/s/AKfycbxBqgQprYpAo6TVVbkacpxHxHA1etdjprTmWFqf75E26_CN_Fn2Sa1O0FFHWWRdw9lTkg/exec";

// const String googleCloudApiKey = "AIzaSyD4_6Ta9Iw480-5GR30__nN-sB2jyX4I3U";

// const String sheetLink =
//     "https://docs.google.com/spreadsheets/d/1v95m_vU2W8ZyxTg_NCYQcxMQniBqaBtxxbUTLOByS0I/edit?usp=sharing";

//
const sheetId = "1v95m_vU2W8ZyxTg_NCYQcxMQniBqaBtxxbUTLOByS0I";
const googleCloudApiKey =
    "AIzaSyD4_6Ta9Iw480-5GR30__nN-sB2jyX4I3U"; // Replace with your API key
const range =
    'JO Data Draft!A1:O'; // Fetch A3:N (adjust last row dynamically if needed)
const sheetsUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$range?key=$googleCloudApiKey';

//For performers
const entitiesRangeRange = 'Entities!A1:D';
const entitiesSheetUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$entitiesRangeRange?key=$googleCloudApiKey';
