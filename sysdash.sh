

LOG="/var/log/cisco-switch1.log"

while true; do
    tput cup 0 0
    echo "==== LAST 20 LOGS ($(date)) ===="
    tail -n 10 "$LOG" | awk '
        /-0-/ {emerg++; printf "\033[41;97m%s\033[0m\n", $0; next}   # czerwone tło, biały tekst
    /-1-/     {alert++; printf "\033[1;31m%s\033[0m\n", $0; next}    # jasnoczerwony
    /-2-/  {crit++; printf "\033[35m%s\033[0m\n", $0; next}       # magenta
    /-3-/     {err++;  printf "\033[31m%s\033[0m\n", $0; next}       # czerwony
    /-4-/   {warn++; printf "\033[33m%s\033[0m\n", $0; next}       # żółty
    /-5-/    {note++; printf "\033[36m%s\033[0m\n", $0; next}       # cyjan
    /-6-/      {info++; printf "\033[32m%s\033[0m\n", $0; next}       # zielony
    /-7-/     {debug++;printf "\033[90m%s\033[0m\n", $0; next}       # szary
                 {print $0}
    END {
        print "-----------------------------"
        printf "\033[41;97mEMERG   : %d\033[0m\n", emerg+0
        printf "\033[1;31mALERT   : %d\033[0m\n", alert+0
        printf "\033[35mCRIT    : %d\033[0m\n", crit+0
        printf "\033[31mERROR   : %d\033[0m\n", err+0
        printf "\033[33mWARNING : %d\033[0m\n", warn+0
        printf "\033[36mNOTICE  : %d\033[0m\n", note+0
        printf "\033[32mINFO    : %d\033[0m\n", info+0
        printf "\033[90mDEBUG   : %d\033[0m\n", debug+0
    }
    '

    sleep 5 

done 