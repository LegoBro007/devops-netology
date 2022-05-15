1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea

Полный хеш aefead2207ef7e2aa5dc81a34aedf0cad4c32545
комментарий коммита  Update CHANGELOG.md

---------------------------
alegach@ubuntu:~/GitProject/terraform$ git log | grep aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
commit 8619f566bbd60bbae22baefea9a702e7778f8254
commit 3593ea8b0aefea1b4b5e14010b4453917800723f
commit 0196a0c2aefea6b85f495b0bbe32a855021f0a24
alegach@ubuntu:~/GitProject/terraform$ git checkout aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Note: switching to 'aefead2207ef7e2aa5dc81a34aedf0cad4c32545'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at aefead220 Update CHANGELOG.md
alegach@ubuntu:~/GitProject/terraform$ 
alegach@ubuntu:~/GitProject/terraform$ git log
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545 (HEAD)
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md
---------------------------------

2. Какому тегу соответствует коммит 85024d3?

коммиту 85024d3 соответствует тэг tag: v0.12.23

alegach@ubuntu:~/GitProject/terraform$ git show 85024d3
commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)
Author: tf-release-bot <terraform@hashicorp.com>
Date:   Thu Mar 5 20:56:10 2020 +0000

    v0.12.23

diff --git a/CHANGELOG.md b/CHANGELOG.md
index 1a9dcd0f9..faedc8bf4 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -1,4 +1,4 @@
-## 0.12.23 (Unreleased)
+## 0.12.23 (March 05, 2020)
 ## 0.12.22 (March 05, 2020)
 
 ENHANCEMENTS:
diff --git a/version/version.go b/version/version.go
index 33ac86f5d..bcb6394d2 100644
--- a/version/version.go
+++ b/version/version.go
@@ -16,7 +16,7 @@ var Version = "0.12.23"
 // A pre-release marker for the version. If this is "" (empty string)
 // then it means that it is a final release. Otherwise, this is a pre-release
 // such as "dev" (in development), "beta", "rc1", etc.
-var Prerelease = "dev"
+var Prerelease = ""
 
 // SemVer is an instance of version.Version. This has the secondary
 // benefit of verifying during tests and init time that our version is a

3. Сколько родителей у коммита b8d720? Напишите их хеши

У коммита 56cd7859e05c36c06b56d013b55a252d0bb7e158  2 родителя, которые были смержены  Merge: 56cd7859e 9ea88f22f

alegach@ubuntu:~/GitProject/terraform$ git show b8d720^
commit 56cd7859e05c36c06b56d013b55a252d0bb7e158 (HEAD)
Merge: 58dcac4b7 ffbcf5581
Author: Chris Griggs <cgriggs@hashicorp.com>
Date:   Mon Jan 13 13:19:09 2020 -0800

    Merge pull request #23857 from hashicorp/cgriggs01-stable
    
    [cherry-pick]add checkpoint links




alegach@ubuntu:~/GitProject/terraform$ git log b8d720 --graph
*   commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5
|\  Merge: 56cd7859e 9ea88f22f
| | Author: Chris Griggs <cgriggs@hashicorp.com>
| | Date:   Tue Jan 21 17:45:48 2020 -0800
| | 
| |     Merge pull request #23916 from hashicorp/cgriggs01-stable
| |     
| |     [Cherrypick] community links
| | 
| * commit 9ea88f22fc6269854151c571162c5bcf958bee2b
|/  Author: Chris Griggs <cgriggs@hashicorp.com>
|   Date:   Tue Jan 21 17:08:06 2020 -0800
|   
|       add/update community provider listings
|   
*   commit 56cd7859e05c36c06b56d013b55a252d0bb7e158 (HEAD)
|\  Merge: 58dcac4b7 ffbcf5581
| | Author: Chris Griggs <cgriggs@hashicorp.com>
| | Date:   Mon Jan 13 13:19:09 2020 -0800

4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

alegach@ubuntu:~/GitProject/terraform$ git log v0.12.23..v0.12.24 --oneline
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release


5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

alegach@ubuntu:~/GitProject/terraform$ git log -S 'providerSource'
commit 5e06e39fcc86bb622b962c87da84213d3331ddf8 (HEAD)
Author: findkim <kngo@hashicorp.com>
Date:   Wed Nov 28 10:26:16 2018 -0600

    Use registry alias to fetch providers

6. Найдите все коммиты в которых была изменена функция globalPluginDirs.

Не уверен, что сделал верно. Если что-то не так, подскажите плз :) Сначала погрепал функцию, далее выбрал файл, где присутствует globalPluginDirs т.е. plugins.go  (Это же файл?) и вызвал по нему лог

alegach@ubuntu:~/GitProject/terraform$ git grep 'globalPluginDirs'
commands.go:            GlobalPluginDirs: globalPluginDirs(),
commands.go:            available := pluginDiscovery.FindPlugins("credentials", globalPluginDirs())
config_unix.go:         // FIXME: homeDir gets called from globalPluginDirs during init, before
plugins.go:// globalPluginDirs returns directories that should be searched for
plugins.go:func globalPluginDirs() []string {

alegach@ubuntu:~/GitProject/terraform$ git log -L :'func globalPluginDirs':plugins.go --oneline
52dbf9483 keep .terraform.d/plugins for discovery

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -16,13 +16,14 @@
 func globalPluginDirs() []string {
        var ret []string
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
                machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
+               ret = append(ret, filepath.Join(dir, "plugins"))
                ret = append(ret, filepath.Join(dir, "plugins", machineDir))
        }
 
        return ret
 }
41ab0aef7 Add missing OS_ARCH dir to global plugin paths

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -14,12 +16,13 @@
 func globalPluginDirs() []string {
        var ret []string
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
-               ret = append(ret, filepath.Join(dir, "plugins"))
+               machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
+               ret = append(ret, filepath.Join(dir, "plugins", machineDir))
        }
 
        return ret
 }
66ebff90c move some more plugin search path logic to command

diff --git a/plugins.go b/plugins.go
--- a/plugins.go
+++ b/plugins.go
@@ -16,22 +14,12 @@
 func globalPluginDirs() []string {
        var ret []string
--
-       // Look in the same directory as the Terraform executable.
-       // If found, this replaces what we found in the config path.
-       exePath, err := osext.Executable()
-       if err != nil {
-               log.Printf("[ERROR] Error discovering exe directory: %s", err)
-       } else {
-               ret = append(ret, filepath.Dir(exePath))
-       }
-
        // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
        dir, err := ConfigDir()
        if err != nil {
                log.Printf("[ERROR] Error finding global config directory: %s", err)
        } else {
                ret = append(ret, filepath.Join(dir, "plugins"))
        }
 
        return ret
 }
8364383c3 Push plugin discovery down into command package

diff --git a/plugins.go b/plugins.go
--- /dev/null
+++ b/plugins.go
@@ -0,0 +16,22 @@
+func globalPluginDirs() []string {
+       var ret []string
+
+       // Look in the same directory as the Terraform executable.
+       // If found, this replaces what we found in the config path.
+       exePath, err := osext.Executable()
+       if err != nil {
+               log.Printf("[ERROR] Error discovering exe directory: %s", err)
+       } else {
+               ret = append(ret, filepath.Dir(exePath))
+       }
+
+       // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
+       dir, err := ConfigDir()
+       if err != nil {
+               log.Printf("[ERROR] Error finding global config directory: %s", err)
+       } else {
+               ret = append(ret, filepath.Join(dir, "plugins"))
+       }
+
+       return ret
+}

7. Кто автор функции synchronizedWriters?

alegach@ubuntu:~/GitProject/terraform$ git log -S 'func synchronizedWriter' --oneline
5ac311e2a main: synchronize writes to VT100-faker on Windows
alegach@ubuntu:~/GitProject/terraform$ git show 5ac311e2a
commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
Author: Martin Atkins <mart@degeneration.co.uk>



