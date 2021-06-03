### Mount the New EBS

Step 1:
Make Filesystem first
```bash
mkfs.ext4 /dev/xvdh
```
Step 2:
Mount the FS
```bash
mkdir -p /data 
```
```bash
mount /dev/xvdh /data
```
```bash
df -h
```

### Persist EBS Mount Drive
```bash
nano /etc/fstab
```
```bash
# add the following in the new line
/dev/xvdh /data ext4 defaults 0 0