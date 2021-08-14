# Salesforce CSV Loader

> A custom CSV loader in a Visualforce Page. ☁

## About

Sometimes we need customized solutions to meet our business needs, this CSV Loader make it easier for business users to upload records to Salesforce using CSV files without needing to know how to use tools like Workbench or install Dataloader!

## Getting Started

### Prerequisites

If you haven't done it yet, setup your SFDX CLI:
 - [Salesforce CLI Instalation](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)
 - [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)

### Setting up this project
1. Clone this repo:
    ```sh
    git clone https://github.com/theliofreitas/salesforce-csv-loader.git
    ```
    
2. Create your Scratch Org
In the project's root folder, use the following command:
    ```sh
    sfdx force:org:create -f .\config\project-scratch-def.json -a yourScratchOrgName
    ```

3. Push the source code to the new Scratch Org
    ```sh
    sfdx force:source:push -u yourScratchOrgName
    ```

## Using the CSV Loader

Open your new scratch org using the following command:
```sh
sfdx force:org:open -u yourScratchOrgName
```

In the Settings > Visualforce pages, open the **CSV Loader** and there it is! You can test and modify the code according to your business scenarios. 😃


## To Do List

- [x] CSV Loader
- [x] Error handling
- [ ] Test classes
- [ ] Dynamic objects
