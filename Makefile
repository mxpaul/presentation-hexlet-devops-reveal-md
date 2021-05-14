all:

pdf: pdf/devops_open.pdf

pdf/devops_open.pdf: slides/00_devops_open.md
	docker run --rm -it --net=host -v "${PWD}/pdf:/slides" astefanutti/decktape "http://127.0.0.1:1948/00_devops_open.md" devops_open.pdf
