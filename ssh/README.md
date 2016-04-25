[Reference](https://stribika.github.io/2015/01/04/secure-secure-shell.html)
# Create moduli
```sh
ssh-keygen -G /etc/ssh/moduli.all -b 4096
ssh-keygen -T /etc/ssh/moduli.safe -f /etc/ssh/moduli.all
mv /etc/ssh/moduli.safe /etc/ssh/moduli
rm /etc/ssh/moduli.all
```
