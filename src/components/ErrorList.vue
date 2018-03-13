/* eslint-disable */
<template>
  <div class="hello">
    <div class="filters">
      <input type="radio" v-model="filter" value="infrastructure"> Infrastructure
      <input type="radio" v-model="filter" value="access"> Access
      <input type="radio" v-model="filter" value="unassigned"> Unassigned
    </div>

      <table>
        <tr v-for="item in json[filter]">
          <td class="number">{{item.notices_count}}</td>
          <td>{{item.project_name}}</td>
          <td>{{item.klass}}</td>
        </tr>
      </table>
  </div>
</template>

<script>
export default {
  name: 'ErrorList',
  data () {
    return {
      json: null,
      filter: 'infrastructure',
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

  .number {
    text-align: right;
  }
</style>
