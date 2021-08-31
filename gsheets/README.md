# Google sheets examples

Collections of examples with using google sheets as storage 

Tutorial:
- On `Google Cloud Platform` create new project. 
- Then search bar look for `Google Sheets API` and enable it. 
- After that go back on `Credentials` for your project.
- Click `CREATE CREDENTIALS` and then `Service account`
- Enter your details
- Now in `Service Accounts` you have a new entry. Click `Edit Service account`
- After click on `KEYS` tab, then `ADD KEY` and select `JSON` and click `Create`
- Now file is dowloaded
- After that create `gsheets_credentials.secret.dart` in `lib/services` following example from `lib/services/gsheets_credentials.secret.example.dart`
- You're set to go