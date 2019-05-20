# error-dashboard

This harvests some information from Honeybadger to populate a dashboard page

<img width="601" alt="screen shot 2018-03-06 at 1 15 08 pm" src="https://user-images.githubusercontent.com/92044/37052953-7e6a1db8-2140-11e8-9088-b7454224d733.png">


## Harvest:

```
cd harvester/
ruby honeybadger-harvest.rb <HB_API_KEY>
```

This produces `static/deploys.json` and `static/top-errors.json`.  These files
are the data that is read by the VueJS application.

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn run serve
```

### Compiles and minifies for production
```
yarn run build
```
### Run your tests
```
yarn run test
```

### Lints and fixes files
```
yarn run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
