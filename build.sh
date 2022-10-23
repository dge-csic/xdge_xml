home_dir=$( dirname -- "$0"; )
for f in $home_dir/*.xml
do
  name_ext="${f##*/}"
  name="${name_ext%.*}"
  dst_file=$home_dir/html/$name.html
  echo $dst_file
  xsltproc -o $dst_file build/xdge_html.xsl $f 
done
