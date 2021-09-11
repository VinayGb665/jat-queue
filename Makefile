clean:
# Remove all the pickle files, distribution and files related to packaging
	rm -rf *.pkl
	rm -rf dist/
	rm -rf jat_queue.egg-info/
	rm -rf build/
	pip uninstall jat-queue -y


flush:
	redis-cli -c "flushall"

build-image:
# Run an update_registry so that everything is up-to-date
# Build an image so that the docker executor picks up the default image
	python -m executors.cli update_registry
	python -m executors.cli build_image

update-registry:
# Removes all the task queue entries from redis
# Runs an update registry command on cli to register all tasks and build a pickle file for them
	redis-cli -c "flushall"
	python -m executors.cli update_registry

install-build-dependencies:
# Some packages are required to build the package
# Also python3.9-venv required
	python3 -m pip install --upgrade build
	sudo apt install python3.9-venv

build-package:
	python setup.py bdist_wheel
	$(MAKE) update_registry
	pip install dist/jat_queue-0.0.1-py3-none-any.whl

