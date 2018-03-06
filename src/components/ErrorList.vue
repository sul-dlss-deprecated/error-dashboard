<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <table>
      <tr v-for="item in json">
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
      msg: 'Top errors'
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log('json is: ' + this.json)
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
h1, h2 {
  font-weight: normal;
  text-align: center;
}
table {
  width: 45vw;
  margin-left: auto;
  margin-right: auto;
  border-collapse: collapse;
}

td {
  padding: .75rem;
  border-top: 1px solid #dee2e6;
}

.number {
  text-align: right;
}

a {
  color: #42b983;
}
</style>
