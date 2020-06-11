## USNWC-Trails

A group of GCP Cloud Functions that provide an "API endpoint" for the status of the USNWC trail system. There's also a web page showing the current status at [usnwc.app][1].

---

#### Directories

- `/update-status`: GCP function for checking the status of the USNWC trail system and storing the current in a GCP Datastore
- `/get-status`: GCP function for fetching current status from the Datastore
- `/ios`: WIP iOS app 

---

[Check the status ↗][1]

[Siri Shortcut ↗][2]

[1]: https://usnwc.app
[2]: https://www.icloud.com/shortcuts/75df2680587f446e9cbfb54cce4e8c4d