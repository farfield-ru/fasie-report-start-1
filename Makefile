# Сборка промежуточного НТО образом latex-g7-32.
# Образ ghcr.io/latex-g7-32/latex-g7-32 приватный, поэтому собираем его сами
# из Dockerfile шаблона (подмодуль latex-g7-32).

IMAGE := fasie-report-builder

.PHONY: all image clean

all: image
	docker run --rm -v "$(CURDIR)":/doc -w /doc --entrypoint /bin/sh \
	  $(IMAGE) /doc/scripts/build.sh

image:
	docker build -t $(IMAGE) -f latex-g7-32/docker/Dockerfile latex-g7-32

clean:
	rm -rf build
