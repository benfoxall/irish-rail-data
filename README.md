# irish-rail-data

Git Scraping Irish Rail Realtime APIs.

### Updating data

```bash
./collect.sh


# collect data every minute
watch -n 60 ./collect.sh
```

### Extracting data

```bash

# get the history of `currentTrains.xml` (--since & --until allow filtering by date)
git log --pretty=format:"%H %at" -- currentTrains.xml

# COMMIT_HASH                            TIMESTAMP
a4b14471f63186a35efca2cb8b3cf280f995fe84 1758448509
a978eda8791e1aede95d410cbb361775fa93aed0 1758448448
6c9a6b09fd73001b73c209459773158bc58f3bd2 1758448388
cb8cfb5bdda0be0d9aa86e4c246cb0f292b3d122 1758448328
565a03c550cfd751bab9e64fa6f7c0b12901cee4 1758448267
2c58d2bd41075d4f1a2c490241b2641eadcb8f7d 1758448207
...

# read the file contents for a given commit
git show ${COMMIT_HASH}:currentTrains.xml
```
