<template>
  <div class="hello">
    <div class="filters">
      <input type="radio" v-model="filter" value="infrastructure"> Infrastructure
      <input type="radio" v-model="filter" value="access"> Access
      <input type="radio" v-model="filter" value="unassigned"> Unassigned
    </div>

    <DeploySection :list="items"/>
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
      filter: 'infrastructure',
      json: null,
      msg: 'Last Deploy'
    }
  },
  computed: {
    items: function() {
      if (this.json == null)
        return []
      return this.json[this.filter];
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
