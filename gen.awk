# gen.awk
# MIT License

#
#
#

# ----------------------------------------
# filler_full: 英大小52 + 数字10 + 記号セット
# ----------------------------------------
function filler_full(pool,    chars, nc) {
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" pool
    nc = length(chars)
    return substr(chars, int(rand()*nc)+1, 1)
}

BEGIN {
    total_len   = 32      # 桁数（8でも12でも20でもOK）
    req_upper   = 1       # 必須：英大
    req_lower   = 1       # 必須：英小
    req_digit   = 1       # 必須：数字
    srand()
}

{
    ns = split($0, pool, "")
}

END {
    # 記号全部使えるか？
    if (total_len >= ns + req_upper + req_lower + req_digit) {
        # -------------------------
        # モードA：記号全部使う
        # -------------------------
        symbol_count = ns
        filler_count = total_len - symbol_count - req_upper - req_lower - req_digit

        # 記号（重複なし）
        pool_size = ns
        for (k=1; k<=symbol_count; k++) {
            idx = int(rand()*pool_size) + 1
            a[k] = pool[idx]
            pool[idx] = pool[pool_size]
            pool_size--
        }

        pos = symbol_count
        a[++pos] = sprintf("%c", int(rand()*26) + 65)   # A-Z
        a[++pos] = sprintf("%c", int(rand()*26) + 97)   # a-z
        a[++pos] = sprintf("%c", int(rand()*10) + 48)   # 0-9

        # filler は英大小＋数字＋記号セットから選ぶ
        for (i=1; i<=filler_count; i++) {
            a[++pos] = filler_full($0)
        }

    } else {
        # -------------------------
        # モードB：記号を一部だけ使う
        # -------------------------
        symbol_count = total_len - req_upper - req_lower - req_digit

        pool_size = ns
        for (k=1; k<=symbol_count; k++) {
            idx = int(rand()*pool_size) + 1
            a[k] = pool[idx]
            pool[idx] = pool[pool_size]
            pool_size--
        }

        pos = symbol_count
        a[++pos] = sprintf("%c", int(rand()*26) + 65)
        a[++pos] = sprintf("%c", int(rand()*26) + 97)
        a[++pos] = sprintf("%c", int(rand()*10) + 48)
    }

    # シャッフル
    for (i=total_len; i>1; i--) {
        j = int(rand()*i) + 1
        tmp=a[i]; a[i]=a[j]; a[j]=tmp
    }

    # 出力
    for (i=1; i<=total_len; i++) printf "%s", a[i]
    printf "\n"
}'
