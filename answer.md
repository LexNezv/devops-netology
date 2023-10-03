1)
Нашел с помощью
```
git log aefea
```
ответ
```
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md
```

2)
- соответствует тегу v0.12.23 , был найден аналогично

```
git log 85024d3
```

- два родителя, их хеши:
```
56cd7859e0 9ea88f22fc
```
Команда
```
git log b8d720
```
- список:
```
b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guide's old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release
```
команда 
```
git log v0.12.24 v0.12.23  --oneline
```

- Это коммит
```
8c928e83589d90a031f811fae52a81be7153e82f
```  
Обнаружил с помощью
```
git grep -n --heading 'func providerSource'
git log -L :'func providerSource':provider_source.go
```

- Это коммиты:
```
65c4ba7363 Remove terraform binary
125eb51dc4 Remove accidentally-committed binary
22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
7c7e5d8f0a Don't show data while input if sensitive
35a058fb3d main: configure credentials from the CLI config file
c0b1761096 prevent log output during init
8364383c35 Push plugin discovery down into command package
```
Командой 
```
git log -SglobalPluginDirs --oneline
```

- Автор
```
Author: Martin Atkins <mart@degeneration.co.uk>
```

с помощью
```
git log -SsynchronizedWriters
git show 5ac311e2a91e381e2f52234668b49ba670aa0fe5
```
