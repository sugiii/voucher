do_getpid()
{
    ps -ef|grep $1 | grep -v grep|awk '{print $2}'
}

pid=`do_getpid rails`


if test "${pid}" = ""
then
    echo "no such processes"
fi

echo $pid
kill $pid
