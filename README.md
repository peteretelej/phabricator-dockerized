# Phabricator Dockerized
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Containerized Phabricator instance.

__Disclaimer__: This was built in Mar 2016, and powered code.etelej.com till 28 Oct 2016. Do not use as is.

## Docker Containers
Phabricator was _dockerized_ into containers for use at Code.Etelej.com. Facebook's Phabricator did not support Docker (and [didn't plan to](https://secure.phabricator.com/T6353)).

For effective use via Docker, the following customized images were built and used:

   - Phabricator [etelej/phabricator:201603](https://hub.docker.com/r/etelej/phabricator/)
   - Phab-Mysql [etelej/phab-mysql:5.7](https://hub.docker.com/r/etelej/phab-mysql/)
   - Nginx

### Phabricator
`phabricator` applications are in the phabricator container at `/srv/phabricator`

#### Phabricator cli example:
To run the phabricator command `./bin/remove destroy @peter`:

```bash
docker exec -it phabricator bash
cd /srv/phabricator/phabricator/bin
./remove destroy @peter
```



