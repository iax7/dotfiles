# macOS

## Remove sudo

```bash
sudo visudo
```

Use one of the following methods:

1. Modify the following line:
   ```diff
   -%admin  ALL = (ALL) ALL
   +%admin  ALL = (ALL) NOPASSWD: ALL
   ```

2. Add the following line below `%admin  ALL = (ALL) ALL`:
   ```conf
   <USER_NAME> ALL=(ALL) NOPASSWD: ALL
   ```
