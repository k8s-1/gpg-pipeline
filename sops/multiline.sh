# Simulate SK stored in env var
export AGE_SK="line 1
line 2
line 3"

echo "$AGE_SK" > secret.txt

# verify output
cat secret.txt
