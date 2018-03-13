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

h1, h2 {
  font-weight: normal;
  text-align: center;
}
table {
  min-width: 38em;
  width: 50vw;
  margin-left: auto;
  margin-right: auto;
  border-collapse: collapse;
}

td {
  padding: .75rem;
  border-top: 1px solid #dee2e6;
}

a {
  color: #42b983;
}
</style>
