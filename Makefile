all:

pdf: pdf/devops_open.pdf pdf/00_named_practice.pdf

pdf/devops_open.pdf: slides/00_devops_open.md
	docker run --rm -it --net=host -v "${PWD}/pdf:/slides" astefanutti/decktape "http://127.0.0.1:1948/00_devops_open.md" devops_open.pdf
pdf/00_named_practice.pdf: slides/practice/00_named.md
	docker run --rm -it --net=host -v "${PWD}/pdf:/slides" astefanutti/decktape "http://127.0.0.1:1948/practice/00_named.md" 00_named_practice.pdf

