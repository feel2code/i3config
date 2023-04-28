<h1 align="center">i3config</h1>
<h6 align="center">i3config for i3wm</h6>

![i3config Logo](https://repository-images.githubusercontent.com/566505848/ff0fd177-aaf8-4ee3-b032-599ffb74d37d)
<h6 align="center">Photo by <a href="https://unsplash.com/@trapnation">Andre Benz</a></h6>

### HOW TO START 

Installing i3 and dependencies _(for Ubuntu)_:

`sudo apt install git i3 brightnessctl feh flameshot fonts-font-awesome`

Adding user to video group to grant access for brightness control

```sudo usermod -a -G video ${USER}```

Download config by git or get it from this repo

```git clone https://github.com/feel2code/i3config.git```

unzip and move configs to `~/.config/`

install env and dependencies for Python3
```
cd ~/.config/i3weather
python3.9 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

In the `~/.config/i3/config` please set api_key for [OpenWeatherMap]

[OpenWeatherMap]: https://home.openweathermap.org/users/sign_up
