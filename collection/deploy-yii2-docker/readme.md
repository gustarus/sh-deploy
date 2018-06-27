# Deployment script
**Copy-and-paste** your staff to folder on remote server from local folder **without** `gitignore` files with `rsync` tool.

## Features
- Deploy files through `rsync`.
- Ask `y` if you really want to launch deploy.
- Deploy only files what are not under `.gitignore`.
- Define deploy process variables through `.env` file (use `.env.example` as template).
- Auth on the server via `ssh public key`.
- Pull docker container and up via docker-compose.


## Env variables (`.env` file)
|Variable|Value example|Description|
|---|---|---|
|**DEPLOY_NAME**|`Project name`|Project name will be displayed in console.|
|**DEPLOY_USER**|`user`|User name to connect via `ssh` to remote server|
|**DEPLOY_HOST**|`example.ru`|Domain from the remote server|
|**DEPLOY_PATH**|`/home/user/www/example.ru`|Path to project to sync with on the remote server.|


## Env variables for docker container (`.env.varialbes` file)
|Variable|Value example|Description|
|---|---|---|
|**MYSQL_HOST**|`Mysql host`|...|
|**MYSQL_DATABASE**|`Mysql database`|...|
|**MYSQL_ROOT_USER**|`Mysql root user`|...|
|**MYSQL_ROOT_PASSWORD**|`Mysql root pass`|...|

## Warning
*This script doesn't cleanup folder before deployment.*
It means that if you change a name of a local file on the remote server you will get two files with the same name.
Possible solution: deploy through git repo via `git pull` (for the future).

## Installation

**1. Just download `deploy.sh` and `.env.example` to you project.**

**2. Copy template env file**
```bash
cp .env.example .env
``` 

**3. Change variables inside the `.env`**
As described in env variables.


## Ideas
- [ ] Add ability to deploy via `git pull` on remote server. 
