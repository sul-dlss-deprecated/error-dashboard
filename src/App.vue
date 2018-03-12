<template>
  <div id="app">
    <ErrorList/>
    <DeployList/>
  </div>
</template>

<script>
import ErrorList from './components/ErrorList'
import DeployList from './components/DeployList'

export default {
  name: 'App',
  components: {
    ErrorList,
    DeployList
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
