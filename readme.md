# Deployment script

## Features
- Deploy files through `rsync`.
- Ask `y` if you really want to launch deploy.
- Deploy only files what are not under `.gitignore`.
- Define deploy process variables through `.env` file (use `.env.example` as template).
- Auth on the server via `ssh public key`.


## Env variables (`.env` file)
|Variable|Value example|Description|
|---|---|---|
|**DEPLOY_NAME**|`Project name`|Project name will be displayed in console.|
|**DEPLOY_USER**|`user`|User name to connect via `ssh` to remote server|
|**DEPLOY_HOST**|`example.ru`|Domain from the remote server|
|**DEPLOY_PATH**|`/home/user/www/example.ru`|Path to project to sync with on the remote server.|

## Installation

**1. Just download `deploy.sh` and `.env.example` to you project.**

**2. Copy template env file**
```bash
cp .env.example .env
``` 

**3. Change variables inside the `.env`**
As described in env variables.
