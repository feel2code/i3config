import argparse
from datetime import datetime
import json
from pyowm import OWM
import sys
import time


def arrow_direction(degrees):
    if not degrees:
        return ''
    arrows = list('↓↙←↖↑↗→↘')
    index = round(degrees / 45) % 8
    return arrows[index]


def format_weather(observation, format_str):
    weather_data = {}
    weather_data['city'] = observation.location.name
    weather_data['country'] = observation.location.country
    weather_data['temp_c'] = round(observation.weather.temp['feels_like'] - 273.15)
    weather_data['temp_f'] = round((observation.weather.temp['feels_like'] - 273.15) * 9 / 5 + 32)
    weather_data['temp_k'] = round(observation.weather.temp['feels_like'])
    weather_data['text'] = observation.weather.detailed_status
    weather_data['humidity'] = observation.weather.humidity
    weather_data['pressure'] = observation.weather.pressure['press']
    weather_data['wind_direction'] = round(observation.weather.wnd['deg']) if 'deg' in observation.weather.wnd else None
    weather_data['wind_speed_ms'] = round(observation.weather.wnd['speed'])
    weather_data['wind_direction_arrow'] = arrow_direction(weather_data['wind_direction'])
    weather_data['sunrise'] = datetime.fromtimestamp(observation.weather.srise_time).strftime('%H:%M')
    weather_data['sunset'] = datetime.fromtimestamp(observation.weather.sset_time).strftime('%H:%M')
    return format_str.format(**weather_data)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--api-key', type=str, required=True,
                   help='OpenWeatherMap API key')
    p.add_argument('--format', metavar='C',
                   default='{city}, {country}: {text}, {temp_c}°C {wind_speed_ms} m/s {wind_direction_arrow}',
                   help="format string for output")
    p.add_argument('--position', metavar='P', type=int, default=0,
                   help="position of output in JSON when wrapping i3status")
    p.add_argument('--update-interval', metavar='I', type=int, default=60*10,
                   help="update interval in seconds (default: 10 minutes)")
    p.add_argument('--wrap-i3-status', action='store_true')
    p.add_argument('--zip-country', type=str, default='US',
                   help='set country for zip code lookup (defaults to US)')

    loc = p.add_mutually_exclusive_group(required=True)
    loc.add_argument('--zip', type=str, help='retrieve weather by postal/zip code')
    loc.add_argument('--city-id', type=int, help='retrieve weather by city ID')
    loc.add_argument('--place', type=str, help='retrieve weather by city,country name')
    args = p.parse_args()

    owm = OWM(args.api_key)

    if args.zip:
        get_observation = owm.weather_manager().weather_at_zip_code(args.zip, args.zip_country)
    elif args.city_id:
        get_observation = owm.weather_manager().weather_at_id(args.city_id)
    else:
        get_observation = owm.weather_manager().weather_at_place(args.city_id)

    def _get_weather():
        return format_weather(get_observation, args.format)

    if args.wrap_i3_status:
        stdin = iter(sys.stdin.readline, '')

        header = next(stdin)
        if json.loads(header)['version'] != 1:
            raise Exception('Unrecognized version of i3status: ' +
                            header.strip())

        print(header, end='')
        # First line after header is [ (open JSON array)
        print(next(stdin), end='')

        last_update = 0
        weather = {'name': 'weather', 'full_text': ''}
        try:
            for line in stdin:
                data = json.loads(line.lstrip(','))
                data.insert(args.position, weather)
                print((',' if line.startswith(',') else '') + json.dumps(data))
                sys.stdout.flush()

                if (time.time() > last_update + args.update_interval or
                        weather['full_text'] == ''):
                    try:
                        weather['full_text'] = _get_weather()
                    except Exception as e:
                        weather['full_text'] = ''
                        print('{}: {}'.format(e.__class__.__name__, e),
                              file=sys.stderr)
                    last_update = time.time()
        except KeyboardInterrupt:
            sys.exit()
    else:
        try:
            print(_get_weather())
        except Exception as e:
            print('{}: {}'.format(e.__class__.__name__, e), file=sys.stderr)
