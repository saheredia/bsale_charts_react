BASE_DIR='public/'
SITE_DIR='s3/'
UPLOADS_DIR='s3/uploads'
TMP_DIR='s3/tmp'

echo "SE DEBE CONFIGURAR EL BUCKET DE S3"
exit 1;

#BUCKET='s3://bsalemarket/assets/'
#BUCKET='s3://bprueba/assets/'

echo '--> Se copia original en directorio de paso'
rm -rf $SITE_DIR;
cp -ar $BASE_DIR $SITE_DIR;
rm -rf $UPLOADS_DIR;
rm -rf $TMP_DIR;

#se compilan la carpeta SASS
SASS_FILE="s3/stylesheets/sass/app.scss";
SASS_DIR="s3/stylesheets/sass";
CSS_FILE="s3/stylesheets/app.css";

echo 'Compilando SASS';
sass $SASS_FILE $CSS_FILE --trace --style compressed --sourcemap=none;
rm -rf $SASS_DIR;

echo '--> Gzip css, js'
find $SITE_DIR \( -iname '*.css' -o -iname '*.js' \) -exec gzip -9 -n {} \; -exec mv {}.gz {} \;

#--dry-run para solo ver que hara sin subir cambios

echo '--> Subiendo css'
s3cmd sync --exclude '*.*' --include '*.css' --add-header='Content-Encoding: gzip' --add-header='Content-Type: text/css' --mime-type='text/css' --force --acl-public $SITE_DIR $BUCKET
#s3cmd sync --dry-run --exclude '*.*' --include '*.css' --add-header='Content-Encoding: gzip' --add-header='Content-Type: text/css' --mime-type='text/css' --force --acl-public $SITE_DIR $BUCKET

echo '--> Subiendo js'
s3cmd sync --exclude '*.*' --include '*.js' --add-header='Content-Encoding: gzip' --add-header='Content-Type: application/javascript' --mime-type='text/css' --force --acl-public $SITE_DIR $BUCKET
#s3cmd sync --dry-run --exclude '*.*' --include '*.js' --add-header='Content-Encoding: gzip' --add-header='Content-Type: application/javascript' --mime-type='text/css' --force --acl-public $SITE_DIR $BUCKETET

# Sync media files first (Cache: expire in 10weeks)
echo '--> Subiendo (jpg, png, ico, gif)'
s3cmd sync --exclude '*.*' --include '*.png' --include '*.jpg' --include '*.ico' --include '*.gif' --force --acl-public $SITE_DIR $BUCKET
#s3cmd sync --dry-run --exclude '*.*' --include '*.png' --include '*.jpg' --include '*.ico' --include '*.gif' --force --acl-public $SITE_DIR $BUCKET

echo '--> Subiendo (htm, html)'
s3cmd sync --exclude '*.*' --include '*.htm' --include '*.html' --force --acl-public $SITE_DIR $BUCKET
#s3cmd sync --dry-run --exclude '*.*' --include '*.htm' --include '*.html' --force --acl-public $SITE_DIR $BUCKET

echo '--> Subiendo Otros'
s3cmd sync --exclude '*.html' --exclude '*.htm' --exclude '*.orig' --exclude '*.png' --exclude '*.jpg' --exclude '*.ico' --exclude '*.gif' --exclude '*.js' --exclude '*.css' --force --acl-public $SITE_DIR $BUCKET
#s3cmd sync --dry-run --exclude '*.html' --exclude '*.htm' --exclude '*.orig' --exclude '*.png' --exclude '*.jpg' --exclude '*.ico' --exclude '*.gif' --exclude '*.js' --exclude '*.css' --force --acl-public $SITE_DIR $BUCKET

echo "--> Traspaso finalizado..."

#se actualiza la version de assets (se requiere para CloudFront)
echo `date +%s` > config/assets.version
rm -rf $SITE_DIR;
