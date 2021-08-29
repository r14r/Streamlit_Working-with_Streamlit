HERE := ${CURDIR}

CONTAINER := playground_fastapi

build:
	DOCKER_SCAN_SUGGEST=false docker build -t ${CONTAINER} .

run:
	docker run  --hostname docker -v ${HERE}/workspace:/workspace -it ${CONTAINER}


serve:
	uvicorn main:app --host 0.0.0.0 --port 8000 --reload


db_create:
	alembic upgrade head
