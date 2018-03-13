<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <div v-for="(value, key) in json">
      <h2>{{ key }} </h2>
      <DeploySection :list="value"/>
    </div>
  </div>
</template>

<script>
import "relative-time-vue-component";
import DeploySection from './DeploySection'

export default {
  name: 'DeployList',
  components: {
    DeploySection
  },
  data () {
    return {
      json: null,
      msg: 'Last Deploy'
    }
  },
  created: function () {
    // `this` points to the vm instance
    fetch('/static/deploys.json')
      .then(function (response) {
        return response.json()
      })
      .then((myJson) => {
        this.json = myJson
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
