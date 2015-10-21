# README

curl -H "Content-Type: application/json" -H "Accept: application/json" -d '{"event":{"uuid":"D0FA0E1A-C419-491C-8D82-673ADF222F21", "type":"testType", "user": "C0FA0E1A-C419-491C-8D82-673ADF222F21", "app": "desman-sample.dimension.it", "timestamp": 1445330256, "payload": {"key": "value"}}}' http://desman.local:3000/events

rails g scaffold event type:string payload:string timestamp:datetime uuid:string user:string app:string

/log/#{bundle.id}/#{user}.log



curl -H "Content-Type: application/json" -H "Accept: application/json" -d '{"events": [{"uuid": "D0FA0E1A-C419-491C-8D82-673ADF222F21","type": "testType","user": "C0FA0E1A-C419-491C-8D82-673ADF222F21","app": "desman-sample.dimension.it","timestamp": 1445330256,"payload": {"key": "value"}},{"uuid": "E0FA0E1A-C419-491C-8D82-673ADF222F21","type": "testType2","user": "E0FA0E1A-C419-491C-8D82-673ADF222F21","app": "desman-sample.dimension.it","timestamp": 1445338256,"payload": {"key2": "value2"}}]}' http://desman.local:3000/events



curl -H "Content-Type: application/json" -H "Accept: application/json" -d '{"ops": [{"method": "post","url": "/events","params": {"event": {"uuid": "D0FA0E1A-C419-491C-8D82-673ADF222F21","type": "testType","user": "C0FA0E1A-C419-491C-8D82-673ADF222F21","app": "desman-sample.dimension.it","timestamp": 1445330256,"payload": {"key": "value"}}}},{"method": "post","url": "/events","params": {"uuid": "E0FA0E1A-C419-491C-8D82-673ADF222F21","type": "testType2","user": "E0FA0E1A-C419-491C-8D82-673ADF222F21","app": "desman-sample.dimension.it","timestamp": 1445338256,"payload": {"key2": "value2"}}}],"sequential": true}' http://desman.local:3000/batch



{"uuid": "E0FA0E1A-C419-491C-8D82-673ADF222F21","type": "testType2","user": "E0FA0E1A-C419-491C-8D82-673ADF222F21","app": "desman-sample.dimension.it","timestamp": 1445338256,"payload": {"key2": "value2"}}
