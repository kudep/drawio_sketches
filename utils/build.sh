BUILD_DIR=${3:-build}
FINISH_DATE_FILE=${1:-$BUILD_DIR/finish_date}
TYPE_FILE=${2:-$BUILD_DIR/type}

TYPE=$(cat $TYPE_FILE)
LAST_UPDATED_DATE=$([ -f $FINISH_DATE_FILE ] && date -r $FINISH_DATE_FILE "+%m/%d/%Y %H:%M:%S" || echo "1/1/2000 0:00:00")
echo last update is $LAST_UPDATED_DATE
echo exporting to type $TYPE
for IN_FILE in $(find . -type f -name "*.drawio" -newermt "$LAST_UPDATED_DATE")
do 
    REGEXP=$(echo 's/.\/\(.*\)\.drawio/'$BUILD_DIR'\/\1\.'$TYPE'/p')
    OUT_FILE=$(echo $IN_FILE | sed -n 's/.\/\(.*\)\.drawio/'$BUILD_DIR'\/\1\.'$TYPE'/p')
    OUT_DIR=$(echo $IN_FILE | sed -n 's/.\/\(.*\)\/.*\.drawio/'$BUILD_DIR'\/\1/p')
    mkdir -p $OUT_DIR
    [ "$IN_FILE" ] && [ "$OUT_FILE" ] && draw.io $IN_FILE -x -o $OUT_FILE -s 4;
done
touch $FINISH_DATE_FILE