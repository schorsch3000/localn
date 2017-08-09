# localn
install and use node versions per project

## usage

`$(localn init)` 
to set your path

`localn 4.3.0` 
to install and use a specific version

`localn lts` 
to install and use the last lts release version

`localn stable` 
to install and use the last stable release version

`localn latest` 
to install and use the last (maybe unstable) release version

`localn install`
to install the highest possible node version matching .engines.node of the package.json in path 

works best with direnv


