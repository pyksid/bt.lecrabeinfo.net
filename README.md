# bt.lecrabeinfo.net

### Create .torrent files

```
docker compose exec -T transmission /scripts/create-torrents.sh /srv/files http://tracker.lecrabeinfo.test:6969/announce
```

### Add torrents to Transmission

```
docker compose exec -T transmission /scripts/add-torrents.sh user:password /srv/files
```

### Generate torrent-hashes.list file

```
docker compose exec -T transmission /scripts/export-hashes.sh user:password /exports/torrent-hashes.list
```
