
sum=0
a=1
b=2

while [[ $b -le 4000000 ]]; do
    if (( b % 2 == 0 )); then
	sum=$(( sum + b ))
    fi
    # Generate next number.
    temp=$((a + b))
    a="$b"
    b="$temp"
done

echo "$sum"
