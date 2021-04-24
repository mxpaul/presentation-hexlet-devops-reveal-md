FILENAME=${1:-demo}
BASEDIR=$(pwd)

asciinema rec "${FILENAME}.cast" || exit 1
docker run --rm -v "$BASEDIR:/data" "asciinema/asciicast2gif" \
	-t solarized-dark \
	"${FILENAME}.cast" "$FILENAME.gif" \
  ;
