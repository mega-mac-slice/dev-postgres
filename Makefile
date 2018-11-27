IMAGE=postgres:10.5
PORT=5432
CONTAINER_ID=$(shell docker container ls | awk '$$2 == "'${IMAGE}'" {print $$1}')

container-id:
	@echo ${CONTAINER_ID}

start:
	docker run -itd  \
	-p ${PORT}:${PORT} \
	${IMAGE}

stop:
	docker stop ${CONTAINER_ID}

restart:
	docker restart ${CONTAINER_ID}

remove:
	docker container rm --force ${CONTAINER_ID}

check-running:
	@if [ -z "${CONTAINER_ID}" ]; then\
		make start;\
    fi \

status:
	@echo ok

sanity:
	psql --host docker --user postgres --port ${PORT}
