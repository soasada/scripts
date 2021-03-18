# scripts

Scripts that I use for my day to day work.

## gdrive_backup.sh

**PREREQUISITES:** You need to install `jq` and `curl` in your machine **before** executing this script.

This script could be used to store a file in google drive, use it along with a cronjob in your server and you will have automatic backups. Before you can use it please follow these steps:

1. Create a gmail account if you don't have any.
2. Go to Google API Console (search it in google if you can't find it).
3. Create a project.
4. Click on 'Enable API or Service'.
5. Search for 'Google Drive API'.
6. Click on 'Enable'.
7. Go to 'OAuth consent screen' and click on 'External' and then in 'Create'.
8. Fill only the **required** information requested (App name, User support email, etc...).
9. In the next step, you don't need to add any scopes.
10. In the next step, add your gmail as test user.
11. You will see a summary, check that everything is ok.
12. Go to 'Credentials'.
13. Click on 'Create Credentials' and then in 'OAuth client ID'.
14. Select 'Desktop app' as Application type and put it a name (e.g. 'My backups CLI').
15. After this, you will see a modal with 'Your Client ID' and 'Your Client Secret', please copy them and put in a temporal file in your pc.
16. Open [gdrive_backup.sh](/gdrive_backup.sh) and copy `BROWSER_URL` into your browser, please replace `${G_CLIENT_ID}` in the URL with 'Your Client ID' **before** opening it in the browser.
17. Select your gmail account and follow the steps, be aware that you will be warned about a 'Testing' application. At the end of this process you will receive an AUTHORIZATION_CODE, please copy it and paste it into your pc.
18. Open [gdrive_backup.sh](/gdrive_backup.sh) and edit `G_CLIENT_ID` with 'Your Client ID', `G_CLIENT_SECRET` with 'Your Client Secret' and `AUTHORIZATION_CODE` with your AUTHORIZATION_CODE.
19. Open a terminal and do the following: `curl -s --request POST --data "code=${AUTHORIZATION_CODE}&client_id=${G_CLIENT_ID}&client_secret=${G_CLIENT_SECRET}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://oauth2.googleapis.com/token` **note that you have to replace ${} with your information**, this will gives you a JSON response with a `refresh_token` please copy and paste it in your pc.
20. Open [gdrive_backup.sh](/gdrive_backup.sh) and edit `REFRESH_TOKEN` with your refresh token of the previous step.
21. Now you could use the script to upload files to Google Drive, enjoy!.
