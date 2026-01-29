# bt.lecrabeinfo.net

### Create .torrent files

```
docker compose exec transmission \
  /scripts/create-torrent-files.sh \
  /srv/files \
  udp://tracker.example.com:6969/announce \
  http://tracker.example.com:6969/announce
```

### Add torrents to Transmission

```
docker compose exec transmission \
  /scripts/add-torrents-to-transmission.sh \
  user:password \
  /srv/files
```

### Generate torrent-hashes.list file

```
docker compose exec transmission \
  /scripts/export-hashes.sh \
  user:password \
  /exports/torrent-hashes.list
```
