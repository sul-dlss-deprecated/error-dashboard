<template>
  <div id="app">
    <ErrorList/>
  </div>
</template>

<script>
import ErrorList from './components/ErrorList'

export default {
  name: 'App',
  components: {
    ErrorList
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
