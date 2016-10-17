### What is this?

Gilfoyle will store your secrets. We encrypt your data.

### What is used?
- `Sinatra` as a back-end.
- `Redis` as a database. We do not need to keep a huge structure of data. We just want to set and get data as fast as possible. Therefore, Redis.
- `Sidekiq` for background processes. It is fast. It has a great community. Even the creator has [answered](http://stackoverflow.com/questions/35126160/how-to-kill-sidekiq-worker) me at stackoverflow.
- `OpenSSL::Cipher` from standard library to encrypt data to avoid unnecessary dependencies.
- `Unicorn` as a web server. I've used it in production and because of [DHH](https://twitter.com/dhh/status/758884081819987968).

### How it was started?
Well, I've started from paper. From [this](https://paper.dropbox.com/doc/Gilfoyle-PeDW48CHJaXxkWHTYSNZq) paper.
