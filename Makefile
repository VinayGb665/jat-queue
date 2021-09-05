clean:
	rm -rf *.pkl

flush:
	redis-cli -c "flushall"

build-image:
	python -m executors.cli update_registry
	python -m executors.cli build_image

update-registry:
	redis-cli -c "flushall"
	python -m executors.cli update_registry
