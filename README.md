# myHomeServer

自宅サーバーを構築したい

## install

```sh
cd myHomeServer/flask
python3 -m venv venv
. venv/bin/activate
pip install Flask
pip3 install -U flask-cors
flask run --host=0.0.0.0
```

```sh
cd myHomeServer/client
sudo apt-get install npm
sudo npm install -g elm-spa@latest
sudo npm install -g elm@latest-0.19.1
```
