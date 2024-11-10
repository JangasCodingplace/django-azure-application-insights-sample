echo "Starting Entrypoint Script ..."

echo "Apply database migrations ..."
poetry run python manage.py migrate

#echo "Collect static files  ..."
#poetry run python manage.py collectstatic --noinput

echo "Starting Application"
poetry run gunicorn config.wsgi:application --bind 0.0.0.0:80
