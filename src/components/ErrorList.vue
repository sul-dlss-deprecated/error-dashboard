/* eslint-disable */
<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <div v-for="(value, key) in json">
      <h2>{{ key }} </h2>

      <table>
        <tr v-for="item in value">
          <td class="number">{{item.notices_count}}</td>
          <td>{{item.project_name}}</td>
          <td>{{item.klass}}</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ErrorList',
  data () {
    return {
      json: null,
      msg: 'Top errors'
    }
  },
  created: function () {
    // `this` points to the vm instance
    fetch('/static/top-errors.json')
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
