APP_NAME=app
PORT=8078

port:
	@echo $(PORT)

run:
	@echo "Running the application in normal mode..."
	python3 -m uvicorn --host 0.0.0.0 --port $(PORT) --workers 1 $(APP_NAME):app

debug:
	@echo "Running the application in debug mode..."
	python3 -m uvicorn --host 0.0.0.0 --port $(PORT) --workers 1 $(APP_NAME):app --reload

start:
	@echo "Starting the application..."
	nohup python3 -m uvicorn --host 0.0.0.0 --port $(PORT) --workers 1 $(APP_NAME):app &

status:
	@echo "Checking the application status..."
	ps -ef | grep uvicorn | grep -v grep | grep $(PORT)

stop:
	@echo "Stopping the application..."
	pkill -f "uvicorn.*$(PORT)"

restart:
	@echo "Restarting the application..."
	make stop; make start

ensure:
	@echo "Ensuring the app is alright..."
	make status || make start

style_check:
	@echo "Checking the code style..."
	python3 -m isort --check-only *.py
	python3 -m black --check .

style:
	@echo "Applying the code style..."
	python3 -m isort *.py
	python3 -m black .

update:
	./backup.sh
	python3 get_screens.py
	python3 text_from_image.py
