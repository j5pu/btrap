[task](https://github.com/go-task/task)
1. Acabar con la mierda de aprender getopts
2. Acabar con el config de variables de profile (estaba con los directorios)
3. Instalar la puta maquina de gcloud.
4. Instalar el Buildkit/BuildKits para ir probando.
5. Como usar lo que he descargado de plugins.
6. Ver que en el usuario backup tengo la contraseña en contenedor que he creado para authpass

estaba con el docker para probar el vars y me fui a generar la imagen de docker con el build kit y decidir crear un servidor
Acabe en google y como queria ir a mirar la ssh y tener los tokens organice el profile.d con secrets etc.

[install docker buildx hace mas que docker buildkit y pone DOCKER_BUILDKIT=1 for  native command](https://docs.docker.com/buildx/working-with-buildx/)
Tiene:
- build for target platforms 
- buildkit 
- outputs configuration, 
- inline build cache 
- docker buildx bake: similar a docker-compose build 
- 
Asi que tengo que:
- Mover las constantes.
- Mirar el servidor de google crearlo y plugins y si hay paquete de pypi para manejar y cli.
- ir instalando hay primero lo que pruebo antes de tener docker.
- queria mirar los host que puse en profile.d y me fui a lo de fabric o no se que en los grupos de tabs en google.
- (tendre que hacer al final lo de que se autoactualice el repo con la config)
- lo de bajar los secretos de gityhub y subirlos al repo de btrap. 
- y como volvi a la ssh key me fui a ver si con keychain se puede sacar la ssh_key de icloud (al final igual lo mejor seria bajar con pyicloud la ssh key y a tomar por culo si no la tengo con el btrap profile y lo mismo en remoto)
- tengo pendiente lo de los argumentos de profile de instalar y upgrade
- acabar con ls opciones y argumentos para pasar a poner las funciones de git etc.

- las funciones de auto version o latest que habia hecho para el tap 
- el critic. 
- ahora me he dsviado a la mierda del ebuild 
- Me quede con que deberia mirar el bash arguments 
- [y mola a lo meor el scrollable-tabstrip ya que parece facil](https://github.com/anas-p/Save-To-iCloud-Drive)
- [o este](https://github.com/farnots/iCloudDownloader/blob/master/iCloudDownlader/Downloader.swift)
igual combinarklo con poner un dominio en la app de antes de coger las contraseñas. o si hago la de la contraseña. 
- y le doy poderes la coge de keychain pero entonces tengo que tener baada la app.
- [tiene ejemplo de keychain access](https://github.com/kishikawakatsumi/KeychainAccess)
- [otra app pero a las apps hay que darles permisos en TCC a mano ya apple script tambien o sea que mejor sera tener una app en docs y que la pueda baar con pyicloud](https://github.com/evgenyneu/keychain-swift)
y si uso el ansible vault para las credeciales y los secretos?
- [y si el strong box o la otra de la app store tambien crean doc y no cloudcoc asi esta en ambos lados](https://github.com/strongbox-password-safe/Strongbox/issues/409)
- [esta de appstore igual tiene para guardar fichero en un dominio icloud y leer de icloud keychain](https://github.com/authpass/authpass)
- [parece buena par alamacenar y sacar credentailes y viene jemplo de como usarla como dependencia](https://github.com/kishikawakatsumi/UICKeyChainStore)

si miro lo de que el install de la ssh key sea en local en base al host

[shallow-backup](https://github.com/alichtman/shallow-backup)
[dotdrop](https://github.com/deadc0de6/dotdrop)

[esta se ha comido al cider](https://github.com/zero-sh/zero.sh)
[cider el que tenia usr defaults de swift tiene uno bueno de l tag del paquete antes de subirlo el suyo](https://pypi.org/project/cider/)
https://github.com/TheCleric/ppsetuptools para usar pyproject.toml 

## [prefsniff](https://pypi.org/project/prefsniff/)
Se podria hacer un loop que escribiera todo lo que saca de todos y guardara en fichero. solo sacadefaults por fichero.

tengoq ue repasar las cosas en hacia en bootstrap de macos de cuarentena etc y los settings con comando.
y ficheros de parametros (para eso estaba bien el que tenía swift !!!!!! mirarlo en el examples o en scratches si aun lo tengo )

el sheldon para los plugins no se yo si usarlo que hace el clone 

quickmenu en el la nueva maquina de google para tener mac y linux no crearlo


maneja https://docs.python.org/3.7/library/plistlib.html#module-plistlib directamente python 

