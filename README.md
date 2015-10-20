# README

curl -H "Content-Type: application/json" -H "Accept: application/json" -d '{"event":{"uuid":"D0FA0E1A-C419-491C-8D82-673ADF222F21", "type":"testType", "user": "C0FA0E1A-C419-491C-8D82-673ADF222F21", "app": "desman-sample.dimension.it", "timestamp": 1445330256, "payload": {"key": "value"}}}' http://desman.local:3000/events

rails g scaffold event type:string payload:string timestamp:datetime uuid:string user:string app:string

/log/#{bundle.id}/#{user}.log
