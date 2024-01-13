import google.auth
import os.path
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.errors import HttpError


SCOPES = ["https://www.googleapis.com/auth/drive.appdata"]

def list_appdata():
  """List all files inserted in the application data folder
  prints file titles with Ids.
  Returns : List of items

  Load pre-authorized user credentials from the environment.
  TODO(developer) - See https://developers.google.com/identity
  for guides on implementing OAuth2 for the application.
  """
  creds = None
  # The file token.json stores the user's access and refresh tokens, and is
  # created automatically when the authorization flow completes for the first
  # time.
  if os.path.exists("token.json"):
    creds = Credentials.from_authorized_user_file("token.json", SCOPES)
  # If there are no (valid) credentials available, let the user log in.
  if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
      creds.refresh(Request())
    else:
      flow = InstalledAppFlow.from_client_secrets_file(
          "credentials.json", SCOPES
      )
      creds = flow.run_local_server(port=0)
    # Save the credentials for the next run
    with open("token.json", "w") as token:
      token.write(creds.to_json())

  try:
    # call drive api client
    service = build("drive", "v3", credentials=creds)

    # pylint: disable=maybe-no-member
    response = (
        service.files()
        .list(
            spaces="appDataFolder",
            fields="nextPageToken, files(id, name)",
            pageSize=10,
        )
        .execute()
    )
    for file in response.get("files", []):
      # Process change
      print(f'Found file: {file.get("name")}, {file.get("id")}')

  except HttpError as error:
    print(f"An error occurred: {error}")
    response = None

  return response.get("files")


if __name__ == "__main__":
  list_appdata()
