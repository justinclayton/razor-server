## To Build

1. `$ docker build -t razor .`

## To Run

1. `$ bundle install --path vendor/bundle`
1. `$ docker run -d --name db postgres`
1. `$ docker run -d --name app --link db:db -v $(pwd):/opt/razor -p 8080:8080 razor`
1. `$ ip=$(boot2docker ip)`
1. `$ curl http://$ip:8080/api`
