# Common Scripts
Scripts to help setup and development on linux

## fisrst_install.sh
Debian based script to setup your linux machine, install a lot of tools for devlopers to help with code and monitor of applications, such as python, nodejs, java, docker, kubernetes, code and more. It must be run as sudo, if you have more than one user on your machine, comment the line where the script get my_user from ls, and uncomment the lines to get my_user from the command line. You can run the script with:
```sh
  sudo ./first_install.sh
```
if you have problem with permissions, run:
```sh
  sudo chmod +x first_install.sh
```


## docker-compose for local mysql and/or postgres db
A docker-compose file to use mysql and/or postgres db volumed, passwords and volume paths are defined in the yaml file, to use it simply run:

```sh
  docker-compose up -d
```
or:
```sh
  docker compose up -d
```

Docker and docker compose need to be installed for this to work. Enjoy it! (⌐ ͡■ ͜ʖ ͡■)
