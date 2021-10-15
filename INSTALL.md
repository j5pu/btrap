# Install

## Btrap

### Apple Store

#### [Strongbox](https://github.com/strongbox-password-safe/Strongbox)

A KeePass/Password Safe Client for iOS and OS X.

#### [authpass](https://github.com/authpass/authpass)

Open Source Password Manager for mobile and desktop.
Password Manager based on Flutter for all platforms. Keepass 2.x (kdbx 3.x) compatible.

### Brew

#### [apt-dater](https://github.com/DE-IBH/apt-dater)

Manage apt remotely.

#### [git-crypt](https://github.com/AGWA/git-crypt.git)

Transparent file encryption in git.

#### [nativefier](https://github.com/nativefier/nativefier.git)

Generate macOS app from link.

#### [swiftbar](https://github.com/swiftbar/SwiftBar.git)

Menu bar actions, for instance: open atom-icon-associations.xml or build.

#### [envv](https://github.com/jakewendt/envv)

Envv is a shell-independent way of handling environment variables.

### Download

#### [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/)

- build for target platforms.
- buildkit.
- outputs configuration.
- inline build cache.
- docker buildx bake: similar a docker-compose build.

#### [quickemu](https://github.com/wimpysworld/quickemu)

Quickly create and run optimised Windows, macOS and Linux desktop virtual machines.

### pip

#### [prefsniff](https://pypi.org/project/prefsniff)

Generate defaults commands for macOS.

````bash
prefsniff /Users/jose/Library/Preferences/.GlobalPreferences.plist
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool False
prefsniff /Users/jose/Library/Preferences --show-diffs
````

## Dotfiles

### Brew

#### [watchman](https://facebook.github.io/watchman/)

Watches files and records, or triggers actions, when they change.

#### [rcm](https://github.com/thoughtbot/rcm)

Management suite for dotfiles (allows users and hosts/os).

#### [shallow-backup](https://github.com/alichtman/shallow-backup)

Create lightweight backups of installed packages, applications, fonts and dotfiles, and automatically
push them to a remote Git repository.

### [zero.sh](https://github.com/zero-sh/zero.sh)

Create an identical installation on any **macOS** with a single command.
Replaces [cider](https://github.com/msanders/cider) which used `swift` for preferences.

### pip

#### [dotdrop](https://github.com/deadc0de6/dotdrop)

It allows you to store your dotfiles in Git and automagically deploy **different versions**
of the same file on different setups.

## Tasks

### Brew

#### [task](https://github.com/go-task/task)

It has releaser for debian and taps.

### pip

### [batou](https://github.com/flyingcircusio/batou)

Automate your application deployments.

### [prefect](https://github.com/PrefectHQ/prefect)

A new workflow management system, designed for modern infrastructure and powered by
the open-source Prefect Core workflow engine.
Users organize Tasks into Flows, and Prefect takes care of the rest.

#### [python-decouple](https://github.com/henriquebastos/python-decouple)

Strict separation of config from code.
Helps you to organize your settings so that you can change parameters without having to redeploy your app.

#### [taskipy](https://pypi.org/project/taskipy)

`task` conflicts with `brew go-task` which install `task`.
Complementary task runner for python, defines tasks in `pyproyect.toml`.

## Xcode

### [Save-To-iCloud-Drive](https://github.com/anas-p/Save-To-iCloud-Drive)

Save a document to iCloud drive.

### [iCloudDownloader](https://github.com/farnots/iCloudDownloader)

This is a simple CLI interface for fetching file and folder from the iCloud Storage (brctl).
Look at: [Downloader.swift](https://github.com/farnots/iCloudDownloader/blob/master/iCloudDownlader/Downloader.swift)

### [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

Simple Swift wrapper for Keychain that works on iOS, watchOS, tvOS and macOS.
[It uses the one on following section](https://github.com/kishikawakatsumi/UICKeyChainStore)

### [UICKeyChainStore](https://github.com/kishikawakatsumi/UICKeyChainStore)

UICKeyChainStore is a simple wrapper for Keychain on iOS, watchOS, tvOS and macOS. Makes using
Keychain APIs as easy as NSUserDefaults.
[It is used by the one on previous section](https://github.com/kishikawakatsumi/KeychainAccess)

## Other

### [niet](https://github.com/openuado/niet)

Parse/Read yaml or json files directly in your shell (sh, bash, ksh, ...).

### [pieces](https://code.pieces.app/install)

Snippets

### [ppsetuptools](https://github.com/TheCleric/ppsetuptools)

Metadata in `pyproyect.toml`.

### [pyicloud](https://github.com/picklepete/pyicloud)

PyiCloud is a module which allows pythonistas to interact with iCloud webservices. It's powered by the fantastic [requests](https://github.com/kennethreitz/requests) HTTP library.

### [quickmenu](https://github.com/wimpysworld/quickemu)

Quickly create and run optimised Windows, macOS and Linux desktop virtual machines.

### [sarge](https://sarge.readthedocs.io/en/latest/overview.html)

Subprocess.

### [sheldon](https://sheldon.cli.rs/Examples.html)

Fast, configurable, command-line tool to manage your shell plugins.

## From my legacy

### Access

`/Users/jose/backups/data/Applications/Access.app/Contents/MacOS/Access`

## ToDo

* [git-sync](https://github.com/kubernetes/git-sync) mirar el git-sync y que genera las imagenes con docker buildx
* [has](https://hub.docker.com/r/kdabir/has-test-containers) como sincroniza los contenedores de GitHub con DockerHub.
* hacer los tests de etc e ir desarrollando uno a uno y que se actualice el setup.cfg.
* mirar si uso el makefile o el prefect o el taskipy o el task-go
* el getopt
* [man](https://docs.asciidoctor.org/asciidoctor/latest/manpage-backend/) colores y referencias y [color en map](https://felipec.wordpress.com/2021/06/05/adventures-with-man-color/)
* help/usage con man page de los scripts que estoy usando. hacer un script que sea de grep e los atributos y que pruebe primero si tiene man y luego si tiene --help.
