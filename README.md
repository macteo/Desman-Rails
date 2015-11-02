# Desman

In order to start the server you need to:

Ensure redis-server is running

```bash
redis-server &
```

Start websocket-rails

```bash
bundle exec rake websocket_rails:start_server &
```

Start rails

```bash
bundle exec rails s Puma -b 0.0.0.0
```
