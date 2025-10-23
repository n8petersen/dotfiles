# udev rules

These files need to be placed in the following directory:
`/etc/udev/rules.d`

## 80-touchscreen.rules
- This file disables the touchreen on Samsung Laptop

Steps to implement:

1. Copy file to correct location (assumes git repo is working directory)
```
sudo cp other/udev-rules/80-touchscreen.rules /etc/udev/rules.d
```

2. Reload the udev rules without restart
```
sudo udevadm control --reload-rules && sudo udevadm trigger
```