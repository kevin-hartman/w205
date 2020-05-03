# Project 2: Instructions

A series of scripts have been prepared for initializing the project environment.

The environment consists of several docker containers that house the services used in constructing the data pipeline.

### Starting the containers

To start the containers, enter the following command from your console in the main project directory.

```
./bin/startup.sh
```

### Running the report

After the script completes you will get see a URL for Jupyter Notebook with 0.0.0.0 for the host / ip address.

Copy this URL and paste it into a local text editor.

Find the external ip address for your Google cloud virtual machine. Replace the 0.0.0.0 IP address in the text edtor with your external GCP VM address. Then paste it into your browser window.

Follow the remaining instructions in the Jupyter Notebook. You may continue to the next step when you are ready.


### Stopping the containers

When you are finished with the report you can shutdown your containers.

Enter the following command from your console in the main project directory.

```
./bin/shutdown.sh
```
