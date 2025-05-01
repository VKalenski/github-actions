# **Add new self-hosted runner - Linux**

![Self-hosted Linux Runner](GitHub-Actions-Templates/self-hosted-runners/self-hosted-runner-linux.png)

### Runner Registration

Enter the name of the runner group to add this runner to: [press Enter for Default] -> ``Enter``

Enter the name of runner: [press Enter for ip-172-31-1-19] -> ``kalenski-runner``

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] -> ``self-hosted``

Enter name of work folder: [press Enter for _work] -> ``Enter``

---

### After the installation:

|**Commands**              | **Description**              |
|:-------------------------| :----------                  |
|``sudo ./svc.sh install`` | Installs the service         |
|``sudo ./svc.sh start``   | Starts the installed service |
|``sudo ./svc.sh status``  | Displays the current status  |
