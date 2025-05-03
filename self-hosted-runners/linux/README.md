# **Add new self-hosted runner - Linux**

![Self-hosted Linux Runner](GitHub-Actions-Templates/self-hosted-runners/self-hosted-runner-linux.png)

---

### **Runner registration:**

Enter the name of the runner group to add this runner to: [press Enter for Default] -> ``Enter``

Enter the name of runner: [press Enter for ip-172-31-1-19] -> ``kalenski-runner``

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] -> ``self-hosted``

Enter name of work folder: [press Enter for _work] -> ``Enter``

---

### **Install & Start the service after the installation:**

|**Commands**                                        | **Description**                                             |
|:---------------------------------------------------| :-----------------------------------------------------------|
|``sudo ./svc.sh install``                           | Installs the service                                        |
|``sudo ./svc.sh start``                             | Starts the installed service                                |
|``sudo ./svc.sh status``                            | Displays the current status                                 |

---

### **Check the logs after installation:**

|**Commands**                                        | **Description**                                             |
|:---------------------------------------------------| :-----------------------------------------------------------|
|``ls -l ~/actions-runner/_diag/``                   | Lists diagnostic files in the runner's _diag directory      |
|``tail -f ~/actions-runner/_diag/Runner_*.log``     | Follows the log output of all runner log files in real-time |
|``tail -n 100 ~/actions-runner/_diag/Runner_*.log`` | Displays the last 100 lines from the runner log files       |
|``sudo journalctl -u actions.runner* -f``           | Follows the system logs for the runner service in real-time |