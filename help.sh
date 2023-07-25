!#/bin/bash

case "$1" in
    "dbreset")
        echo "dbreset: Reset the database"
        bin/rails db:drop db:create db:migrate db:seed
        ;;
esac